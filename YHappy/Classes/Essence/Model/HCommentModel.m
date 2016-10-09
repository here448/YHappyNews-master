//
//  HTop_cmtModel.m
//  YHappy
//
//  Created by hare27 on 16/8/7.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HCommentModel.h"

@implementation HCommentModel

+(NSDictionary<NSString *,NSString *> *)modelReplaceKeyForSystem{
    return @{@"ID":@"id"};
}

+(NSDictionary<NSString *,Class> *)modelClassForArr{
    return @{@"precmt":[HCommentModel class]};
}

-(CGFloat)rowHeight{
    
    // label顶部
    CGFloat h = 44;
    
    CGFloat w = HScreenW - 115;
    UIFont *font = [UIFont systemFontOfSize:19];
    
    // lable高度
    CGFloat contentH = [self.content boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.height;
    
    // lable底部+间距
    h += contentH + kHMargin;
    
    // 如果小于点赞数量的底部+间距
    if (h < 89) {
        h = 89;
    }
    
    return h;
}

@end
