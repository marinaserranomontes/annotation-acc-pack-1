//
//  ScreenSharePath.m
//
//  Copyright © 2016 Tokbox. All rights reserved.
//

#import "OTAnnotationPath.h"

@interface OTAnnotationPoint()
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGPoint point;
@end

@implementation OTAnnotationPoint

+ (instancetype)pointWithX:(CGFloat)x andY:(CGFloat)y {
    OTAnnotationPoint *pt = [[OTAnnotationPoint alloc] init];
    pt.x = x;
    pt.y = y;
    return pt;
}

- (CGPoint)cgPoint {
    return CGPointMake(_x, _y);
}
@end

@interface OTAnnotationPath()
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) NSMutableArray<OTAnnotationPoint *> *mutablePoints;
@end

@implementation OTAnnotationPath

- (NSArray<OTAnnotationPoint *> *)points {
    return [_mutablePoints copy];
}

- (instancetype)initWithStrokeColor:(UIColor *)strokeColor {
    
    if (self = [super init]) {
        _mutablePoints = [[NSMutableArray alloc] init];
        _strokeColor = strokeColor;
        _uuid = [NSUUID UUID].UUIDString;
        self.lineWidth = 3.0f;
    }
    return self;
}

- (instancetype)initWithPoints:(NSArray<OTAnnotationPoint *> *)points
                   strokeColor:(UIColor *)strokeColor {
    
    if (self = [super init]) {
        _mutablePoints = [[NSMutableArray alloc] initWithArray:points];
        _strokeColor = strokeColor;
        _uuid = [NSUUID UUID].UUIDString;
        self.lineWidth = 3.0f;
        
        OTAnnotationPoint *startPoint = [points firstObject];
        OTAnnotationPoint *endPoint = [points lastObject];
        _startPoint = CGPointMake(startPoint.x, startPoint.y);
        _endPoint = CGPointMake(endPoint.x, endPoint.y);
    }
    return self;
}

- (void)drawWholePath {
    
    OTAnnotationPoint *firstPoint = [self.points firstObject];
    
    [self moveToPoint:[firstPoint cgPoint]];
    for (NSUInteger i = 1; i < self.points.count - 1; i++) {
        OTAnnotationPoint *thisPoint = self.points[i];
        [self addLineToPoint:[thisPoint cgPoint]];
    }
    
    OTAnnotationPoint *lastPoint = [self.points lastObject];
    [self addLineToPoint:[lastPoint cgPoint]];
}

- (void)startAtPoint:(OTAnnotationPoint *)point {
    
    CGPoint cgPoint = [point cgPoint];
    [self moveToPoint:cgPoint];
    [self addPoint:point];
}

- (void)drawToPoint:(OTAnnotationPoint *)point {
    
    CGPoint cgPoint = [point cgPoint];
    [self addLineToPoint:cgPoint];
    [self addPoint:point];
}

- (void)drawCurveTo:(OTAnnotationPoint*)toThePoint  from:(OTAnnotationPoint*)fromThePoint{
    
    CGPoint fromPoint = [fromThePoint cgPoint];
    CGPoint toPoint = [toThePoint cgPoint];
    CGPoint controlPoint = CGPointMake((fromPoint.x + toPoint.x) / 2, (fromPoint.y + toPoint.y) / 2);
    
    [self addQuadCurveToPoint:controlPoint controlPoint:fromPoint];
    
    [self addPoint:toThePoint];

}

#pragma mark - private method
- (void)addPoint:(OTAnnotationPoint *)touchPoint {
    if (_mutablePoints.count == 0) {
        _startPoint = [touchPoint cgPoint];
    }
    [_mutablePoints addObject:touchPoint];
    _endPoint = [touchPoint cgPoint];
}
@end

#pragma mark - OTRemoteAnnotationPath
@interface OTRemoteAnnotationPath()
@property (nonatomic) NSString *remoteGUID;
@end

@implementation OTRemoteAnnotationPath

- (instancetype)initWithStrokeColor:(UIColor *)strokeColor
                         remoteGUID:(NSString *)remoteGUID {
    
    if (self = [super initWithStrokeColor:strokeColor]) {
        _remoteGUID = remoteGUID;
    }
    return self;
}

@end
