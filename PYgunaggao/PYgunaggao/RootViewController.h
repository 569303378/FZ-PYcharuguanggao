//
//  RootViewController.h
//  PYgunaggao
//
//  Created by Apple on 16/7/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
@property (nonatomic, strong) NSString *webStr;
@end

@interface UIViewController (IMYPublic)
///该vc的navigationController
- (UINavigationController*)imy_navigationController;
@end