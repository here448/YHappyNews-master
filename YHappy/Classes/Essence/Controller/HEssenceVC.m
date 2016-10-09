//
//  HEssenceAllVC.m
//  YHappy
//
//  Created by hare27 on 16/6/21.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HEssenceVC.h"
#import "HEssenseViewModel.h"
#import <UIImageView+WebCache.h>
#import "HEssenceCell.h"
#import "HCommentVC.h"
#import <MJRefresh.h>

@interface HEssenceVC ()

@property(nonatomic,strong)HEssenseViewModel *essenseVM;

@end

@implementation HEssenceVC

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kHBackgroudColor;
//    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 0, 0);
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64+35, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HEssenceCell" bundle:nil] forCellReuseIdentifier:@"picture"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HEssenceCell" bundle:nil] forCellReuseIdentifier:@"word"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HEssenceCell" bundle:nil] forCellReuseIdentifier:@"vioce"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HEssenceCell" bundle:nil] forCellReuseIdentifier:@"video"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.essenseVM cancelTask];
        [self.essenseVM refreshEssenseCompletionHandler:^(NSError *error) {
            if (error == nil) {
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            }
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.essenseVM.essenceArr.count) {
            [self.essenseVM cancelTask];
            [self.essenseVM loadMoreEssenseCompletionHandler:^(NSError *error) {
                if (error == nil) {
                    [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                }
            }];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
}


#pragma mark - 方法 Methods



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.essenseVM.essenceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HEssenceModel *essence = self.essenseVM.essenceArr[indexPath.row];
    
    NSString *identigy = nil;
    HEssenceCell *cell = nil;
    
    switch (essence.essenceType) {
        case HEssenceTypePicture: {
            identigy = @"picture";
            break;
        }
        case HEssenceTypeWord: {
            identigy = @"word";
            break;
        }
        case HEssenceTypeVioce: {
            identigy = @"vioce";
            break;
        }
        case HEssenceTypeVideo: {
            identigy = @"video";
            break;
        }
    }
   
    cell = [tableView dequeueReusableCellWithIdentifier:identigy forIndexPath:indexPath];
    
    
    cell.essenceModel = essence;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.essenseVM.essenceArr[indexPath.row].cell_height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HCommentVC *commentVC = [[HCommentVC alloc]initWithNibName:@"HCommentVC" bundle:nil];
    commentVC.essence = self.essenseVM.essenceArr[indexPath.row];
    
    [self.supVC.navigationController pushViewController:commentVC animated:YES];
}


#pragma mark - 懒加载 Lazy Load

- (HEssenseViewModel *)essenseVM {
	if(_essenseVM == nil) {
		_essenseVM = [HEssenseViewModel essenseVMWith:self.type];
	}
	return _essenseVM;
}

-(NSString *)type{
    return @"1";
}

@end
