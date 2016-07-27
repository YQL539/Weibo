//
//  WeiboCell.m
//  假微博
//
//  Created by yangqinglong on 16/3/30.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "WeiboCell.h"
#import "Helper.h"
#import "WeiboHeaderView.h"
#import "WeiboView.h"

@interface WeiboCell()
@property (nonatomic,strong)WeiboHeaderView *headView;
@property (nonatomic,strong)WeiboView *weiboView;

@end
@implementation WeiboCell
//创建cell
+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[WeiboCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //头像
        self.headView = [[[NSBundle mainBundle]loadNibNamed:@"WeiboHeaderView" owner:nil options:nil]lastObject];
        _headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
        [self.contentView addSubview:_headView];
        
        //创建微博视图
        self.weiboView = [[WeiboView alloc]initWithFrame:CGRectZero isRespost:NO];
        _weiboView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_weiboView];
    }
    return self;
}

#pragma mark------重写set方法
-(void)setWeibo:(WeiboModel *)weibo{
    _weibo = weibo;
    self.headView.nameLabel.text = _weibo.userModel.screenName;
    self.headView.timeLabel.text = [Helper timeWithString:_weibo.created_at];
    self.headView.source = _weibo.source;
    //设置头像
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_weibo.userModel.profileImageUrl]];
        UIImage *image = [UIImage imageWithData:imageData];
        //刷新cell上面的ImageViews的内容
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.headView.iconImageView.image = image;
            self.headView.iconImageView.clipsToBounds = YES;
            self.headView.iconImageView.layer.cornerRadius = 25;
        });
        
    });
    
    self.weiboView.weibo = _weibo;
    self.weiboView.frame = CGRectMake(0, kPadding + kHeaderImageSize,kScreenWidth , 300);
}

+(CGFloat)cellHeightWithModel:(WeiboModel *)model{
    CGFloat height = 2*kPadding;
    height =height + kHeaderImageSize+kPadding;
    //计算文本内容的高度
    height += [WeiboCell weiboHeightWithModel:model isRespost:NO];
    if (model.retweetWeiboModel != nil) {
        height += [WeiboCell weiboHeightWithModel:model.retweetWeiboModel isRespost:YES];
    }
    return height;
}

+(CGFloat)weiboHeightWithModel:(WeiboModel *)model isRespost:(BOOL)isRespost{
    //文本
    CGFloat height = 0;
    height = [Helper sizeWithText:model.text contentSize:CGSizeMake(kScreenWidth-2*kPadding, 2000) textSize:(isRespost?12:14)].height;
    
    //图片 转发微博
    if (model.pic_urls.count != 0 ) {
        height += kPadding;
        height += (kThumnailSize+10)*((model.pic_urls.count - 1)/3+1);
    }
    return height;
}
@end





















