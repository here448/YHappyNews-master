//
//  HEssenceUserModel.h
//  YHappy
//
//  Created by hare27 on 16/8/7.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HBaseModel.h"

@interface HEssenceUserModel : HBaseModel

@property (nonatomic ,assign) BOOL is_vip;

@property (nonatomic ,copy) NSString *qq_uid;

@property (nonatomic ,copy) NSString *personal_page;

@property (nonatomic ,copy) NSString *ID;

@property (nonatomic ,copy) NSString *weibo_uid;

@property (nonatomic ,copy) NSString *username;

@property (nonatomic ,copy) NSString *qzone_uid;

@property (nonatomic ,copy) NSString *total_cmt_like_count;

@property (nonatomic ,copy) NSString *sex;

@property (nonatomic ,copy) NSString *profile_image;

@end
