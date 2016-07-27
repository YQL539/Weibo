//
//  BookModels.m
//  假微博
//
//  Created by 胡锦吾 on 16/6/2.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "BookModels.h"

@implementation BookModels
-(instancetype)initWithDict:(NSDictionary *)Dict{
    if (self = [super init]) {
        _BookIcon = [Dict objectForKey:@"BookIcon"];
        _BookName = [Dict objectForKey:@"BookName"];
        
    }
    return self;
}


+(instancetype)BookModelWithDict:(NSDictionary *)Dict{
    return [[self alloc]initWithDict:Dict];
}
@end
