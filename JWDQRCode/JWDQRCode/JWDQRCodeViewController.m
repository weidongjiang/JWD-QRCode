//
//  JWDQRCodeViewController.m
//  JWDQRCode
//
//  Created by 蒋伟东 on 2016/11/10.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "JWDQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "JWDPreView.h"
#import <SafariServices/SafariServices.h>

@interface JWDQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic, strong)AVCaptureDeviceInput        *deviceInput;//!< 摄像头输入
@property(nonatomic, strong)AVCaptureMetadataOutput     *metadataOutput;//!< 输出
@property(nonatomic, strong)AVCaptureSession            *session;//!< 会话
@property(nonatomic, strong)AVCaptureVideoPreviewLayer  *previewLayer;//!< 预览
@property(nonatomic, strong)JWDPreView                  *preView;//!< <#value#>

@end

@implementation JWDQRCodeViewController

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.view.frame = frame;
        [self initUiConfig];
    }
    return self;
}



-(void)initUiConfig {

    // 默认为后置摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:NULL];
    
    // 解析输入的数据
    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 会话
    self.session = [[AVCaptureSession alloc] init];
    if ([self.session canAddInput:self.deviceInput]){
        [self.session addInput:self.deviceInput];
    }
    if([self.session canAddOutput:self.metadataOutput]){
        [self.session addOutput:self.metadataOutput];
    }
    // 设置数据采集质量
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    
    // 设置需要解析的数据类型，二维码
    self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    JWDPreView *preView = [[JWDPreView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.preView = preView;
    [self.view addSubview:preView];
    preView.session = self.session;
    
    preView.backPreView = ^(JWDPreView *backPreView){
        
        [self dismissViewControllerAnimated:YES completion:nil];
    
    };
    
    [self.session startRunning];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
//    [self.session stopRunning];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.preView removeFromSuperview];
    
    for (AVMetadataMachineReadableCodeObject *obj in metadataObjects) {
        
        NSLog(@"%@",obj.stringValue);
    
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:obj.stringValue]];
        [self presentViewController:safariVC animated:YES completion:nil];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
