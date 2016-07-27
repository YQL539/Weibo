//
//  ThemeManager.m
//  假微博
//
//  Created by yangqinglong on 16/3/28.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "ThemeManager.h"
static ThemeManager *instance = nil;
@implementation ThemeManager
+(instancetype)shareManager{
    if (instance == nil) {
        instance = [[super allocWithZone:NULL]init];
    }
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shareManager];
}

#pragma mark --------读取plist文件
-(NSDictionary *)themePlistDic{
    if (_themePlistDic == nil) {
        //从bundle里面读取plist
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ThemesList" ofType:@"plist"];
        self.themePlistDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return _themePlistDic;
}
//拼接图片路径 bundle/skins/blue/1.png
-(NSString *)imagePathWithName:(NSString *)imageName{
    if (imageName.length == 0) {
        return nil;
    }else{
        //获得程序的资源路径
        NSString *resoucePath = [[NSBundle mainBundle]resourcePath];
        NSString *imagePath = nil;
        //判断是不是默认的一套图片
        if (_themeName.length == 0) {
            //bundle/1.png
            imagePath = [resoucePath stringByAppendingPathComponent:imageName];
        }else{
            //获取主题对应的路径
            NSString *themePath = [self.themePlistDic objectForKey:_themeName];
            imagePath = [NSString stringWithFormat:@"%@/%@/%@",resoucePath,themePath,imageName];
        }
        return imagePath;
    }
}

-(UIImage *)imageWithName:(NSString *)imageName{
    NSString *imagePath = [self imagePathWithName:imageName];
    return [UIImage imageWithContentsOfFile:imagePath];
    
}

@end













