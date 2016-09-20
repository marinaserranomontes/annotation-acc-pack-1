//
//  OTAnnotationToolbarView.h
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OTAnnotationToolbarView;
@protocol OTAnnotationToolbarViewDataSource <NSObject>
- (UIView *)annotationToolbarViewForRootViewForScreenShot:(OTAnnotationToolbarView *)toolbarView;
@end

@protocol OTAnnotationToolbarViewDelegate <NSObject>
- (void)annotationToolbarView:(OTAnnotationToolbarView *)toolbarView didPressToolbarViewItemButtonAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface OTAnnotationToolbarView : UIView

@property (weak, nonatomic) id<OTAnnotationToolbarViewDataSource> toolbarViewDataSource;

@property (weak, nonatomic) id<OTAnnotationToolbarViewDelegate> toolbarViewDelegate;

@end
