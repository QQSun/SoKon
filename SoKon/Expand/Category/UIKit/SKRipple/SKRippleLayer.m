//
//  SKRippleLayer.m
//  SoKon
//
//  Created by nachuan on 16/6/30.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKRippleLayer.h"

@implementation SKRippleLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rippleOpaque        = 1;
        _rippleDuration      = 2.0f;
        _rippleMaxRadius     = 20;
        self.frame           = CGRectMake(0, 0, 2 * _rippleMaxRadius, 2 * _rippleMaxRadius);
        self.cornerRadius    = _rippleMaxRadius;
        self.masksToBounds   = YES;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:_rippleOpaque].CGColor;
        [self addAnimation];
    }
    return self;
}

- (void)addAnimation
{
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CAAnimationGroup *animationGroup       = [CAAnimationGroup animation];
    animationGroup.timingFunction          = timingFunction;
    animationGroup.duration                = 2.0f;
    animationGroup.repeatCount             = 30;
    animationGroup.removedOnCompletion     = YES;

    CABasicAnimation *scaleAnimation       = [CABasicAnimation animation];
    scaleAnimation.keyPath                 = @"transform.scale";
    scaleAnimation.fromValue               = @0.001;
    scaleAnimation.toValue                 = @(kScreenWidth / 2 / _rippleMaxRadius);
    scaleAnimation.duration                = 2.0f;
    scaleAnimation.removedOnCompletion     = YES;
    
    CAKeyframeAnimation *opacityAnimation  = [CAKeyframeAnimation animation];
    opacityAnimation.keyPath               = @"opacity";
    opacityAnimation.duration              = 2.0;
    opacityAnimation.values                = @[@0.8, @0.6, @0.0];
    opacityAnimation.keyTimes              = @[@0, @0.4, @1.0];
    opacityAnimation.removedOnCompletion   = YES;
    
    animationGroup.animations              = @[scaleAnimation, opacityAnimation];

    [self addAnimation:animationGroup forKey:@"animationGroup"];
    [self performSelector:@selector(removeFromSuperlayer:) withObject:self afterDelay:149.99];
}

- (void)removeFromSuperlayer:(SKRippleLayer *)layer
{
    [layer removeFromSuperlayer];
}

@end
