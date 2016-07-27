//
//  WeiboView.m
//  假微博
//
//  Created by yangqinglong on 16/3/30.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "WeiboView.h"
#import <YYText.h>
#import "Helper.h"
#import "PictureView.h"
#import "WeiboModel.h"
#import "WeiboCell.h"

@interface WeiboView()
@property (nonatomic,strong) WeiboView *retweetWeibo;
@property (nonatomic,strong) YYLabel *contentYYLabel;
@property (nonatomic,assign) BOOL isRespost;
@property (nonatomic,strong) PictureView *pictureView;
@end
@implementation WeiboView
-(instancetype)initWithFrame:(CGRect)frame isRespost:(BOOL)isRepost{
    if (self = [super initWithFrame:frame]) {
        self.isRespost = isRepost;
        //显示微博内容
        self.contentYYLabel = [YYLabel new];
        _contentYYLabel.textAlignment = NSTextAlignmentLeft;
        
        _contentYYLabel.backgroundColor = [UIColor clearColor];
        _contentYYLabel.numberOfLines = 0;
        [self addSubview:_contentYYLabel];
        _contentYYLabel.hidden = YES;
        
        //显示微博图片
        self.pictureView = [[PictureView alloc]initWithFrame:CGRectZero];
        [self addSubview:_pictureView];
        
        //转发微博
    }
    return self;
}

-(void)setWeibo:(WeiboModel *)weibo{
    _weibo = weibo;
    //对文本里面的短连接替换为📎短连接
    //📎短链接#话题# @小王
    NSString *text = [Helper replaceLinkWithText:_weibo.text];
    //计算文本高度
    CGFloat height = [Helper sizeWithText:_weibo.text contentSize:CGSizeMake(self.width-20, 20000) textSize:kGetTextSize].height;
    //创建yylabel的frame
    _contentYYLabel.attributedText = [Helper attributedStringWith:text];
    _contentYYLabel.frame = CGRectMake(10, 0, kScreenWidth-20, height);
    _contentYYLabel.displaysAsynchronously = NO;
    _contentYYLabel.hidden = NO;
    _contentYYLabel.font = [UIFont systemFontOfSize:18];
    //判断是否有转发
    if (_weibo.pic_urls.count != 0) {
        _pictureView.hidden = NO;
        _pictureView.urlsArray = _weibo.pic_urls;
        //设置图片的frame
        _pictureView.frame = CGRectMake(0, _contentYYLabel.y+_contentYYLabel.height+10,kScreenWidth , (kThumnailSize+10)*((_weibo.pic_urls.count -1 )/3+1));
        
    }else{
        _pictureView.hidden = YES;
    }
   //判断是否是转发
    if (self.retweetWeibo != nil) {
        [self.retweetWeibo removeFromSuperview];
    }
    
    if (_weibo.retweetWeiboModel != nil) {
        //转发的微博
        //获取转发微博的尺寸
        CGFloat retweetHeight =[WeiboCell weiboHeightWithModel:_weibo.retweetWeiboModel isRespost:YES];
        self.retweetWeibo = [[WeiboView alloc]initWithFrame:CGRectMake(0, _contentYYLabel.y+_contentYYLabel.height+kPadding,kScreenWidth , retweetHeight) isRespost:YES];
        self.retweetWeibo.weibo = _weibo.retweetWeiboModel;
        [self addSubview:_retweetWeibo];
    }
}




@end























