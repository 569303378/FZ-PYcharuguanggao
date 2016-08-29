//
//  RootViewController.m
//  PYgunaggao
//
//  Created by Apple on 16/7/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我是广告";
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.backgroundColor = [UIColor whiteColor];
    
    if ([self.webStr isEqualToString:@"0.jpg"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sina.com.cn/"]]];
    } else if ([self.webStr isEqualToString:@"1.jpg"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://qzone.qq.com/"]]];
    } else if ([self.webStr isEqualToString:@"2.jpg"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.youku.com/"]]];
    } else if ([self.webStr isEqualToString:@"3.jpg"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.tripadvisor.cn/"]]];
    } else if ([self.webStr isEqualToString:@"4.jpg"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.linkedin.com/"]]];
    } else if ([self.webStr isEqualToString:@"5.jpg"]) {
       [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    }
    

    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation UIViewController (IMYPublic)

- (UINavigationController *)imy_navigationController {
    UINavigationController *nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    } else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = [((UITabBarController *) self).selectedViewController imy_navigationController];
        } else {
            nav = self.navigationController;
        }
    }
    return nav;
}

@end













