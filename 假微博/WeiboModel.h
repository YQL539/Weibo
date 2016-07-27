//
//  WeiboModel.h
//  假微博
//
//  Created by yangqinglong on 16/3/29.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "WeiboUser.h"
@interface WeiboModel : BaseModel
//属性名必须与字典里关键字一致
@property (nonatomic,copy) NSString *created_at;//微博创建时间
@property (nonatomic,copy) NSString *idstr;//微博的id
/**微博文本内容 */
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *source;//微博的来源
@property (nonatomic,assign) BOOL favorited;//是否收藏
//头像缩略图
@property (nonatomic,copy) NSString *thumbnail_pic;
//头像中等尺寸url
@property (nonatomic,copy) NSString *bmiddle_pic;
//原图地址
@property (nonatomic,copy) NSString *original_pic;
//用户信息
@property (nonatomic,strong) WeiboUser *userModel;
//转发微博信息
@property (nonatomic,strong)WeiboModel *retweetWeiboModel;
/**转发数 */
@property (nonatomic,assign) NSInteger reposts_count;
/**评论数 */
@property (nonatomic,assign) NSInteger comments_count;
/**点赞数 */
@property (nonatomic,assign) NSInteger attitudes_count;
/**图片链接 */
@property (nonatomic,strong) NSArray *pic_urls;


@end









