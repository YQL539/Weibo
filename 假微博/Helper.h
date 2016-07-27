//
//  Helper.h
//  假微博
//
//  Created by yangqinglong on 16/3/30.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    kBarButtonPositionLeft,
    kBarButtonPositionRight
}kBarButtonPosition;

@interface Helper : NSObject
//查找一个字符串在某个字符串里面的所有range
+(NSArray *)rangsOfString:(NSString *)subString in:(NSString *)orgString;

//将微博里面的短连接，替换为📎网页链接
+(NSString *)replaceLinkWithText:(NSString *)text;

//设置文本的AttributeString
+(NSAttributedString *)attributedStringWith:(NSString *)text;

//计算文本的尺寸
+(CGSize)sizeWithText:(NSString *)text contentSize:(CGSize)bigSize textSize:(CGFloat)size;

//把时间进行分类 刚刚，一分钟前，一小时前，几天前
+(NSString *)timeWithString:(NSString *)timeString;

/**创建导航栏上的Item */
+(UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                    target:(id)target
                                    action:(SEL)action
                                    posion:(kBarButtonPosition)position
                            navigationItem:(UINavigationItem *)navigationItem;
@end










