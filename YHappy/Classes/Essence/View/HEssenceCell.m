//
//  HEssenceCell.m
//  YHappy
//
//  Created by hare27 on 16/6/23.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HEssenceCell.h"
#import <UIImageView+WebCache.h>
#import "HEssencePictureView.h"
#import "HEssenceVideoView.h"
#import "HEssenceVoiceView.h"
#import "UIImageView+userIcon.h"

@interface HEssenceCell ()

// 顶部
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

// 中间内容
@property (weak, nonatomic) IBOutlet UIView *centerView;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/** 图片控件 */
@property (nonatomic, strong) HEssencePictureView *pictureView;
/** 声音控件 */
@property (nonatomic, strong) HEssenceVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, strong) HEssenceVideoView *videoView;

// 底部
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation HEssenceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

-(void)setEssenceModel:(HEssenceModel *)essenceModel{
    
    _essenceModel = essenceModel;
    
    [self.self.profileImageView setUserIcon:essenceModel.profile_image];
    self.nameLabel.text = essenceModel.name;
    self.createdAtLabel.text = essenceModel.created_at;
    self.text_label.text = essenceModel.text;
    
    // 最热评论
    if (essenceModel.top_cmt.count) {
        self.topCmtView.hidden = NO;
        NSString *username = essenceModel.top_cmt.firstObject.user.username;
        NSString *content = nil;
        if (essenceModel.top_cmt.firstObject.voiceuri.length) {
            content = @"[语音评论]";
        }else{
            content = essenceModel.top_cmt.firstObject.content;
        }
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    }else{
        self.topCmtView.hidden = YES;
    }
    
    [self setupButton:self.dingButton number:essenceModel.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:essenceModel.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:essenceModel.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:essenceModel.comment placeholder:@"评论"];
    
    switch (essenceModel.essenceType) {
        case HEssenceTypePicture: {
            self.pictureView.frame = essenceModel.contentF;
            self.pictureView.essence = essenceModel;
            break;
        }
        case HEssenceTypeWord: {
            break;
        }
        case HEssenceTypeVioce: {
            self.voiceView.frame = essenceModel.contentF;
            self.voiceView.essence = essenceModel;
            break;
        }
        case HEssenceTypeVideo: {
            self.videoView.frame = essenceModel.contentF;
            self.videoView.essence = essenceModel;
            break;
        }
    }
    
}

- (void)setupButton:(UIButton *)button number:(NSString *)number placeholder:(NSString *)placeholder
{
    int count = number.intValue;
    if (count >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", count / 10000.0] forState:UIControlStateNormal];
    } else if (count > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", count] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= kHMargin;
    frame.origin.y += kHMargin;
    
    [super setFrame:frame];
}

- (HEssencePictureView *)pictureView {
	if(_pictureView == nil) {
		_pictureView = [[NSBundle mainBundle] loadNibNamed:@"HEssencePictureView" owner:nil options:0].firstObject;
        [self.contentView addSubview:_pictureView];
	}
	return _pictureView;
}

- (HEssenceVoiceView *)voiceView {
	if(_voiceView == nil) {
		_voiceView =  [[NSBundle mainBundle] loadNibNamed:@"HEssenceVoiceView" owner:nil options:0].firstObject;
        [self.contentView addSubview:_voiceView];
	}
	return _voiceView;
}

- (HEssenceVideoView *)videoView {
	if(_videoView == nil) {
		_videoView =  [[NSBundle mainBundle] loadNibNamed:@"HEssenceVideoView" owner:nil options:0].firstObject;
        [self.contentView addSubview:_videoView];
	}
	return _videoView;
}

@end
