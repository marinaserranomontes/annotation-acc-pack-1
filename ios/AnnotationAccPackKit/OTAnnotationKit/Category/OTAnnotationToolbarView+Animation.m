//
//  OTAnnotationToolbarView+Animation.m
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import "OTAnnotationToolbarView+Animation.h"
#import "OTAnnotationToolbarView_UserInterfaces.h"
#import "Constants.h"

@implementation OTAnnotationToolbarView (Animation)

- (void)moveSelectionShadowViewTo:(UIButton *)sender {
    
    [self setUserInteractionEnabled:NO];
    if (![sender isKindOfClass:[UIButton class]]) {
        [self.selectionShadowView removeFromSuperview];
        return;
    }
    
    CGRect holderViewFrame = sender.superview.frame;
    CGRect hodlerViewBounds = sender.superview.bounds;
    self.selectionShadowView.frame = CGRectMake(holderViewFrame.origin.x, holderViewFrame.origin.y, CGRectGetWidth(hodlerViewBounds), CGRectGetHeight(hodlerViewBounds));
    [self insertSubview:self.selectionShadowView atIndex:0];
    [self setUserInteractionEnabled:YES];
}

- (void)showColorPickerView {
    
    if (!self.colorPickerView.superview) {
        CGRect selfFrame = self.frame;
        self.colorPickerView.frame = selfFrame;
        [self.superview insertSubview:self.colorPickerView belowSubview:self];
        [UIView animateWithDuration:1.0 animations:^(){
            
//            CGFloat newY = selfFrame.origin.y - HeightOfColorPicker + GapOfToolBarAndColorPicker
            CGFloat newY = selfFrame.origin.y - HeightOfColorPicker;
            self.colorPickerView.frame = CGRectMake(selfFrame.origin.x, newY, CGRectGetWidth(self.bounds), HeightOfColorPicker);
        }];
    }
    else {
        [self dismissColorPickerView];
    }
}

- (void)dismissColorPickerView {

    CGRect colorPickerViewFrame = self.colorPickerView.frame;
    [UIView animateWithDuration:1.0 animations:^(){
        
//        CGFloat newY = colorPickerViewFrame.origin.y + HeightOfColorPicker + GapOfToolBarAndColorPicker;
        CGFloat newY = colorPickerViewFrame.origin.y + HeightOfColorPicker;
        self.colorPickerView.frame = CGRectMake(0, newY, CGRectGetWidth(colorPickerViewFrame), HeightOfColorPicker);
    } completion:^(BOOL finished){
        
        [self.colorPickerView removeFromSuperview];
    }];
}

@end
