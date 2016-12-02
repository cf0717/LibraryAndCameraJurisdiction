//
//  LibraryAndCream.h
//  相册权限
//
//  Created by chaofan on 2016/12/1.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CFLibraryAndCameraDelegate <NSObject>

//消失界面
-(void)dismissLibraryAndCameraPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo;
//选择界面取消按钮点击
-(void)didCancel;

@end

//导入相册库 iOS7
#import <AssetsLibrary/AssetsLibrary.h>
//导入相册库 iOS8
#import <Photos/Photos.h>
//iOS10要在plist文件中增加
//<key>NSPhotoLibraryUsageDescription</key>
//<string>App需要您的同意,才能访问相册</string>


//导入相机框架
#import <AVFoundation/AVFoundation.h>
//iOS10要在plist文件中增加
//<key>NSCameraUsageDescription</key>
//<string>App需要您的同意,才能访问相机</string>

@interface CFLibraryAndCamera : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImagePickerController *imgPickerVC;
@property (nonatomic,assign)id <CFLibraryAndCameraDelegate> delegate;

/** 打开相册 */
-(void)picBtnClike:(UIViewController *)viewController;

/** 打开相机 */
-(void)cameraBtnClike:(UIViewController *)viewController;

/** 图片是否编辑 */
@property (nonatomic,assign,getter=isAllowsEditing) BOOL allowsEditing;

/** 判断设备是否有摄像头 */
-(BOOL)isCameraAvailable;

/** 前面的摄像头是否可用 */
-(BOOL)isFrontCameraAvailable;

/** 后面的摄像头是否可用 */
-(BOOL)isRearCameraAvailable;

@end
