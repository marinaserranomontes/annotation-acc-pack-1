//
//  OTAnnotationToolbarButton.m
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import "OTAnnotationToolbarButton.h"
#import "UIButton+AutoLayoutHelper.h"
#import "UIView+Helper.h"

@implementation OTAnnotationToolbarButton

- (instancetype)init {
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    super.enabled = enabled;
    
    if (enabled) {
        [self setAlpha:1.0];
    }
    else {
        [self setAlpha:0.6];
    }
}

- (void)didMoveToSuperview {
    if (!self.superview) return;
    [self addCenterConstraints];
}

@end


@implementation OTAnnotationToolbarDoneButton

- (instancetype)init {
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!self.superview) return;
    [self addAttachedLayoutConstantsToSuperview];
}

@end
