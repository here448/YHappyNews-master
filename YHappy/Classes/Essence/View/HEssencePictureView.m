//
//  XMGTopicPictureView.m
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/18.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "HEssencePictureView.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "HEssenceModel.h"
#import <DALabeledCircularProgressView.h>
#import <AFNetworkReachabilityManager.h>
#import "HSeeBigImageVC.h"

@interface HEssencePictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

@implementation HEssencePictureView

- (void)awakeFromNib
{
    // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigImage)]];
    
}

-(void)seeBigImage{
    
    HSeeBigImageVC *seeBigImageVC = [[HSeeBigImageVC alloc]initWithNibName:@"HSeeBigImageVC" bundle:nil];
    seeBigImageVC.essenceModel = self.essence;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigImageVC animated:YES completion:nil];
    
    
}

-(void)setEssence:(HEssenceModel *)essence{
    _essence = essence;
    self.progressView.hidden = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:essence.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // receivedSize : 已经接收的图片大小
        // expectedSize : 图片的总大小
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
        
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    // gif
    self.gifView.hidden = !essence.is_gif.intValue;
    
    // 查看大图
    if (essence.isBigPicture) { // 超长图片
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTopLeft;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }

}

@end
