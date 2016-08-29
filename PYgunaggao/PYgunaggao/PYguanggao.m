//
//  PYguanggao.m
//  PYgunaggao
//
//  Created by Apple on 16/7/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "PYguanggao.h"
#import "RootViewController.h"

@interface PYguanggao ()
@property (nonatomic, strong) UIWindow* window;
@property (nonatomic, assign) NSInteger downCount;
@property (nonatomic, weak) UIButton* downCountButton;
@property (nonatomic, strong) NSString *imageStr;
@end

@implementation PYguanggao
//在load方法中,启动监听, 可以做到无注入
+ (void)load {
    [self shareInstance];
}

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        //应用启动, 首次开展广告
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //要等DidFinished方法结束后才能初始化UIWindow，不然会检测是否有rootViewController
            dispatch_async(dispatch_get_main_queue(), ^{
                //
                [self checkAD];
            });
        }];
        
        //进入后台
//        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//            //请求新的广告数据
//            [self request];
//        }];
        
        //后台启动, 二次开启广告
//        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//            //
//            [self checkAD];
//        }];
    }
    return self;
}

- (void)request {
    //请求新的广告数据
}
- (void)checkAD {
    //如果有显示,没有请求,下次启动在显示
    //这里没有
    [self show];
}
- (void)show {
    //初始化一个window, 做到对业务视图无干扰
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //广告布局
    [self setupSubViews:window];
    
    //设置为最顶层,防止被弹框覆盖
    window.windowLevel = UIWindowLevelStatusBar + 1;
    
    //默认为yes, 设置no,window显示
    window.hidden = NO;
    
    //渐显动画
    window.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        window.alpha = 1;
    }];
    
    //防止释放,显示完成后,要手动设置为niu
    self.window = window;
}

- (void)hide {
    //渐显动画
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        [self.window.subviews.copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        self.window.hidden = YES;
        self.window = nil;
    }];
}

//初始化显示的视图
- (void)setupSubViews:(UIWindow *)window {
    //广告图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:window.bounds];
    self.imageStr = [NSString stringWithFormat:@"%d.jpg", arc4random() % 6];
    imageView.image = [UIImage imageNamed:self.imageStr];
    imageView.userInteractionEnabled = YES;
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [imageView addGestureRecognizer:tap];
    [window addSubview:imageView];
    
    //倒计时按钮
    self.downCount = 3;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(window.bounds.size.width - 100 - 20, 20, 100, 60)];
    [button setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [button addTarget:self action:@selector(buttonTimeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [window addSubview:button];
    
    self.downCountButton = button;
    [self timer];
}
//手势
- (void)tapAction {
    UIViewController *viewC = [[UIApplication sharedApplication].delegate window].rootViewController;
    RootViewController *rootVC = [[RootViewController alloc] init];
    rootVC.webStr = self.imageStr;
    [[viewC imy_navigationController] pushViewController:rootVC animated:YES];
    
    [self hide];
}
//倒计时事件
- (void)buttonTimeAction {
    [self hide];
}

- (void)timer {
    [self.downCountButton setTitle:[NSString stringWithFormat:@"跳过: %ld", self.downCount] forState:(UIControlStateNormal)];
    if (self.downCount <= 0) {
        [self hide];
    } else {
        self.downCount --;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self timer];
        });
    }
}

@end
