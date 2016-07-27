
//
//  PictureView.m
//  假微博
//
//  Created by yangqinglong on 16/3/31.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "PictureView.h"
#import <AFNetworking.h>
#import <AFImageDownloader.h>



@implementation PictureView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //以此建立九个图片视图
        for (int i = 0; i<9; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.tag = i+1;
            [self addSubview:imageView];
        }
    }
    return self;
}

-(void)setUrlsArray:(NSArray *)urlsArray{
    _urlsArray = urlsArray;
    //将当前的视图的所有子视图隐藏，（防止cell重复利用时出错）.
    for (UIView *sView in self.subviews) {
        [sView setHidden:YES];
    }
    
    //一次创建一个UIimageView显示图片
    for (int i = 0; i<_urlsArray.count; i++) {
        NSString *urlString = [[_urlsArray objectAtIndex:i] objectForKey:@"thumbnail_pic"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60];
        NSUUID *uid = [[NSUUID alloc]initWithUUIDString:[NSString stringWithFormat:@"%d",i+1]];
        [[AFImageDownloader defaultInstance]downloadImageForURLRequest:request withReceiptID:uid success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
            //获取对应uiimageView的tag值
            NSInteger index = [_urlsArray indexOfObject:@{@"thumbnail_pic":[request.URL relativeString]}];
            
            //获取UIImageView对象
            UIImageView *imageView = [self viewWithTag:index+1];
            imageView.image = responseObject;
            imageView.hidden = NO;
            imageView.frame = CGRectMake(10+(index)%3*(kThumnailSize+5), (index)/3*(kThumnailSize+5), kThumnailSize, kThumnailSize);
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            NSLog(@"失败");
        }];
    }
}


@end












