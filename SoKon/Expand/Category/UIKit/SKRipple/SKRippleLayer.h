//
//  SKRippleLayer.h
//  SoKon
//
//  Created by nachuan on 16/6/30.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SKRippleLayer : CALayer

/** 波纹动画时长 默认2s*/
@property (nonatomic, assign) CGFloat rippleDuration;

/** 波纹透明度  0.0完全透明  1.0不透明(默认值) */
@property (nonatomic, assign) CGFloat rippleOpaque;

/** 波纹最大半径 默认20*/
@property (nonatomic, assign) NSInteger rippleMaxRadius;

/** 波纹颜色 默认白色*/
@property (nonatomic, strong) UIColor *rippleColor;

- (instancetype)initWithLayer:(id)layer __attribute__ ((unavailable("该方法不可用,请使用init方法")));

- (void)addAnimation;

@end
