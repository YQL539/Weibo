//
//  AddViewController.m
//  UITabBarController
//
//  Created by yangqinglong on 16/1/21.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "AddViewController.h"
#import "springAnimaView.h"
#import "WeiboManager.h"
#import "WeiboEditVC.h"
@interface AddViewController()
@property (nonatomic,strong) UIImageView *addImageView;
@property (nonatomic,strong) springAnimaView *animationView;

@end
@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加底部背景图片
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    bgImageView.image= [UIImage imageNamed:@"tabbar_background"];
    [self.view addSubview:bgImageView];
    
    //添加add的图片
    self.addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-15, bgImageView.center.y-15, 30, 30)];
    _addImageView.image = [UIImage imageNamed:@"tabbar_compose_background_icon_add"];
    [self.view addSubview:_addImageView];
    
    //创建动画需要的内容
    NSArray *picsArray = @[@"note",@"album",@"location",@"album",@"picture",@"picture"];
    NSArray *actionArray = @[@"sendWeibo", @"sendWeibo",@"sendWeibo", @"sendWeibo",@"sendWeibo", @"sendWeibo"];
    NSMutableArray *itemsArray = @[].mutableCopy;
    for (int i = 0; i<picsArray.count; i++) {
        NSString *picName = [picsArray objectAtIndex:i];
        NSString *actionName = [actionArray objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:picName] forState:UIControlStateNormal];
        [btn addTarget:self action:NSSelectorFromString(actionName) forControlEvents:UIControlEventTouchUpInside];
        [itemsArray addObject:btn];
    }
    
    self.animationView = [[springAnimaView alloc]initWithFrame:self.view.bounds];
    _animationView.itemsArray = itemsArray;
    [self.view addSubview:_animationView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_animationView startAnimation];
    //添加动画
    [UIView animateWithDuration:0.2 animations:^{
        _addImageView.transform = CGAffineTransformMakeRotation((45/180.0*M_PI));
    }];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    [UIView animateWithDuration:0.2 animations:^{
        _addImageView.transform = CGAffineTransformMakeRotation((-45/180.0*M_PI));
    }];
    [_animationView stopAnimation];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(removeVC) userInfo:nil repeats:NO];
}
-(void)removeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---------Button Action
-(void)sendWeibo{
    WeiboEditVC *wvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WeiboEdit"];
    [self presentViewController:wvc animated:YES completion:nil];
}


@end















