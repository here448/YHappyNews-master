//
//  HEssenceModel.m
//  YHappy
//
//  Created by hare27 on 16/6/23.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HEssenceModel.h"
#import <HDateTool.h>

@implementation HEssenceIndexModel

+(NSDictionary<NSString *,Class> *)modelClassForArr{
    return @{@"list":[HEssenceModel class]};
}

@end



// 第二层:info
@implementation HEssenceInfoModel
@end


#define HMargin 10
// 第二层:list
@interface HEssenceModel()

@property(nonatomic,assign)HDateTool *dateTool;

@end

@implementation HEssenceModel

+(NSDictionary<NSString *,NSString *> *)modelReplaceKeyForSystem{
    return @{@"ID":@"id",
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1"};
}

+(NSDictionary<NSString *,Class> *)modelClassForArr{
    return @{@"top_cmt":[HCommentModel class]};
}

- (HDateTool *)dateTool {
	if(_dateTool == nil) {
        _dateTool = [HDateTool sharedDateTool];
	}
	return _dateTool;
}

-(NSString *)created_at{
    NSDate *date = [self.dateTool getDateWithFormat:@"yyyy-MM-dd HH:mm:ss" Frome:_created_at];
    return [self.dateTool getStringSinceNowForDate:date];
}

-(HEssenceType)essenceType{
    return self.type.intValue;
}

- (CGFloat)cell_height {
    
    if(_cell_height == 0) {
        
        // 1. 头像底部加间距
        _cell_height = 55;
        
        // 2. 文字
        CGFloat textMaxW = HScreenW - 2 * 10;
        CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
        // CGSize textSize = [self.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textMaxSize];
        CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
        _cell_height += textSize.height + HMargin;
        
        // 3. 内容
        if (self.essenceType != HEssenceTypeWord) {
            CGFloat contentH = textMaxW * self.height.floatValue / self.width.floatValue ;
            if (contentH >= [UIScreen mainScreen].bounds.size.height) { // 超长图片
                // 将超长图片的高度变为200
                contentH = 200;
                self.bigPicture = YES;
            }
            
            // 这里的cellHeight就是中间内容的y值
            self.contentF = CGRectMake(HMargin, _cell_height, textMaxW, contentH);
            
            _cell_height += contentH + HMargin;
        }
        
        // 4. 最热评论
        if (self.top_cmt.count) {
            
            NSString *content = nil;
            
            if (self.top_cmt.firstObject.voiceuri.length) {
                content = @"[语音评论]";
            }else{
                content = self.top_cmt.firstObject.content;
            }
            
            NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.firstObject.user.username, content];
            // CGSize topCmtContentSize = [topCmtContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:textMaxSize];
            CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
            _cell_height += 20 + HMargin + topCmtContentSize.height + HMargin;
            
        }
        
        // 5. 底部
        _cell_height += 35 + HMargin;
        
    }
    return _cell_height;
}

@end
