//
//  HEssenseViewModel.m
//  YHappy
//
//  Created by hare27 on 16/6/23.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HEssenseViewModel.h"
#import "HBaseNetManager.h"
#import <HDateTool.h>

@interface HEssenseViewModel ()

@property(nonatomic,copy)NSString *maxtime;

@property(nonatomic,copy)NSString *type;

@end

@implementation HEssenseViewModel

#pragma mark - 生命周期 Life Circle

+(instancetype)essenseVMWith:(NSString *)type{
    
    HEssenseViewModel * essenseVM = [[HEssenseViewModel alloc]init];
    
    essenseVM.type = type;
    
    return essenseVM;
}

#pragma mark - 方法 Methods

-(void)refreshEssenseCompletionHandler:(void(^)(NSError *error))complete{
    [self cancelTask];
    NSURLSessionDataTask *dataTask = [HBaseNetManager GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"list",@"c":@"data",@"type":self.type} completionHandler:^(id responseObj, NSError *error) {
        
        [self.essenceArr removeAllObjects];
        
        HEssenceIndexModel *indexModel = [HEssenceIndexModel objWithKeyValues:responseObj];
        
        self.maxtime = indexModel.info.maxtime;
        
        [self.essenceArr addObjectsFromArray:indexModel.list];
        
        complete(error);
    }];
    [self.dataTaskArr addObject:dataTask];
}

-(void)loadMoreEssenseCompletionHandler:(void(^)(NSError *error))complete{
    NSURLSessionDataTask *dataTask  = [HBaseNetManager GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"list",@"c":@"data",@"maxtime":self.maxtime,@"type":self.type} completionHandler:^(id responseObj, NSError *error) {
        
        HEssenceIndexModel *indexModel = [HEssenceIndexModel objWithKeyValues:responseObj];
        
        self.maxtime = indexModel.info.maxtime;

        [self.essenceArr addObjectsFromArray:indexModel.list];
        
        complete(error);
    }];
    [self.dataTaskArr addObject:dataTask];
}

#pragma mark - 懒加载 Lazy Load

- (NSMutableArray<HEssenceModel *> *)essenceArr {
    if(_essenceArr == nil) {
        _essenceArr = [[NSMutableArray<HEssenceModel *> alloc] init];
    }
    return _essenceArr;
}

@end
