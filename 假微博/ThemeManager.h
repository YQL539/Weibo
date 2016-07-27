//
//  ThemeManager.h
//  假微博
//
//  Created by yangqinglong on 16/3/28.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kThemeChangedNotificationName @"kThemeChangedNotificationName"

@interface ThemeManager : NSObject
/**记录主题名字 */
@property (nonatomic,copy) NSString *themeName;
//记录主题
@property (nonatomic,strong)NSDictionary *themePlistDic;

/**单例 */
+(instancetype)shareManager;

/**获取某张图片名字在对应主题下的图片 */

-(UIImage *)imageWithName:(NSString *)imageName;

@end
