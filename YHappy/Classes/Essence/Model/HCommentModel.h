//
//  HTop_cmtModel.h
//  YHappy
//
//  Created by hare27 on 16/8/7.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HBaseModel.h"
#import "HEssenceUserModel.h"

@interface HCommentModel : HBaseModel

/** id */
@property (nonatomic ,copy) NSString *ID;
/** 评论内容*/
@property (nonatomic ,copy) NSString *content;
/** 评论用户*/
@property (nonatomic ,strong) HEssenceUserModel *user;

/** 音频文件的时长 */
@property (nonatomic ,copy) NSString *voicetime;
/** 被点赞数 */
@property (nonatomic ,copy) NSString *like_count;
/** 音频文件的路径 */
@property (nonatomic ,copy) NSString *voiceuri;



@property (nonatomic ,copy) NSString *data_id;

@property (nonatomic ,strong) NSArray<HCommentModel *> *precmt;

@property (nonatomic ,copy) NSString *ctime;

@property (nonatomic ,copy) NSString *preuid;

@property (nonatomic ,copy) NSString *status;

@property (nonatomic ,copy) NSString *precid;

/** 计算出来的行高 */
@property(nonatomic,assign)CGFloat rowHeight;


@end

