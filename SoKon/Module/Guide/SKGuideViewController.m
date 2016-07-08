//
//  SKGuideViewController.m
//  SoKon
//
//  Created by nachuan on 16/6/28.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKGuideViewController.h"
#import "SKWindowTool.h"
#define kGuideCount 4
@interface SKGuideViewController ()

@end

@implementation SKGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    UIScrollView *scrollView   = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = kBGColor;
    scrollView.pagingEnabled   = YES;
    scrollView.contentSize     = CGSizeMake(kScreenWidth * kGuideCount, kScreenHeight);
    [self.view addSubview:scrollView];
    for (int i=0; i<kGuideCount; i++) {
        UIImageView *iv             = [[UIImageView alloc] init];
        iv.frame                    = CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight);
        iv.image                    = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d",(i + 1)]];
        iv.tag                      = 10 + i;
        iv.userInteractionEnabled   = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedImageIndex:)];
        iv.gestureRecognizers       = @[tap];
        [scrollView addSubview:iv];
    }
}

- (void)didClickedImageIndex:(UITapGestureRecognizer *)tap
{
    UIImageView *iv = (UIImageView *)[tap view];
    SKLog(@"%ld",iv.tag);
    if (iv.tag == 13) {
        [SKWindowTool setWindowRootViewController];
    }
}

@end
