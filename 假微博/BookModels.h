//
//  BookModels.h
//  假微博
//
//  Created by 胡锦吾 on 16/6/2.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModels : NSObject
@property (nonatomic,copy) NSString *BookIcon;
@property (nonatomic,copy) NSString *BookName;



-(instancetype)initWithDict:(NSDictionary *)Dict;
+(instancetype)BookModelWithDict:(NSDictionary *)Dict;

@end
