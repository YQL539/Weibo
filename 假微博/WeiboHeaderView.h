//
//  WeiboHeaderView.h
//  假微博
//
//  Created by yangqinglong on 16/3/30.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RTLabel.h"

@interface WeiboHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (copy,nonatomic ) NSString *source;
@end
