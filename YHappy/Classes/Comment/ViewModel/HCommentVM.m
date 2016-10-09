//
//  HCommentVM.m
//  YHappy
//
//  Created by hare27 on 16/8/16.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HCommentVM.h"
#import "HBaseNetManager.h"
#import "HRequestCommentModel.h"

@implementation HCommentVM

-(void)refreshCommentCompletionHandler:(void(^)(NSError *error))complete{
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.essence.ID;
    params[@"hot"] = @1; // @"1";
    
    __weak typeof(self) weakSelf = self;
    [self.commentArr removeAllObjects];
    [self cancelTask];
    
    NSURLSessionDataTask * task = [HBaseNetManager GET:@"http://api.budejie.com/api/api_open.php" parameters:params completionHandler:^(id responseObj, NSError *error) {
        
        if ([responseObj isKindOfClass:[NSDictionary class]]) {
            
            HRequestCommentModel *requestComment = [HRequestCommentModel objWithKeyValues:responseObj];
            [weakSelf.commentArr addObjectsFromArray:requestComment.data];
            weakSelf.hot_commentArr = requestComment.hot;
            weakSelf.total = requestComment.total;
            if (requestComment.total == self.commentArr.count ) {
                weakSelf.isMore = NO;
            }else{
                weakSelf.isMore = YES;
            }
        }
        complete(error);
    }];
    [self.dataTaskArr addObject:task];
}

-(void)loadMoreCommentCompletionHandler:(void(^)(NSError *error))complete{
    
    if (self.isMore == NO) {
        return;
    }
    [self cancelTask];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.essence.ID;
    params[@"lastcid"] = self.commentArr.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask * task = [HBaseNetManager GET:@"http://api.budejie.com/api/api_open.php" parameters:params completionHandler:^(id responseObj, NSError *error) {
        
        if ([responseObj isKindOfClass:[NSDictionary class]]) {
            
            HRequestCommentModel *requestComment = [HRequestCommentModel objWithKeyValues:responseObj];
            [weakSelf.commentArr addObjectsFromArray:requestComment.data];
            weakSelf.total = requestComment.total;

            if (requestComment.total == self.commentArr.count ) {
                weakSelf.isMore = NO;
            }else{
                weakSelf.isMore = YES;
            } 
        }
        complete(error);
    }];
    
    [self.dataTaskArr addObject:task];
    
}

- (NSMutableArray<HCommentModel *> *)commentArr {
    if(_commentArr == nil) {
        _commentArr = [[NSMutableArray<HCommentModel *> alloc] init];
    }
    return _commentArr;
}

@end
