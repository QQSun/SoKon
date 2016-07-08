//
//  SKHomeViewController.m
//  SoKon
//
//  Created by nachuan on 16/6/23.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKHomeViewController.h"
#import "SKPrompt.h"
#import "SKRippleLayer.h"

#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <MJRefresh/MJRefresh.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

#define kAlphaBase 100.0

typedef NS_ENUM(NSInteger, SKScrollDirection){
    SKScrollDirectionUp = 0,
    SKScrollDirectionDown   = 1,
};

@interface SKHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/** 记录当前导航栏 */
@property (nonatomic, strong) UINavigationBar *navigationBar;

/** 每隔 kAlphaBase距离更新一下当前偏移量的值,起始值为0 */
@property (nonatomic, assign) CGFloat currentOffsetY;

/** 累计偏移量 */
@property (nonatomic, assign) CGFloat offsetY;

@property (nonatomic, assign) SKScrollDirection scrollDirection;

@property (nonatomic, strong) SKURLSessionDataTask *dataTask;

@end


@implementation SKHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        /** 此处不可以用 self.navigationController.navigationBar 访问,因为此时self.navigationController.navigationBar还未赋值*/
        UINavigationBar *navigationBar = [UINavigationBar appearance];
        navigationBar.barTintColor     = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationBar = self.navigationController.navigationBar;
    [self createUI];
    [self loginBtnClickedForNetworing];
    [self classBlock:^(NSInteger a) {
        [self log:a];
        self.scrollDirection = SKScrollDirectionUp;
    }];
    
}

- (void)classBlock:(void(^)(NSInteger a))block
{
    if (block) {
        block(9);
    }
}

- (void)log:(NSInteger)num
{
    SKLog(@"%ld",(long)num);
}
- (void)createUI
{

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate              = self;
    _tableView.dataSource            = self;
    _tableView.backgroundColor       = kBGColor;
    _tableView.contentInset          = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    _tableView.tableHeaderView       = [self createTableViewHeadView];
//    _tableView.sk_prompt = [SKNothingShow sk_addNothingShowTitle:@"heheh" imageNamed:@"tabbar_compose_friend" frame:_tableView.bounds];
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
//    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
//    [timer fire];
    [self.view addSubview:_tableView];
    
//    
//    UIButton *btn = [[UIButton alloc] init];
//    btn.frame = CGRectMake(50, 100, 50, 100);
//    btn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [btn setBackgroundImage:[[UIImage imageNamed:@"login_picture"] resizableImageWithCapInsets:UIEdgeInsetsMake(75, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
//    [btn setTitle:@"我是按钮" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
//    [self.view addSubview:btn];
}


- (UIView *)createTableViewHeadView
{
    UIView *view         = [[UIView alloc] init];
    view.frame           = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 9.0 / 16.0);
    view.backgroundColor = [UIColor whiteColor];
    
    
    
    SDCycleScrollView *cycle          = [[SDCycleScrollView alloc] init];
    cycle.frame                       = CGRectMake(5, 5, view.width - 2 * 5, view.height - 10);
    cycle.showPageControl             = YES;
    cycle.autoScrollTimeInterval      = 4;
    cycle.bannerImageViewContentMode  = UIViewContentModeScaleAspectFill;
    cycle.localizationImageNamesGroup = @[@"guide_1", @"guide_2", @"guide_3"];
    [view addSubview:cycle];
    
//    SKRippleLayer *layer = [[SKRippleLayer alloc] init];
//    layer.position = view.layer.position;
//    [view.layer addSublayer:layer];
    return view;
}

- (void)timerRun:(NSTimer *)timer
{
    _tableView.sk_prompt.hidden = !_tableView.sk_prompt.hidden;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKHomeViewController *home = [[SKHomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"hhe";
    return cell;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    SKLog(@"scrollViewDidZoom");
}

/**
 *  offset的setter方法
 */
- (void)setOffset:(CGFloat)offset
{
    _offsetY += offset;
    if (_offsetY < 0) {
        _offsetY = 0;
    }else if (_offsetY > kAlphaBase) {
        _offsetY = kAlphaBase;
    }
}

/**
 *  currentOffsetY的setter方法
 */
- (void)setCurrentOffsetY:(CGFloat)currentOffsetY
{
    _currentOffsetY = currentOffsetY;
    if (_currentOffsetY < 0) {
        _currentOffsetY = 0;
        _offsetY = 0.0;
    }
}

/**
 *  1.滑动过程中一直触发.
 *  2.修改导航栏及标题颜色的透明度
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *arr        = _navigationBar.subviews;
    UIView *view        = arr[0];
    CGFloat alpha       = 1;
    self.offset         = scrollView.contentOffset.y - _currentOffsetY;
    self.currentOffsetY = scrollView.contentOffset.y;
    alpha = (kAlphaBase - _offsetY) / kAlphaBase;
    view.alpha = alpha;
    if (alpha == 0) {
        self.navigationController.navigationBar.userInteractionEnabled = NO;
    }else{
        self.navigationController.navigationBar.userInteractionEnabled = YES;
    }
    [_navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha]}];
}

#pragma mark - MJRefresh

- (void)headerRefresh:(MJRefreshHeader *)header
{
    
}

- (void)footerRefresh:(MJRefreshFooter *)footer
{
    
}

- (void)loginBtnClickedForNetworing
{
    NSDictionary *parameters = @{
                                 };
    SKHTTPSessionManager *manager = [SKHTTPSessionManager manager];
    __weak typeof(self) weakSelf = self;
    weakSelf.dataTask = [manager sk_post:@"http://www.hudieyun.net:8083/snsapi_v1/?service=Group.getMyGroup" parameters:parameters progress:nil success:^(SKURLSessionDataTask *task, id responseObject) {
        SKLog(@"%@",weakSelf.dataTask);
    } failure:^(SKURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)dealloc
{
    SKLog(@"%@",_dataTask);
    [_dataTask cancel];
    [_tableView.mj_header removeFromSuperview];
    [_tableView.mj_footer removeFromSuperview];
//    [_tableView.sk_prompt removeFromSuperview];
    _dataTask = nil;
    _tableView.mj_header = nil;
    _tableView.mj_footer = nil;
//    _tableView.sk_prompt = nil;
}

@end
