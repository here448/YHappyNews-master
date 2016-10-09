//
//  HBaseViewModel.m
//  YHappy
//
//  Created by hare27 on 16/6/23.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HBaseViewModel.h"

@implementation HBaseViewModel

#pragma mark - 方法 Methods
- (void)cancelTask{
    // 让一个数组里面的所有元素，执行一个方法
    [self.dataTaskArr makeObjectsPerformSelector:@selector(cancel)];
    [self.dataTaskArr removeAllObjects];
}

- (void)suspendTask{
    // 暂停任务
    [self.dataTaskArr makeObjectsPerformSelector:@selector(suspend)];
}

- (void)resumeTask{
    [self.dataTaskArr makeObjectsPerformSelector:@selector(resume)];
}

- (NSMutableArray *)dataTaskArr {
    if(_dataTaskArr == nil) {
        _dataTaskArr = [[NSMutableArray alloc] init];
    }
    return _dataTaskArr;
}

@end
