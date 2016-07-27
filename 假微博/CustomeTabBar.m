//
//  CustomeTabBar.m
//  UITabBarController
//
//  Created by yangqinglong on 16/1/21.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "CustomeTabBar.h"
#import "ThemeManager.h"
@interface CustomeTabBar()
@property (nonatomic,strong) UIButton *addButton;

@end

@implementation CustomeTabBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeChangedNotificationName object:nil ];
        
        //创建自己添加的按钮
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)loadImage{
    UIImage *bgImage = [[ThemeManager shareManager]imageWithName:self.bgImageName];
    [self setBackgroundImage:[bgImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

-(void)buttonClicked{
    if ([self.delegate respondsToSelector:@selector(addButtonDidClicked:)]) {
        [self.delegate addButtonDidClicked:_addButton];
    }
}
-(void)setBgImageName:(NSString *)bgImageName{
    _bgImageName = bgImageName;
    [self loadImage];
}

/*
 自动调用
 一个视图A被添加到另一个视图B
 一个视图的Frame改变
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    //计算每个item的平均宽度
    CGFloat avgWith = self.frame.size.width/5;
    NSInteger index = 0;
    for (UIView *item in self.subviews) {
        if ([item isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            item.frame = CGRectMake(index * avgWith, item.frame.origin.y, avgWith, item.frame.size.height);
            
            index++;
            if (index == 2) {
                _addButton.frame = CGRectMake(index*avgWith, 3, avgWith, 44);
                [self addSubview:_addButton];
                index ++;
            }
        }
    }
}
@end


























