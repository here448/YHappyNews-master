//
//  HCommentVM.h
//  YHappy
//
//  Created by hare27 on 16/8/16.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HBaseViewModel.h"
#import "HCommentModel.h"
#import "HEssenceModel.h"

@interface HCommentVM : HBaseViewModel

@property(nonatomic,strong)HEssenceModel *essence;

@property(nonatomic,strong)NSMutableArray<HCommentModel *> *commentArr;

@property(nonatomic,strong)NSArray<HCommentModel *> *hot_commentArr;

@property(nonatomic,assign)int total;

@property(nonatomic,assign)BOOL isMore;

-(void)refreshCommentCompletionHandler:(void(^)(NSError *error))complete;

-(void)loadMoreCommentCompletionHandler:(void(^)(NSError *error))complete;

@end
