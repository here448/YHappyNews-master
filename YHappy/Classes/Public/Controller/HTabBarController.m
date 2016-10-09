//
//  HTabBarController.m
//  temp
//
//  Created by hare27 on 16/6/14.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HTabBarController.h"
#import "HNavigationController.h"
#import <HKitCategory/UIButton+block.h>
#import <HTool/HConst.h>
#import "HEssenceWordVC.h"
#import "HEssencePicVC.h"
#import "HEssenceVideoVC.h"
#import "HEssenceVoiceVC.h"

@interface HTabBarController ()

@end

@implementation HTabBarController

#pragma mark - 生命周期 Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 设置子视图控制器*/
    [self setupChildViewControllers];
}


#pragma mark - 方法 Methods

/** 设置子视图控制器*/
-(void)setupChildViewControllers{
    
    [self addChildViewController:[HEssenceWordVC new] title:@"段子" itemImageName:@"tabBar_essence_icon" selectItemImageName:@"tabBar_essence_click_icon"];
    [self addChildViewController:[HEssencePicVC new] title:@"图片" itemImageName:@"tabBar_new_icon" selectItemImageName:@"tabBar_new_click_icon"];
    [self addChildViewController:[HEssenceVoiceVC new] title:@"声音" itemImageName:@"tabBar_friendTrends_icon" selectItemImageName:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:[HEssenceVideoVC new] title:@"视频" itemImageName:@"tabBar_me_icon" selectItemImageName:@"tabBar_me_click_icon"];
    
}

/**
 *  添加一个子视图控制器
 *
 *  @param vc              控制器
 *  @param title           显示在tabbar上的title
 *  @param imageName       图片名
 *  @param selectImageName 被选中的图片名
 */
-(void)addChildViewController:(UIViewController *)vc title:(NSString *)title itemImageName:(NSString *)imageName selectItemImageName:(NSString *)selectImageName{
    vc.tabBarItem.title = title;
    if (imageName.length) {
        vc.tabBarItem.image = [UIImage imageNamed:imageName];
        if (selectImageName.length) {
            vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
        }
    }
    [self addChildViewController:[[HNavigationController alloc]initWithRootViewController:vc]];
}


@end
