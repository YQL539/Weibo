//
//  UIView+frame.m
//  假微博
//
//  Created by yangqinglong on 16/3/31.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)
-(void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (CGFloat)height{
    return self.frame.size.height;
}

@end



















