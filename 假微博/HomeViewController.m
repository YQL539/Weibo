//
//  ViewController.m
//  假微博
//
//  Created by yangqinglong on 16/3/28.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "HomeViewController.h"
#import <SVPullToRefresh.h>
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "WeiboView.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSArray *dataSourceArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建tableview
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTableView.delegate =self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:_myTableView];
    
    //导入下拉刷新
    __weak typeof(self)weakSelf = self;
    [_myTableView addPullToRefreshWithActionHandler:^{
        //下载数据
        [[WeiboManager shareManager] loadWeiboInfo:^(NSArray *modelsArray) {
            [weakSelf.myTableView.pullToRefreshView stopAnimating];
            weakSelf.dataSourceArray = modelsArray;
            [weakSelf.myTableView reloadData];
            
            
        }];
        
    }];
}
#pragma mark------------tableview delegate datasource------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [WeiboCell cellHeightWithModel:[_dataSourceArray objectAtIndex:indexPath.section]];
}
-(WeiboCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboCell *cell = [WeiboCell cellWithTableView:tableView indexPath:indexPath];
    //得到对应的微博信息
    cell.weibo = [_dataSourceArray objectAtIndex:indexPath.section];
 
    return cell;
}
@end

















