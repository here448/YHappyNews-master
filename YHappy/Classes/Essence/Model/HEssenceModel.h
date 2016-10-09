//
//  HEssenceModel.h
//  YHappy
//
//  Created by hare27 on 16/6/23.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HBaseModel.h"
#import "HCommentModel.h"

@class HEssenceInfoModel,HEssenceModel;


@interface HEssenceIndexModel : HBaseModel

@property (nonatomic ,strong) HEssenceInfoModel *info;

@property (nonatomic ,strong) NSArray<HEssenceModel *> *list;

@end



// 第二层:info
@interface HEssenceInfoModel : HBaseModel

@property (nonatomic ,copy) NSString *maxid;

@property (nonatomic ,copy) NSString *vendor;

@property (nonatomic ,assign) int count;

@property (nonatomic ,copy) NSString *maxtime;

@property (nonatomic ,assign) int page;

@end


typedef NS_ENUM(NSUInteger, HEssenceType) {
    HEssenceTypePicture = 10,
    HEssenceTypeWord = 29,
    HEssenceTypeVioce = 31,
    HEssenceTypeVideo = 41
};

// 第二层:list
@interface HEssenceModel : HBaseModel

/** cell的高度，非服务器返回*/
@property(nonatomic,assign)CGFloat cell_height;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentF;


/** 用户的头像 */
@property (nonatomic ,copy) NSString *profile_image;
/** 用户的名字 */
@property (nonatomic ,copy) NSString *name;
/** 帖子审核通过的时间 */
@property (nonatomic ,copy) NSString *created_at;

/** 帖子的文字内容 */
@property (nonatomic ,copy) NSString *text;
/** 帖子的类型*/
@property (nonatomic ,copy) NSString *type;
/** 帖子的类型 自定义的，非服务器返回*/
@property (nonatomic ,assign) HEssenceType essenceType;

/** 踩数量 */
@property (nonatomic ,copy) NSString *cai;
/** 转发\分享数量 */
@property (nonatomic ,copy) NSString *repost;
/** 顶数量 */
@property (nonatomic ,copy) NSString *ding;
/** 评论数量 */
@property (nonatomic ,copy) NSString *comment;
/** 最热评论*/
@property (nonatomic ,strong) NSArray<HCommentModel *> *top_cmt;


/** 音频时长 */
@property (nonatomic ,copy) NSString *voicetime;
/** 视频时长 */
@property (nonatomic ,copy) NSString *videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;


/** 是否为gif动画图片 */
@property (nonatomic ,copy) NSString *is_gif;
/** 小图 */
@property (nonatomic ,copy) NSString *small_image;
/** 中图 */
@property (nonatomic ,copy) NSString *middle_image;
/** 大图 */
@property (nonatomic ,copy) NSString *large_image;


@property (nonatomic ,assign) int cache_version;

@property (nonatomic ,copy) NSString *ID;

@property (nonatomic ,copy) NSString *voicelength;

@property (nonatomic ,copy) NSString *bimageuri;

@property (nonatomic ,copy) NSString *theme_type;

@property (nonatomic ,copy) NSString *hate;

@property (nonatomic ,copy) NSString *passtime;

@property (nonatomic ,copy) NSString *tag;

@property (nonatomic ,copy) NSString *cdn_img;

@property (nonatomic ,copy) NSString *theme_name;

@property (nonatomic ,copy) NSString *create_time;

@property (nonatomic ,copy) NSString *favourite;

@property (nonatomic ,strong) NSArray *themes;

@property (nonatomic ,copy) NSString *height;

@property (nonatomic ,copy) NSString *status;

@property (nonatomic ,copy) NSString *bookmark;

@property (nonatomic ,copy) NSString *screen_name;

@property (nonatomic ,copy) NSString *love;

@property (nonatomic ,copy) NSString *user_id;

@property (nonatomic ,copy) NSString *theme_id;

@property (nonatomic ,copy) NSString *original_pid;

@property (nonatomic ,copy) NSString *gifFistFrame;

@property (nonatomic ,assign) int t;

@property (nonatomic ,copy) NSString *weixin_url;

@property (nonatomic ,copy) NSString *voiceuri;

@property (nonatomic ,copy) NSString *videouri;

@property (nonatomic ,copy) NSString *width;



@end





