//
//  HEssenseViewModel.h
//  YHappy
//
//  Created by hare27 on 16/6/23.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HBaseViewModel.h"
#import "HEssenceModel.h"

@interface HEssenseViewModel : HBaseViewModel

@property(nonatomic,strong)NSMutableArray<HEssenceModel *> *essenceArr;

-(void)refreshEssenseCompletionHandler:(void(^)(NSError *error))complete;

-(void)loadMoreEssenseCompletionHandler:(void(^)(NSError *error))complete;

+(instancetype)essenseVMWith:(NSString *)type;

@end
