//
//  OTFullScreenAnnotationViewController.m
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import "OTFullScreenAnnotationViewController.h"
#import "OTAnnotationScrollView.h"
#import "OTAnnotationScrollView_Private.h"

@interface OTFullScreenAnnotationViewController () <OTAnnotationToolbarViewDataSource>

@end

@implementation OTFullScreenAnnotationViewController

- (instancetype)init {
    
    if (self = [super init]) {
        
        OTAnnotationScrollView *annotationView = [[OTAnnotationScrollView alloc] init];
        annotationView.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds),
                                                            CGRectGetHeight([UIScreen mainScreen].bounds) - 50);
        [annotationView initializeToolbarView];
        CGFloat height = annotationView.toolbarView.bounds.size.height;
        annotationView.toolbarView.translatesAutoresizingMaskIntoConstraints = NO;
        annotationView.toolbarView.toolbarViewDataSource = self;
        
        [self.view addSubview:annotationView];
        [self.view addSubview:annotationView.toolbarView];
        
        [NSLayoutConstraint constraintWithItem:annotationView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.topLayoutGuide
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        
        [NSLayoutConstraint constraintWithItem:annotationView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        
        [NSLayoutConstraint constraintWithItem:annotationView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        
        [NSLayoutConstraint constraintWithItem:annotationView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:annotationView.toolbarView
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:height].active = YES;
        
        [NSLayoutConstraint constraintWithItem:annotationView.toolbarView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        
        [NSLayoutConstraint constraintWithItem:annotationView.toolbarView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        
        [NSLayoutConstraint constraintWithItem:annotationView.toolbarView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        
        [NSLayoutConstraint constraintWithItem:annotationView.toolbarView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:height].active = YES;
        
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

#pragma mark - OTAnnotationToolbarViewDataSource
- (UIView *)annotationToolbarViewForRootViewForScreenShot:(OTAnnotationToolbarView *)toolbarView {
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

@end
