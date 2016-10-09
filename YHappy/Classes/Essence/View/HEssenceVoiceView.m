//
//  XMGTopicVoiceView.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/17.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "HEssenceVoiceView.h"
#import <UIImageView+WebCache.h>
#import "HEssenceModel.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HEssenceVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation HEssenceVoiceView
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setEssence:(HEssenceModel *)essence{
    _essence = essence;

    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:essence.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", essence.playcount];
    
    NSInteger minute = essence.voicetime.intValue / 60;
    NSInteger second = essence.voicetime.intValue % 60;
    
    // %04zd - 占据4位,空出来的位用0来填补
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}
- (IBAction)clickPlayVideo:(id)sender {
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.essence.videouri]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playerVC animated:YES completion:nil];
    
}

@end
