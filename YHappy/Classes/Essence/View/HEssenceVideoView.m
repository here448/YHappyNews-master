//
//  XMGTopicVideoView.m
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "HEssenceVideoView.h"
#import <UIImageView+WebCache.h>
#import "HEssenceModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface HEssenceVideoView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;
@end

@implementation HEssenceVideoView
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setEssence:(HEssenceModel *)essence{
    _essence = essence;
    
    if (_playerLayer) {
        [_player pause];
        [_playerLayer removeFromSuperlayer];
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:essence.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", essence.playcount];
    
    NSInteger minute = essence.videotime.intValue / 60;
    NSInteger second = essence.videotime.intValue % 60;
    
    // %04zd - 占据4位,空出来的位用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
    
    
}

- (IBAction)clickPlayVideo:(id)sender {
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.essence.videouri]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playerVC animated:YES completion:nil];
    
}

@end
