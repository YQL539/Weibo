//
//  CustomeTabBar.h
//  UITabBarController
//
//  Created by yangqinglong on 16/1/21.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabBarDelegate <NSObject>

-(void)addButtonDidClicked:(UIButton *)sender;

@end
@interface CustomeTabBar : UITabBar

@property (nonatomic,assign) id<CustomTabBarDelegate>delegate;
//背景图片名字
@property (nonatomic,copy)NSString *bgImageName;
@end

