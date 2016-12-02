//
//  ViewController.m
//  权限
//
//  Created by chaofan on 2016/12/1.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "ViewController.h"
#import "CFLibraryAndCamera.h"

#define kScreen [UIScreen mainScreen].bounds.size

@interface ViewController () <CFLibraryAndCameraDelegate>

@property (nonatomic,strong) CFLibraryAndCamera *libraryandCamera;
@property (nonatomic,strong) UIImageView *bgimv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"权限问题";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bgimv = [[UIImageView alloc]init];
    _bgimv.center = CGPointMake(kScreen.width*0.5, 164+30);
    _bgimv.bounds = CGRectMake(0, 0, 200, 200);
    _bgimv.backgroundColor = [UIColor grayColor];
    _bgimv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_bgimv];
    
    UIButton *picBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, kScreen.height-150, kScreen.width-60, 50)];
    [picBtn setTitle:@"选取照片" forState:UIControlStateNormal];
    picBtn.backgroundColor = [UIColor blueColor];
    [picBtn addTarget:self action:@selector(picBtnClike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:picBtn];
    
    UIButton *creamBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, kScreen.height-90, kScreen.width-60, 50)];
    [creamBtn setTitle:@"选取相机" forState:UIControlStateNormal];
    creamBtn.backgroundColor = [UIColor blueColor];
    [creamBtn addTarget:self action:@selector(creamBtnClike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creamBtn];

}

#pragma mark - 自己创建的方法
//懒加载创建
-(CFLibraryAndCamera *)libraryandCamera
{
    if (!_libraryandCamera) {
        _libraryandCamera = [[CFLibraryAndCamera alloc]init];
        _libraryandCamera.delegate = self;
        _libraryandCamera.allowsEditing = YES;
    }
    return _libraryandCamera;
}

//打开相册
-(void)picBtnClike{
    [self.libraryandCamera picBtnClike:self];
}


//打开相机
-(void)creamBtnClike{
    [self.libraryandCamera cameraBtnClike:self];
}

//消失界面
-(void)dismissLibraryAndCameraPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    _bgimv.image = image;
}

//选择界面取消按钮点击
-(void)didCancel
{
    NSLog(@">>>>>>>>>");
}


@end
