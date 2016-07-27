//
//  BooksCell.h
//  假微博
//
//  Created by 胡锦吾 on 16/6/3.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface BooksCell : UITableViewCell
@property (nonatomic,strong)Model *model;
@property (nonatomic,assign)NSInteger row;


+(BooksCell *)booksCellWithTableView:(UITableView *)tableView;
@end
