//
//  UIImageView+userIcon.m
//  YHappy
//
//  Created by hare27 on 16/8/14.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "UIImageView+userIcon.h"
#import <UIImage+Circle.h>
#import <UIImageView+WebCache.h>

@implementation UIImageView (userIcon)

-(void)setUserIcon:(NSString *)iconURL{
    
    UIImage *placeholderImage = [UIImage imageNamed:@"defaultUserIcon"].circleImage;
    
    [self sd_setImageWithURL:[NSURL URLWithString:iconURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) {
            return ;
        }
        self.image = image.circleImage;
        
    }];
    
}

@end
