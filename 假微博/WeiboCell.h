//
//  WeiboCell.h
//  假微博
//
//  Created by yangqinglong on 16/3/30.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"

@interface WeiboCell : UITableViewCell
@property (nonatomic,strong)WeiboModel *weibo;

//创建cell  从storyboard读取的时候用indexPath
+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


//计算cell高度
+(CGFloat)cellHeightWithModel:(WeiboModel *)model;
+(CGFloat)weiboHeightWithModel:(WeiboModel *)model isRespost:(BOOL)isRespost;

@end
