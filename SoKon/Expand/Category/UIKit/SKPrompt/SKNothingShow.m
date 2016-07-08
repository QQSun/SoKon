//
//  SKNothingShow.m
//  SoKon
//
//  Created by nachuan on 16/6/29.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKNothingShow.h"

@interface SKNothingShow ()

/** 图片显示的imageView */
@property (nonatomic, strong) UIImageView *imageImageView;

/** 提示文字 */
@property (nonatomic, strong) UILabel *showTitle;

@end

@implementation SKNothingShow


@synthesize showInfo       = _showInfo;
@synthesize showTitleFrame = _showTitleFrame;
@synthesize showImageFrame = _showImageFrame;

+ (instancetype)sk_addNothingShowWithFrame:(CGRect)frame
{
    return [self sk_addNothingShowTitle:nil imageNamed:nil frame:frame];
}

+ (instancetype)sk_addNothingShowTitle:(NSString *)title imageNamed:(NSString *)imageNamed frame:(CGRect)frame
{
    SKNothingShow *show          = [[SKNothingShow alloc] initWithFrame:frame];
    show.backgroundColor         = [UIColor clearColor];
    show.showTitle               = [[UILabel alloc] initWithFrame:show.showTitleFrame];
    show.showTitle.text          = (title == nil) ? show.showInfo : title;
    show.showTitle.font          = [UIFont systemFontOfSize:14];
    show.showTitle.center        = show.center;
    show.showTitle.textColor     = [UIColor grayColor];
    show.showTitle.textAlignment = NSTextAlignmentCenter;
    [show addSubview:show.showTitle];
    
    if (imageNamed != nil && ![imageNamed isEqualToString:@""]) {
        show.imageImageView        = [[UIImageView alloc] initWithFrame:show.showImageFrame];
        show.imageImageView.image  = [UIImage imageNamed:imageNamed];
        show.imageImageView.center = CGPointMake(show.centerX, show.centerY - ((show.showTitle.height + show.imageImageView.height)/ 4.0));
        show.showTitle.center      = CGPointMake(show.centerX, show.centerY + ((show.showTitle.height + show.imageImageView.height) / 4.0));
//        [show.imageImageView setUserInteractionEnabled:YES];
        [show addSubview:show.imageImageView];
    }
    return show;
}

- (void)sk_show
{
    self.hidden = NO;
}

- (void)sk_close
{
    self.hidden = YES;
}

#pragma mark - setter getter方法

- (CGRect)showImageFrame
{
    if (_showImageFrame.size.height == 0 || _showImageFrame.size.width == 0) {
        return CGRectMake(0, 0, 60, 60);
    }
    return _showImageFrame;
}

- (void)setShowImageFrame:(CGRect)showImageFrame
{

    _showImageFrame       = showImageFrame;
    _imageImageView.frame = _showImageFrame;
}

- (CGRect)showTitleFrame
{
    if (_showTitleFrame.size.width == 0 || _showTitleFrame.size.height == 0) {
        return CGRectMake(40, 0, self.bounds.size.width - 80, 40);
    }
    return _showTitleFrame;
}

- (void)setShowTitleFrame:(CGRect)showTitleFrame
{
    _showTitleFrame  = showTitleFrame;
    _showTitle.frame = _showTitleFrame;
}

- (void)setShowInfo:(NSString *)showInfo
{
    if (_showInfo != showInfo) {
        _showInfo = showInfo;
    }
}

- (NSString *)showInfo
{
    if (_showInfo == nil) {
        _showInfo = @"暂无数据";
    }
    return _showInfo;
}


@end
