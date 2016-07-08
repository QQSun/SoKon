//
//  SKTabBar.h
//  SKTabBar
//
//  Created by nachuan on 16/6/17.
//  Copyright © 2016年 SoKon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTabBar;
@class SKTabBarItem;
@protocol SKTabBarDelegate <NSObject>

@optional
/**
 *  TabBarItem点击事件的回调方法 非重复点击单个按钮时回调
 *
 *  @param tabBar tabBar
 *  @param from   上一个选中的tabBarItem的tag值
 *  @param to     当前选中的tabBarItem的tag值
 */
- (void)sk_tabBar:(SKTabBar *)tabBar didSelectedTabBarItemFrom:(NSInteger)from to:(NSInteger)to;


/**
 *  重复点击单个tabBarItem时回调
 *
 *  @param tabBar tabBar
 *  @param tag    tabBarItem
 */
- (void)sk_tabBar:(SKTabBar *)tabBar didSelectedTabBarItem:(SKTabBarItem *)item;

/**
 *  点击了中心部位的tabBarItem
 *
 *  @param tabBar tabBar
 *  @param item   UIButton类型的按钮
 */
- (void)sk_tabBar:(SKTabBar *)tabBar didSelectedCenterTabBarItem:(UIButton *)item;

@end

@interface SKTabBar : UIView

/** 记录选中的item */
@property (nonatomic, strong) SKTabBarItem *selectedItem;

/** normal 文字颜色 */
@property (nonatomic, strong) UIColor *titleColor;

/** selected 文字颜色 */
@property (nonatomic, strong) UIColor *titleSelectedColor;

/** tabBar代理 */
@property (nonatomic, weak) id <SKTabBarDelegate> delegate;

/** 是否需要中间的特殊tabBarItem */
@property (nonatomic, assign) BOOL isNeedCenterTabBarItem;

/** 设置中心tabBarItem的图片 */
- (void)setCenterTabBarItemImageName:(NSString *)imageName;

/** 设置中心tabBarItem的背景图片 */
- (void)setCenterTabBarItemBackgroundImageName:(NSString *)backgroundImageName;

/** 设置中心tabBarItem的图片和背景图片 */
- (void)setCenterTabBarItemImageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName;

/** 添加tabBarItem */
- (void)addTabBarItem:(UITabBarItem *)item;

/**
 *  添加带动画的tabBarItem
 *
 *  @param item   item
 *  @param images 动画图片数组
 *  @param duration 动画时长
 */
- (void)addAnimationTabBarItem:(UITabBarItem *)item withAnimationImages:(NSArray *)images animationDuration:(NSInteger)duration repeatCount:(NSInteger)repeatCount;


/**
 *  添加带动画的tabBarItem 注意:没有可分割的图片是会引起程序异常
 *
 *  @param item   item
 *  @param row  原始图片要分割成的行数
 *  @param column  原始图片要分割的列数
 *  @param imageName 要进行分割的原始图片
 *  @param duration 动画时长
 */
- (void)addAnimationTabBarItem:(UITabBarItem *)item withAnimationImageName:(NSString *)imageName row:(NSInteger)row column:(NSInteger)column animationDuration:(NSInteger)duration repeatCount:(NSInteger)repeatCount;

@end
