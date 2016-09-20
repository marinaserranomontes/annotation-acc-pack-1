//
//  OTAnnotator.m
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import <OTAcceleratorPackUtil/OTAcceleratorPackUtil.h>
#import "OTAnnotator.h"
#import "JSON.h"

@interface OTAnnotator() <OTSessionDelegate, OTAnnotationViewDelegate>
@property (nonatomic) BOOL receiveAnnotationEnabled;
@property (nonatomic) BOOL sendAnnotationEnabled;

@property (nonatomic) OTAnnotationView *annotationView;
@property (nonatomic) OTAcceleratorSession *session;
@property (strong, nonatomic) OTAnnotationBlock handler;

@end

@implementation OTAnnotator

+ (void)setOpenTokApiKey:(NSString *)apiKey
               sessionId:(NSString *)sessionId
                   token:(NSString *)token {
    
    [OTAcceleratorSession setOpenTokApiKey:apiKey sessionId:sessionId token:token];
}

- (instancetype)init {
    if (self = [super init]) {
        _session = [OTAcceleratorSession getAcceleratorPackSession];
    }
    return self;
}

- (NSError *)connect {
    if (!self.delegate && !self.handler) return nil;
    
    return [OTAcceleratorSession registerWithAccePack:self];
}

- (void)connectWithHandler:(OTAnnotationBlock)handler {
    self.handler = handler;
    [self connect];
}

- (NSError *)connectForReceivingAnnotation {
    _receiveAnnotationEnabled = YES;
    _sendAnnotationEnabled = NO;
    return [self connect];
}

- (NSError *)connectForSendingAnnotation {
    _receiveAnnotationEnabled = NO;
    _sendAnnotationEnabled = YES;
    return [self connect];
}

- (void)connectForReceivingAnnotationWithHandler:(OTAnnotationBlock)handler {
    _receiveAnnotationEnabled = YES;
    _sendAnnotationEnabled = NO;
    [self connectWithHandler:handler];
}

- (void)connectForSendingAnnotationWithHandler:(OTAnnotationBlock)handler {
    _receiveAnnotationEnabled = NO;
    _sendAnnotationEnabled = YES;
    [self connectWithHandler:handler];
}

- (NSError *)disconnect {
    
    return [OTAcceleratorSession deregisterWithAccePack:self];
}

- (void)notifiyAllWithSignal:(OTAnnotationSignal)signal error:(NSError *)error {
    
    if (self.handler) {
        self.handler(signal, error);
    }
    
    if (self.delegate) {
        [self.delegate annotationWithSignal:signal error:error];
    }
}

