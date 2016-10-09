//
//  HBaseViewModel.h
//  YHappy
//
//  Created by hare27 on 16/6/23.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import <AFNetworking.h>

@interface HBaseViewModel : NSObject

@property(nonatomic,strong) NSMutableArray *dataTaskArr;

// 取消任务
- (void)cancelTask;
// 暂停任务
- (void)suspendTask;
// 继续任务
- (void)resumeTask;



@end
