//
//  ViewController.m
//  PYgunaggao
//
//  Created by Apple on 16/7/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () < UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)UIScrollView *myScrollView;
@property (nonatomic, strong)UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.y);
    self.myScrollView = scrollView;
    if (scrollView.contentOffset.y >= 100) {

        self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.button.frame = CGRectMake(100, 300, 50, 50);
        self.button.backgroundColor = [UIColor orangeColor];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchDown)];
        [self.view addSubview:_button];
        
    } else if (scrollView.contentOffset.y < 70){
        NSLog(@"隐藏");
    }


}
- (void)buttonAction:(UIButton *)button {
    NSLog(@"返回顶部");
    [_myTableView setContentOffset:CGPointMake(0, -64) animated:YES];

}
- (void)tap:(UITapGestureRecognizer *)tap {


}
#pragma mark ======= tab代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"11";
    return cell;
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
