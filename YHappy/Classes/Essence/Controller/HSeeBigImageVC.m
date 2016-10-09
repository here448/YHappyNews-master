//
//  HSeeBigImageVC.m
//  YHappy
//
//  Created by hare27 on 16/8/9.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HSeeBigImageVC.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

@interface HSeeBigImageVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic,strong)UIImageView *imageV;

@end

@implementation HSeeBigImageVC

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    scrollview.delegate = self;
    
    [self.view insertSubview:scrollview atIndex:0];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.essenceModel.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            self.saveButton.enabled = YES;
        }
    }];
    [scrollview addSubview:imageV];
    
    
    imageV.width = scrollview.width;
    imageV.height = self.essenceModel.height.doubleValue * imageV.width / self.essenceModel.width.doubleValue;
    
    imageV.x = 0;
    
    
    if (imageV.height >= scrollview.height) {
        imageV.y = 0;
        scrollview.contentSize = CGSizeMake(0, imageV.height);
    }else{
        imageV.centerY = scrollview.height * 0.5;
        
    }
    
    // 缩放比例
    CGFloat scale =  self.essenceModel.width.doubleValue / imageV.width;
    if (scale > 1.0) {
        scrollview.maximumZoomScale = scale;
    }
    
    self.imageV = imageV;

}

#pragma mark - 按钮点击事件
- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickSaveButton:(id)sender {
    
    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
            // 用户还未授权
        case PHAuthorizationStatusNotDetermined:{
            // 申请授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                // 用户点击了授权
                if (status == PHAuthorizationStatusAuthorized) {
                    [self saveImage];
                }
            }];
        }break;
            // 因为系统原因，无法方位相处
        case PHAuthorizationStatusRestricted:{
            [SVProgressHUD showErrorWithStatus:@"因为系统原因, 无法访问相册"];
        }break;
            // 用户拒绝
        case PHAuthorizationStatusDenied:{
            [SVProgressHUD showErrorWithStatus:@"访问相册被拒绝，请到[设置-隐私-照片]打开访问开关"];
        }break;
            // 用户同意
        case PHAuthorizationStatusAuthorized:{
            [self saveImage];
        }break;
    }
}

#pragma mark - 方法 Methods

-(void)saveImage{
    
    __block NSString *localIdentifier = nil;
    // 申请修改相册:异步
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 保存相片到系统相册
        // 创建一个  asset创建请求
        PHAssetCreationRequest *assetCreationRequest = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageV.image];
        // 获取占位的对象
        PHObjectPlaceholder *placeholder = assetCreationRequest.placeholderForCreatedAsset;
        // 获取占位标识
        localIdentifier = placeholder.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"图片保存失败"];
            HLog(@"%@:%@",error,error.userInfo);
            return;
        }
        // 获取相册
        PHAssetCollection *assetcollection = [self getAssetCollection];
        if (assetcollection == nil) {
            [self showError:@"创建相册失败"];
            return;
        }
        // 将图片从系统相册到自己app自己的相册中
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 获取图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[localIdentifier] options:nil].lastObject;
            // 创建修改相册的请求
            PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetcollection];
            // 添加图片到相册
            [changeRequest addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"图片保存失败"];
                HLog(@"%@:%@",error,error.userInfo);
            }else{
                [self showSuccess:@"图片保存成功"];
            }
        }];
    }];
}

/** 获取相册*/
- (PHAssetCollection *)getAssetCollection{
    
    // 获取所有相册
    PHFetchResult<PHAssetCollection *>* result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:@"与乐园"]) {
            return assetCollection;
        }
    }
    
    NSError *error = nil;
    __block NSString *localIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
  
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"与乐园"];
        PHObjectPlaceholder *placeholder = request.placeholderForCreatedAssetCollection;
        localIdentifier = placeholder.localIdentifier;
        
    } error:&error];
    
    if (error) {
        return nil;
    }else{
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[localIdentifier] options:nil].lastObject;
    }
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageV;
}
@end
