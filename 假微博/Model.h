//
//  Model.h
//  假微博
//
//  Created by 胡锦吾 on 16/6/5.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookModels.h"
@interface Model : NSObject
@property (nonatomic,strong) BookModels *bookModel;
@property (nonatomic,assign) CGFloat rate;
@end
