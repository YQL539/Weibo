//
//  YQLTabController.m
//  UITabBarController
//
//  Created by yangqinglong on 16/1/21.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "YQLTabController.h"
#import "CustomeTabBar.h"
#import "AddViewController.h"

@interface YQLTabController ()<CustomTabBarDelegate>

@end

@implementation YQLTabController
-(void)viewDidLoad {
    [super viewDidLoad];
    CustomeTabBar *tb = [[CustomeTabBar alloc]init];
    tb.bgImageName = @"tabbar_background";
    tb.delegate = self;
    [self setValue:tb forKey:@"tabBar"];
}

-(void)addButtonDidClicked:(UIButton *)sender{
    //显示add界面
    AddViewController *addVC = [[AddViewController alloc]init];
    addVC.view.backgroundColor = [UIColor whiteColor];
    
    [self presentViewController:addVC animated:YES completion:nil];
}


@end
