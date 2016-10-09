//
//  HCommentCell.m
//  YHappy
//
//  Created by hare27 on 16/8/16.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HCommentCell.h"
#import "UIImageView+userIcon.h"

@interface HCommentCell()

@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UIImageView *sexView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *likeCountLabel;
@property (strong, nonatomic) UIButton *voiceButton;
@property (strong, nonatomic) UIButton *likeButton;

@end

@implementation HCommentCell

- (void)awakeFromNib {
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"commentLikeButton"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.likeButton];
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.width.mas_equalTo(40);
        }];
        
        
        self.likeCountLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.likeCountLabel];
        self.likeCountLabel.font = [UIFont systemFontOfSize:16];
        self.likeCountLabel.textColor = [UIColor lightGrayColor];
        [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.likeButton.mas_bottom).offset(kHSmallMargin);
            make.centerX.mas_equalTo(self.likeButton);
            make.height.mas_equalTo(16);
        }];
        
        
        self.profileImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.profileImageView];
        [self.profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(kHMargin);
            make.width.height.mas_equalTo(40);
        }];
        
        self.sexView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.sexView];
        [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kHMargin);
            make.left.mas_equalTo(self.profileImageView.mas_right).offset(kHSmallMargin);
            make.width.height.mas_equalTo(17.5);
        }];
        
        self.usernameLabel = [[UILabel alloc]init];
        self.usernameLabel.font = [UIFont systemFontOfSize:16];
        self.usernameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.usernameLabel];
        [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kHMargin);
            make.left.mas_equalTo(self.sexView.mas_right).offset(kHSmallMargin);
            make.height.mas_equalTo(16);
        }];
        
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:19];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sexView.mas_bottom).offset(kHSmallMargin);
            make.left.mas_equalTo(self.profileImageView.mas_right).offset(kHSmallMargin);
            make.right.mas_equalTo(self.likeButton.mas_left).offset(-kHMargin);
        }];
    }
    return self;
}

- (void)setComment:(HCommentModel *)comment{
    _comment = comment;
    
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%@", comment.like_count];
    [self.profileImageView setUserIcon:comment.user.profile_image];
    
    NSString *sexImageName = [comment.user.sex isEqualToString:@"m"] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image =  [UIImage imageNamed:sexImageName];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%@''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

-(void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
    
}

@end
