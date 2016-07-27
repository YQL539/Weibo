//
//  BooksCell.m
//  假微博
//
//  Created by 胡锦吾 on 16/6/3.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "BooksCell.h"
#import "BookModels.h"
#import "StarView.h"
@interface BooksCell()
@property (weak, nonatomic) IBOutlet UIImageView *bookIcon;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet StarView *RatingView;

@end
@implementation BooksCell

+(BooksCell *)booksCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"bookCell";
    BooksCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BooksCell" owner:nil options:nil]lastObject];
    }
    return cell;
}


-(void)setRow:(NSInteger)row{
    _row = row;
    _RatingView.row = _row;
    
}
-(void)setModel:(Model *)model{
    _model = model;
    self.bookIcon.image = [UIImage imageNamed:_model.bookModel.BookIcon];
    self.bookName.text = [NSString stringWithFormat:@"《%@》",_model.bookModel.BookName];
    self.RatingView.rating  = _model.rate;
    
}



@end
