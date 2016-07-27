//
//  StarView.m
//  假微博
//
//  Created by 胡锦吾 on 16/6/4.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "StarView.h"
@interface StarView()
@property (nonatomic,weak) IBOutlet UIImageView *bgStarImgView;
@property (nonatomic,weak) IBOutlet UIImageView *SelectedImgView;
@end
@implementation StarView

-(void)awakeFromNib{
    _SelectedImgView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeRating)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

-(void)setRating:(CGFloat)rating{
    _rating = rating;
    
    CGFloat seImgViewX = 0;
    CGFloat seImgViewY = 0;
    CGFloat seImgViewW = (_rating/5.0)*_bgStarImgView.frame.size.width;
    CGFloat seImgViewH = _bgStarImgView.frame.size.height;
    self.SelectedImgView.frame = CGRectMake(seImgViewX, seImgViewY, seImgViewW, seImgViewH);
    
}

-(void)changeRating{
    if (_rating+0.5 > 5.0) {
        self.rating = 0;
    }else{
        self.rating= _rating + 0.5;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BookRatingChangedNotificationName" object:@{@"rate":@(_rating), @"row":@(_row)}];
    
}

@end




