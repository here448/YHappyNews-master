//
//  HRequestCommentModel.m
//  YHappy
//
//  Created by hare27 on 16/8/16.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HRequestCommentModel.h"

@implementation HRequestCommentModel

+(NSDictionary<NSString *,Class> *)modelClassForArr{
    return @{@"data":[HCommentModel class],@"hot":[HCommentModel class]};
}


@end
