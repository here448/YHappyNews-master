//
//  HCommentVC.m
//  YHappy
//
//  Created by hare27 on 16/8/14.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HCommentVC.h"
#import "HCommentVM.h"
#import "HTableHeaderView.h"
#import "HCommentCell.h"
#import "HEssenceCell.h"
#import <MJRefresh.h>

@interface HCommentVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)HCommentVM *commentVM;
@property(nonatomic,strong)NSArray *top_comment;

@end

@implementation HCommentVC

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kHBackgroudColor;

    self.navigationItem.title = @"评论";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupTableView];

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.essence.top_cmt = self.top_comment;
    self.essence.cell_height = 0;
}

#pragma mark - system Methods

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

#pragma mark - 自定义 Methods

-(void)setupTableView{
    
    HEssenceCell *headView = [[NSBundle mainBundle] loadNibNamed:@"HEssenceCell" owner:nil options:nil].firstObject;
    self.top_comment = self.essence.top_cmt;
    self.essence.top_cmt = nil;
    self.essence.cell_height = 0;
    
    headView.essenceModel = self.essence;
    headView.frame = CGRectMake(0, 0, HScreenW, self.essence.cell_height);
    UIView *tempView = [[UIView alloc]init];
    tempView.frame = CGRectMake(0, 0, HScreenW, self.essence.cell_height);
    [tempView addSubview:headView];
    self.tableView.tableHeaderView = tempView;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kHBackgroudColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"commentHeader"];
    [self.tableView registerClass:[HCommentCell class] forCellReuseIdentifier:@"commentCell"];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self.commentVM refreshCommentCompletionHandler:^(NSError *error) {
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (self.commentVM.isMore == NO) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.commentVM loadMoreCommentCompletionHandler:^(NSError *error) {
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            if (self.commentVM.isMore == NO) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
}

-(void)keyboardWillChangeFrame:(NSNotification *)noti{
    // 修改约束
    CGFloat keyboardY = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH - keyboardY;
    
    // 执行动画
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.commentVM.hot_commentArr.count) {
        return 2;
    }else if(self.commentVM.commentArr.count){
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.commentVM.hot_commentArr.count && section == 0) {
        return self.commentVM.hot_commentArr.count;
    }
    return self.commentVM.commentArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];

    if (self.commentVM.hot_commentArr.count && indexPath.section == 0) {
        cell.comment = self.commentVM.hot_commentArr[indexPath.row];
    }else{
        cell.comment = self.commentVM.commentArr[indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"commentHeader"];
    
    if (section == 0 && self.commentVM.hot_commentArr.count) {
        header.textLabel.text = @"最热评论";
    } else {
        header.textLabel.text = @"最新评论";
    }
    
    return header;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.commentVM.hot_commentArr.count && indexPath.section == 0) {
        return self.commentVM.hot_commentArr[indexPath.row].rowHeight;
    }else{
        return self.commentVM.commentArr[indexPath.row].rowHeight;
    }
    
}

#pragma mark - 懒加载 Lazy Load
- (HCommentVM *)commentVM {
	if(_commentVM == nil) {
		_commentVM = [[HCommentVM alloc] init];
        _commentVM.essence = self.essence;
	}
	return _commentVM;
}

@end
