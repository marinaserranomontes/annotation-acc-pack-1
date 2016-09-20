//
//  ReceiveAnnotationViewController.m
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import "ReceiveAnnotationViewController.h"
#import <OTAnnotationKit/OTAnnotationKit.h>
#import <OTScreenShareKit/OTScreenShareKit.h>

@interface ReceiveAnnotationViewController () <AnnotationDelegate>
@property (nonatomic) OTAnnotator *annotator;
@property (nonatomic) OTScreenSharer *sharer;
@end

@implementation ReceiveAnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharer = [OTScreenSharer sharedInstance];
    [self.sharer connectWithView:[UIApplication sharedApplication].keyWindow.rootViewController.view
                         handler:^(ScreenShareSignal signal, NSError *error) {
                             
                             if (!error) {
                                 
                                 if (signal == ScreenShareSignalSessionDidConnect) {
                                     self.sharer.publishAudio = NO;
                                     self.sharer.subscribeToAudio = NO;
                                 }
                                 else if (signal == ScreenShareSignalSubscriberConnect) {
                                     
                                 }
                             }
                         }];
    
    self.annotator = [[OTAnnotator alloc] init];
    self.annotator.delegate = self;
    [self.annotator connectForReceivingAnnotation];
}

- (void)annotationWithSignal:(OTAnnotationSignal)signal
                       error:(NSError *)error {
    
    if (signal == OTAnnotationSessionDidConnect){
        [self.view addSubview:self.annotator.annotationView];
    }
}

@end
