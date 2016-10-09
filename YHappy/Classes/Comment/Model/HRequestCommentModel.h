//
//  HRequestCommentModel.h
//  YHappy
//
//  Created by hare27 on 16/8/16.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HBaseModel.h"
#import "HCommentModel.h"

@interface HRequestCommentModel : HBaseModel

@property (nonatomic ,strong) NSArray<HCommentModel *> *data;

@property (nonatomic ,copy) NSString *author;

@property (nonatomic ,assign) int total;

@property (nonatomic ,strong) NSArray<HCommentModel *> *hot;

@end
