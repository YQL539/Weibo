
//
//  LeftViewController.m
//  假微博
//
//  Created by yangqinglong on 16/3/28.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "LeftViewController.h"
#import "ThemeManager.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)postnotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChangedNotificationName object:nil userInfo:nil];
}

- (IBAction)defaultTheme:(id)sender {
    [ThemeManager shareManager].themeName = nil;
    [self postnotification];
}
- (IBAction)blueTheme:(id)sender {
    [ThemeManager shareManager].themeName = @"blue";
    [self postnotification];
}
- (IBAction)pinkTheme:(id)sender {
    [ThemeManager shareManager].themeName = @"pink";
    [self postnotification];
}
//登录
- (IBAction)loginDidClicker:(id)sender {
    [[WeiboManager shareManager] WeiboLogin];
    
}
//退出登录
- (IBAction)loginoutDidClicked:(id)sender {
    
}

@end


















