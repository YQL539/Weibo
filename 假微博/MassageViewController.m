//
//  MassageViewController.m
//  UITabBarController
//
//  Created by yangqinglong on 16/1/21.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "MassageViewController.h"

#define scrollViewHeight 200

@interface MassageViewController()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *PicScrollView;
@property (nonatomic,strong) UIPageControl *PicCtr;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *picArr;
@property (nonatomic,strong) UIImageView *PicImageView;
@property (nonatomic,strong) UIImageView *lastImageView;
@end

@implementation MassageViewController
-(NSMutableArray *)picArr{
    if (self.picArr==nil) {
        _picArr = [NSMutableArray array];
    }
    return _picArr;
}

-(void)viewDidLoad{
    self.picArr = [self loadImageData];
    self.PicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, scrollViewHeight)];
    _PicScrollView.pagingEnabled = YES;
    _PicScrollView.delegate = self;
    _PicScrollView.showsHorizontalScrollIndicator = NO;
    _PicScrollView.tag = 1000;
    _PicScrollView.contentSize = CGSizeMake(self.PicScrollView.width * (_picArr.count), 0);
    [self reloadScrollView];
    
    [self.view addSubview:_PicScrollView];
    self.PicCtr = [[UIPageControl alloc]initWithFrame:CGRectMake((self.PicScrollView.width-150)/2, self.PicScrollView.y+scrollViewHeight-40, 150, 30)];
    _PicCtr.pageIndicatorTintColor = [UIColor grayColor];
    _PicCtr.currentPageIndicatorTintColor = [UIColor redColor];
    _PicCtr.numberOfPages = 5;
    _PicCtr.currentPage = 0;
    [self.view addSubview:_PicCtr];
    [self.view bringSubviewToFront:_PicCtr];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    //修改优先级与其他控件一样
    //获取当前消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //设置优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(NSMutableArray *)loadImageData{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%02d.jpg",i+1];
        NSString *imgPath = [[NSBundle mainBundle]pathForResource:imgName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
        [arr addObject:image];
    }
    return arr;
}

-(void)reloadScrollView{
    for (int i =0; i<_picArr.count; i++) {
        CGFloat imgX = self.view.frame.size.width * i;
        self.PicImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imgX, 0, self.view.frame.size.width, scrollViewHeight)];
        _PicImageView.image = [_picArr objectAtIndex:i];
        [_PicScrollView addSubview:_PicImageView];
    }
    CGFloat imgX = CGRectGetWidth(self.view.frame)*_picArr.count;
    _lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imgX, 0, self.view.frame.size.width, scrollViewHeight)];
    _lastImageView.image = [_picArr objectAtIndex:0];
    [_PicScrollView addSubview:_lastImageView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //停止计时器
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //r如果放到didscroll里面，每次自动播放都会调用，我们想要手指拖动时才调用，所以放到这里面，每次拖到第几张，白点就点亮
    CGFloat offsetX = self.PicScrollView.contentOffset.x + self.PicScrollView.frame.size.width/2;
    int index = offsetX/self.PicScrollView.width;
    _PicCtr.currentPage = index;

    //重新启用计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    //修改优先级与其他控件一样
    //获取当前消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //设置优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)scrollImage{
    //在scrollview后面加一个imageview，和第一个图一样。
    float offsetx = _PicScrollView.contentOffset.x;
    offsetx += CGRectGetWidth(self.view.frame);
    if (offsetx == CGRectGetWidth(self.view.frame)*_picArr.count) {
        _PicCtr.currentPage = 0;
    }else{
        _PicCtr.currentPage = offsetx/CGRectGetWidth(self.view.frame);
    }
    if (offsetx>CGRectGetWidth(self.view.frame)*_picArr.count) {
        //直接复制速度很快直接和lastImageView一样，看起来就是循环播放的
        _PicScrollView.contentOffset= CGPointMake(0, 0);
        _PicCtr.currentPage = 1;
        [_PicScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.frame), 0)  animated:YES];
    }else{
        [_PicScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    }
}
@end
