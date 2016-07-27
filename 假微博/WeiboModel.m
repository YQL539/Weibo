
//
//  WeiboModel.m
//  假微博
//
//  Created by yangqinglong on 16/3/29.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel
-(void)setWithDictionary:(NSDictionary *)dict{
    [super setWithDictionary:dict];
    
    //用户信息
    NSDictionary *userDic = [dict objectForKey:@"user"];
    self.userModel = [[WeiboUser alloc]initWithDictionary:userDic];

    //转发的微博信息
    NSDictionary *retweetDic = [dict objectForKey:@"retweeted_status"];
    if (retweetDic!=nil) {
        self.retweetWeiboModel = [[WeiboModel alloc]init];
        [self.retweetWeiboModel setWithDictionary:retweetDic];
    }
}



@end
