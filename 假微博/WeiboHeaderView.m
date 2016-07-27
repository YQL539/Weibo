//
//  WeiboHeaderView.m
//  假微博
//
//  Created by yangqinglong on 16/3/30.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "WeiboHeaderView.h"
#import <YYText.h>
#import "RegexKitLite.h"
@interface WeiboHeaderView()
@property (nonatomic,strong) YYLabel *label;
@end
@implementation WeiboHeaderView
-(void)awakeFromNib{
    self.label = [YYLabel new];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.backgroundColor = [UIColor clearColor];
}
//<a href='wfaslfja;.com'>iPHone6</a>
-(void)setSource:(NSString *)source{
    _source = source;
    //<a href='http://www.baidu.com'>微博</a>
    if (source.length != 0) {
        //解析网址
        NSString *regex = @"http(s)?://[0-9a-zA-Z./_]+";
        NSArray *resultsArray = [_source componentsMatchedByRegex:regex];
//        NSString *urlString = [resultsArray lastObject];
        //解析正文
        regex = @">.+<";
        resultsArray = [_source componentsMatchedByRegex:regex];
        NSString *textString = [resultsArray lastObject];
        NSString *text = [textString substringWithRange:NSMakeRange(1, textString.length - 2)];
        //创建正文的yy格式
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc]initWithString:text];
        one.yy_font = [UIFont systemFontOfSize:10];
        //配置点击之后的时间
        [one yy_setTextHighlightRange:one.yy_rangeOfAll
                                color:[UIColor darkGrayColor]
                      backgroundColor:[UIColor clearColor]
                            tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                NSArray *resultsArray = [_source componentsMatchedByRegex:regex];
                                NSString *urlString = [resultsArray lastObject];
                                NSLog(@"%@",urlString);
                            }];
        //创建yylabel的frame
        _label.attributedText = one;
        _label.frame = CGRectMake(_timeLabel.x + _timeLabel.width + 15, _timeLabel.y , self.width - (_timeLabel.x + _timeLabel.width + 10), _timeLabel.height);
        [self addSubview:_label];
    }
}


@end
