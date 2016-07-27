//
//  springAnimaView.m
//  UITabBarController
//
//  Created by yangqinglong on 16/1/21.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "springAnimaView.h"
#define kSize 80
#define kSpace ((self.frame.size.width - kSize*3)/4)


@implementation springAnimaView
-(void)setItemsArray:(NSArray *)itemsArray {
    _itemsArray = itemsArray;
    //将数组里的视图添加到当前界面
    for (int i =0; i<itemsArray.count; i++) {
        UIView *item = [itemsArray objectAtIndex:i];
        //确定坐标位置
        item.frame= CGRectMake(kSpace+i%3*(kSize +kSpace), self.frame.size.height, kSize, kSize);
        [self addSubview:item];
    }
}
-(void)startAnimation{
    //动画的实质就是改变每个视图的Y坐标
    for (int i = 0; i<_itemsArray.count; i++) {
        UIView *item = [_itemsArray objectAtIndex:i];
        //计算最终的坐标
        [UIView animateWithDuration:0.8 delay:i%3*0.1+i/3*0.1 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
            CGFloat y = 200+i/3*(kSize + kSpace);
            item.frame = CGRectMake(item.frame.origin.x, y, kSize, kSize);
        } completion:nil];
    }
}
-(void)stopAnimation{
    //动画的实质就是改变每个视图的Y坐标
    for (NSInteger i = _itemsArray.count - 1; i>=0; i--) {
        UIView *item = [_itemsArray objectAtIndex:i];
        //计算最终的坐标
        [UIView animateWithDuration:0.9 delay:(_itemsArray.count-1 - i)%3*0.1+(_itemsArray.count-1 - i)/3*0.1 usingSpringWithDamping:0.1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
            item.frame = CGRectMake(item.frame.origin.x,self.frame.size.height, kSize, kSize);
        } completion:nil];
    }
    
}

@end
