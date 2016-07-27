//
//  ThemeBarbuttonItem.h
//  假微博
//
//  Created by yangqinglong on 16/3/28.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeTabBarItem : UITabBarItem

/**正常图片名字 */
@property (nonatomic,copy)NSString *normalImageName;
/**选中图片的名字 */
@property (nonatomic,copy)NSString *selectedImageName;
/**Title */
@property (nonatomic,copy)NSString *titleName;
//创建一个ThemeTabBarItem
+(ThemeTabBarItem *)themeTabBarItemWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName;

@end