- (void) sessionDidConnect:(OTSession *)session {
    self.annotationView = [[OTAnnotationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.annotationView.annotationViewDelegate = self;
    [self.annotationView setCurrentAnnotatable:[OTAnnotationPath pathWithStrokeColor:nil]];
    [self notifiyAllWithSignal:OTAnnotationSessionDidConnect
                         error:nil];
}

- (void) sessionDidDisconnect:(OTSession *)session {
    self.annotationView = nil;
    
    [self notifiyAllWithSignal:OTAnnotationSessionDidDisconnect
                         error:nil];
}

- (void)session:(OTSession *)session streamCreated:(OTStream *)stream {}

- (void)session:(OTSession *)session streamDestroyed:(OTStream *)stream {}

- (void)session:(OTSession *)session didFailWithError:(OTError *)error {
    [self notifiyAllWithSignal:OTAnnotationSessionDidFail
                         error:error];
}

// OPENTOK SIGNALING
- (void)session:(OTSession*)session
receivedSignalType:(NSString*)type
 fromConnection:(OTConnection*)connection
     withString:(NSString*)string {

    // TODO: continue here
    if (self.receiveAnnotationEnabled &&
        self.session.sessionConnectionStatus == OTSessionConnectionStatusConnected &&
        ![self.session.connection.connectionId isEqualToString:connection.connectionId]) {
        
        if (!self.annotationView.currentAnnotatable) {
            self.annotationView.currentAnnotatable = [OTAnnotationPath pathWithStrokeColor:[UIColor blueColor]];
        }
        
        NSArray *jsonArray = [JSON parseJSON:string];
        for (NSDictionary *json in jsonArray) {
            if ([self.annotationView.currentAnnotatable isKindOfClass:[OTAnnotationPath class]]) {
                
                if (!self.annotationView.currentAnnotatable) {
                    self.annotationView.currentAnnotatable = [OTAnnotationPath pathWithStrokeColor:nil];
                }
                
                // canvas x and y
                CGFloat canvasWidth = [json[@"canvasWidth"] floatValue];
                CGFloat canvasHeight = [json[@"canvasHeight"] floatValue];
                
                // apply scale factor
                CGFloat scale = 1.0f;
                if (CGRectGetWidth(self.annotationView.bounds) < CGRectGetHeight(self.annotationView.bounds)) {
                    scale = CGRectGetHeight(self.annotationView.bounds) / canvasHeight;
                }
                else if (CGRectGetWidth(self.annotationView.bounds) > CGRectGetHeight(self.annotationView.bounds)) {
                    scale = CGRectGetWidth(self.annotationView.bounds) / canvasWidth;
                }
                
                CGFloat canvasCenterX = canvasWidth / 2.0f * scale;
                CGFloat canvasCenterY = canvasHeight / 2.0f * scale;
                
                // remote x and y
                CGFloat fromX = [json[@"fromX"] floatValue] * scale;
                CGFloat fromY = [json[@"fromY"] floatValue] * scale;
                CGFloat toX = [json[@"toX"] floatValue] * scale;
                CGFloat toY = [json[@"toY"] floatValue] * scale;
                
                OTAnnotationPoint *pt1;
                OTAnnotationPoint *pt2;
                
                if (CGRectGetHeight(self.annotationView.bounds) >= CGRectGetWidth(self.annotationView.bounds)) {
                    CGFloat actualDrawingFromX = fromX - (canvasCenterX - self.annotationView.center.x);
                    CGFloat actualDrawingToX = toX - (canvasCenterX - self.annotationView.center.x);
                    pt1 = [OTAnnotationPoint pointWithX:actualDrawingFromX andY:fromY];
                    pt2 = [OTAnnotationPoint pointWithX:actualDrawingToX andY:toY];
                }
                else {
                    CGFloat actualDrawingFromY = fromY - (canvasCenterY - self.annotationView.center.y);
                    CGFloat actualDrawingToY = toY - (canvasCenterY - self.annotationView.center.y);
                    pt1 = [OTAnnotationPoint pointWithX:fromX andY:actualDrawingFromY];
                    pt2 = [OTAnnotationPoint pointWithX:toX andY:actualDrawingToY];
                }
                
                OTAnnotationPath *path = (OTAnnotationPath *)self.annotationView.currentAnnotatable;
                if (path.points.count == 0) {
                    [path startAtPoint:pt1];
                    [path drawToPoint:pt2];
                }
                else {
                    [path drawToPoint:pt1];
                    [path drawToPoint:pt2];
                }
            
                if ([json[@"endPoint"] boolValue]) {
                    [self.annotationView commitCurrentAnnotatable];
                    self.annotationView.currentAnnotatable = [OTAnnotationPath pathWithStrokeColor:[UIColor blueColor]];
                }
            }
        }
    }
}

#pragma mark - OTAnnotationViewDelegate

- (void)annotationView:(OTAnnotationView *)annotationView
            touchBegan:(UITouch *)touch
             withEvent:(UIEvent *)event {
    [self signalAnnotatble:annotationView.currentAnnotatable touch:touch addtionalInfo:@{@"startPoint":@(YES)}];
}

- (void)annotationView:(OTAnnotationView *)annotationView
            touchMoved:(UITouch *)touch
             withEvent:(UIEvent *)event {
    [self signalAnnotatble:annotationView.currentAnnotatable touch:touch addtionalInfo:nil];
}

- (void)annotationView:(OTAnnotationView *)annotationView
            touchEnded:(UITouch *)touch
             withEvent:(UIEvent *)event {
    [self signalAnnotatble:annotationView.currentAnnotatable touch:touch addtionalInfo:@{@"endPoint":@(YES)}];
}

- (void)signalAnnotatble:(id<OTAnnotatable>)annotatble
                   touch:(UITouch *)touch
           addtionalInfo:(NSDictionary *)info{
    
    if ([annotatble isKindOfClass:[OTAnnotationPath class]]) {
        
        CGPoint touchPoint = [touch locationInView:touch.view];
        
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:info];
        paramDict[@"id"] = self.session.connection.connectionId;
        paramDict[@"fromId"] = self.session.connection.connectionId;
        paramDict[@"fromX"] = @(touchPoint.x);
        paramDict[@"fromY"] = @(touchPoint.y);
        paramDict[@"toX"] = @(touchPoint.x + 0.1);
        paramDict[@"toY"] = @(touchPoint.y + 0.1);
        paramDict[@"lineWidth"] = @(10);
        paramDict[@"videoWidth"] = @(CGRectGetWidth(self.annotationView.bounds));
        paramDict[@"videoHeight"] = @(CGRectGetHeight(self.annotationView.bounds));
        paramDict[@"canvasWidth"] = @(CGRectGetWidth(self.annotationView.bounds));
        paramDict[@"canvasHeight"] = @(CGRectGetHeight(self.annotationView.bounds));
        paramDict[@"mirrored"] = @(NO);
        paramDict[@"smoothed"] = @(NO);
        
        NSString *jsonString = [JSON stringify:@[paramDict]];
        NSError *error;
        [[OTAcceleratorSession getAcceleratorPackSession] signalWithType:@"testing" string:jsonString connection:nil error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    }
}

@end
