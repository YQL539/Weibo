//
//  DiscoverViewController.m
//  UITabBarController
//
//  Created by yangqinglong on 16/1/21.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "DiscoverViewController.h"
#import "BookModels.h"
#import "BooksCell.h"
#import "Model.h"
#define imageHeight 200.0f
#define iconMargin 10
#define iconW 80
#define iconH 80



@interface DiscoverViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *booksArray;
@property (nonatomic,strong) UITableView *booksTableView;
@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UIImageView *iconImageView;
@end
@implementation DiscoverViewController
-(NSArray *)booksArray{
    if (_booksArray == nil) {
        self.booksArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Bookslist.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in arrayDict) {
            Model *newMd = [[Model alloc]init];
            BookModels *model = [BookModels BookModelWithDict:dict];
            newMd.bookModel = model;
            newMd.rate = 0;
            [_booksArray addObject:newMd];
        }
    }
    return _booksArray;
}

-(void)viewDidLoad{
//    [self.booksTableView reloadData];
    self.booksTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-12) style:UITableViewStyleGrouped];
    _booksTableView.delegate = self;
    _booksTableView.dataSource = self;
    [self.view addSubview:_booksTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rateDidChanged:) name:@"BookRatingChangedNotificationName" object:nil];
    
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, imageHeight)];
    self.topImageView.image = [UIImage imageNamed:@"bookicon"];
    [self.booksTableView addSubview:_topImageView];
}

-(void)rateDidChanged:(NSNotification *)notifi{
    NSDictionary *dict = notifi.object;
    NSInteger row = [[dict objectForKey:@"row"]integerValue];
    CGFloat newRate = [[dict objectForKey:@"rate"]floatValue];
    Model *model = [_booksArray objectAtIndex:row];
    model.rate = newRate;
    [_booksArray replaceObjectAtIndex:row withObject:model];
    
}
#pragma delegate-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.booksArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return imageHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(BooksCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BooksCell *cell = [BooksCell booksCellWithTableView:tableView];
    cell.model = [self.booksArray objectAtIndex:indexPath.row];
    cell.row = indexPath.row;
    return cell;
}

//下拉放大
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = self.booksTableView.contentOffset.y;
    if (offsetY < 0) {
        self.topImageView.frame = CGRectMake(offsetY/2, offsetY, self.booksTableView.frame.size.width - offsetY, imageHeight - offsetY);
    }
}
@end







