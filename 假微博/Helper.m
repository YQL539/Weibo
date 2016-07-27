//
//  Helper.m
//  假微博
//
//  Created by yangqinglong on 16/3/30.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "Helper.h"
#import "RegexKitLite.h"
#import <YYText.h>
@implementation Helper
//查找一个字符串在某个字符串里面的 所有range
+(NSArray *)rangsOfString:(NSString *)subString in:(NSString *)orgString{
    NSMutableArray *rangesArray = [NSMutableArray array];
    NSMutableString *string = [NSMutableString stringWithString:orgString];
//    NSLog(@"11111111%@",string);
    while (1) {
        //从最后开始找
        NSRange range = [string rangeOfString:subString options:NSBackwardsSearch];
        if (range.length!=0) {
            if ([subString isEqualToString:@"...全文"]) {
                [rangesArray addObject:[NSValue valueWithRange:NSMakeRange(range.location + 3, 2)]];
            }else{
                [rangesArray addObject:[NSValue valueWithRange:range]];
            }
            [string deleteCharactersInRange:range];
        }else{
            break;
        }
    }
    return rangesArray;
}

+(NSAttributedString *)attributedStringWith:(NSString *)text{
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc]initWithString:text];
    
//    NSLog(@"222222%@",one);
    
    //解析
    NSString *regex = @"(#\\w+#)|(@\\w+)|(📎网页链接)|(\\.\\.\\.全文)";
    NSArray *resultsArray = [text componentsMatchedByRegex:regex];
    //一次替换one里面对应部分的link
    for (NSString *comp in resultsArray) {
        //获取comp在字符串里面所有的range
        NSArray *rangesArray = [Helper rangsOfString:comp in:text];
        for (NSValue *rValue in rangesArray) {
            [one yy_setTextHighlightRange:rValue.rangeValue color:[UIColor blueColor] backgroundColor:[UIColor clearColor] userInfo:nil];
            
        }
    }
    return one;
    
}
/*
 CSS3/jQuery创意盒子动画菜单】给你一个在线演示的网页链接：http://t.cn/8Fmr7nE
 源码下载：http://t.cn/R22ks0J
 */
+(NSString *)replaceLinkWithText:(NSString *)text{
    NSMutableString *mText = [NSMutableString stringWithString:text];
    
    NSString *regex = @"http(s)?://[0-9a-zA-Z./_]+";
    NSArray *resultsArray = [text componentsMatchedByRegex:regex];
    for (NSString *str  in resultsArray) {
        //将http://t.cn/RqZmTkJ  替换为：网页链接
        [mText replaceOccurrencesOfString:str withString:@"📎网页链接" options:NSCaseInsensitiveSearch range:NSMakeRange(0,mText.length)];
        
    }
    return mText;
}

+(CGSize)sizeWithText:(NSString *)text contentSize:(CGSize)bigSize textSize:(CGFloat)size{
    //转换链接
    NSString *result = [Helper replaceLinkWithText:text];
    
    return [result boundingRectWithSize:bigSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
}

//Wed Mar 30 11:30:23 +0800 2016
+(NSString *)timeWithString:(NSString *)timeString{
    //将字符串的日期转化为NSdata类型
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM d H:mm:ss Z yyyy";
//    NSDate *createDate = [formatter dateFromString:timeString];
    //计算间隔时间
//    NSTimeInterval interval = [[NSDate date]timeIntervalSinceDate:createDate];
    return [[timeString componentsSeparatedByString:@" "]objectAtIndex:3];
}

@end















