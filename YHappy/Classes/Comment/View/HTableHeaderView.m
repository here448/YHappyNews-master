//
//  HTableHeaderView.m
//  YHappy
//
//  Created by hare27 on 16/8/16.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HTableHeaderView.h"

@implementation HTableHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kHBackgroudColor;
        self.textLabel.textColor = [UIColor darkGrayColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    self.textLabel.x = kHMargin;
}

@end
