//
//  WeiboView.h
//  假微博
//
//  Created by yangqinglong on 16/3/30.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeiboModel.h"
@interface WeiboView : UIView
@property (nonatomic,strong) WeiboModel *weibo;

//自定义init方法
-(instancetype)initWithFrame:(CGRect)frame isRespost:(BOOL)isRepost;

@end
