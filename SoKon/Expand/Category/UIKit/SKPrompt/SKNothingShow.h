//
//  SKNothingShow.h
//  SoKon
//
//  Created by nachuan on 16/6/29.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKNothingShow : UIView

/** 提示内容, 默认暂无数据 */
@property (nonatomic, copy) NSString *showInfo;

/** 提示图片,默认不显示 */
@property (nonatomic, strong) UIImage *showImage;

/** 提示图片的frame */
@property (nonatomic, assign) CGRect showImageFrame;

/** 提示文字的frame */
@property (nonatomic, assign) CGRect showTitleFrame;

/**
 *  添加prompt控件
 *
 *  @param frame      控件frame
 *
 *  @return 控件本身
 */
+ (instancetype)sk_addNothingShowWithFrame:(CGRect)frame;


/**
 *  添加prompt控件
 *
 *  @param title      提示文字
 *  @param imageNamed 提示图片名字
 *  @param frame      控件frame
 *
 *  @return 控件本身
 */
+ (instancetype)sk_addNothingShowTitle:(NSString *)title imageNamed:(NSString *)imageNamed frame:(CGRect)frame;

/**
 *  显示控件
 */
- (void)sk_show;


/**
 *  关闭控件,当不显示时请在controller dealloc时销毁
 */
- (void)sk_close;
@end
