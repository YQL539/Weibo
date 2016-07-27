//
//  ThemeBarbuttonItem.m
//  假微博
//
//  Created by yangqinglong on 16/3/28.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "ThemeTabBarItem.h"
#import "ThemeManager.h"
@implementation ThemeTabBarItem
//监听主题切换
-(instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadImage) name:kThemeChangedNotificationName object:nil];
    }
    return self;
}
+(ThemeTabBarItem *)themeTabBarItemWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName{
    ThemeTabBarItem *themeBarItem = [[ThemeTabBarItem alloc]init];
    themeBarItem.titleName =title;
    themeBarItem.normalImageName = normalImageName;
    themeBarItem.selectedImageName = selectedImageName;
    return themeBarItem;
}

-(void)setNormalImageName:(NSString *)normalImageName{
    _normalImageName = normalImageName;
    [self loadImage];
}

-(void)setSelectedImageName:(NSString *)selectedImageName{
    _selectedImageName = selectedImageName;
    [self loadImage];
}
-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    [self setTitle:_titleName];
}

//重新加载图片
-(void)loadImage{
    //获取正常状态的图片
    UIImage *normalImage = [[ThemeManager shareManager] imageWithName:self.normalImageName];
    [self setImage:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //得到选中状态的图片
    UIImage *selectedImage = [[ThemeManager shareManager] imageWithName:self.selectedImageName];
    [self setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

}
@end
















