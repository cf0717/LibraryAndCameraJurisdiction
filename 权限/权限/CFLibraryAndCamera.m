//
//  LibraryAndCream.m
//  相册权限
//
//  Created by chaofan on 2016/12/1.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "CFLibraryAndCamera.h"

@interface CFLibraryAndCamera() 

@end

@implementation CFLibraryAndCamera

-(UIImagePickerController *)imgPickerVC
{
    if (!_imgPickerVC) {
        _imgPickerVC = [[UIImagePickerController alloc]init];
        _imgPickerVC.delegate = self;
    }
    return _imgPickerVC;
}

#pragma mark - 属性设置
-(void)setAllowsEditing:(BOOL)allowsEditing
{
    _allowsEditing = allowsEditing;
    self.imgPickerVC.allowsEditing = _allowsEditing;
}

#pragma mark - 摄像头和相册相关的公共类
// 判断设备是否有摄像头
-(BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
-(BOOL)isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
-(BOOL)isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}


/** 打开相机 */
-(void)cameraBtnClike:(UIViewController *)viewController{
    //判断相机是否可用
    if (![self isCameraAvailable]) {
        [self showAlertViewTitle:@"温馨提示" message:@"相机不可用" viewController:viewController];
        return;
    }
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    /*
     AVAuthorizationStatusNotDetermined  不确定(第一次打开)
     AVAuthorizationStatusRestricted  受限制
     AVAuthorizationStatusDenied  拒绝
     AVAuthorizationStatusAuthorized  经授权
     */
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        [self showAlertViewTitle:@"没有相机访问权限" message:@"请到设置中心设置权限\n设置->隐私->相机" viewController:viewController];
    }
    
    //打开相机
    self.imgPickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [viewController presentViewController:self.imgPickerVC animated:YES completion:nil];
}


/** 打开相册 */
-(void)picBtnClike:(UIViewController *)viewController{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <8.0) {
        //iOS7
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        /*
         ALAuthorizationStatusNotDetermined  不确定(第一次打开)
         ALAuthorizationStatusRestricted  受限制
         ALAuthorizationStatusDenied  拒绝
         ALAuthorizationStatusAuthorized  经授权
         */
        if (status == ALAuthorizationStatusRestricted || status ==ALAuthorizationStatusDenied) {
            [self showAlertViewTitle:@"没有相册访问权限" message:@"请到设置中心设置权限\n设置->隐私->相机" viewController:viewController];
        }
        
    }else{
        //iOS7以上
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        /*
         PHAuthorizationStatusNotDetermined  不确定(第一次打开)
         PHAuthorizationStatusRestricted  受限制
         PHAuthorizationStatusDenied  拒绝
         PHAuthorizationStatusAuthorized  经授权
         */
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
            [self showAlertViewTitle:@"没有相册访问权限" message:@"请到设置中心设置权限\n设置->隐私->照片" viewController:viewController];
        }
    }
    
    //打开相册
    self.imgPickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [viewController presentViewController:self.imgPickerVC animated:YES completion:nil];
}


/**
 只带确定的alertView简单弹框
 
 @param titleStr 标题
 @param message 内容
 */
-(void)showAlertViewTitle:(NSString *)titleStr message:(NSString *)message viewController:(UIViewController *)viewController{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <8.0) {
        //iOS7
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:titleStr message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else{
        //iOS7以上
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        //显示
        [viewController presentViewController:alert animated:YES completion:nil];
        return;
    }
}

#pragma mark - UIImagePickerControllerDelegate
/** 选取图片后执行方法 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    NSLog(@"%p",picker);
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.delegate dismissLibraryAndCameraPickingImage:image editingInfo:editingInfo];
}


/** 点击取消执行方法 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.delegate didCancel];
}

@end
