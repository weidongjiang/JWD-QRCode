//
//  ViewController.m
//  JWDQRCode
//
//  Created by 蒋伟东 on 2016/11/10.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "JWDPreView.h"
#import <SafariServices/SafariServices.h>
#import "JWDQRCodeViewController.h"
#import "JWDCreatQRCodeView.h"

@interface ViewController ()

@property(nonatomic, strong)UIButton              *code;//!< <#value#>
@property(nonatomic, strong)UIButton              *code1;//!< <#value#>
@property(nonatomic, strong)JWDCreatQRCodeView    *creatQRCodeView;//!< <#value#>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat X = (self.view.frame.size.width - 2*100)/3.0;
    
    _code = [[UIButton alloc] initWithFrame:CGRectMake(X, 100, 100, 60)];
    _code.backgroundColor = [UIColor yellowColor];
    [_code setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_code setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_code addTarget:self action:@selector(codeDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_code];
    
    
    _code1 = [[UIButton alloc] initWithFrame:CGRectMake(2*X + 100, 100, 100, 60)];
    _code1.backgroundColor = [UIColor yellowColor];
    [_code1 setTitle:@"生成二维码" forState:UIControlStateNormal];
    [_code1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_code1 addTarget:self action:@selector(code1DidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_code1];
    
}
- (void)codeDidClick {
    
    JWDQRCodeViewController *QRCodeVC = [[JWDQRCodeViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self presentViewController:QRCodeVC animated:YES completion:nil];

}

- (void)code1DidClick {

    JWDCreatQRCodeView *creatQRCodeView = [[JWDCreatQRCodeView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)*0.5, 300, 200, 200) withQRCodeString:@"http://www.jianshu.com/users/5b9953c3d3ad/latest_articles" withQRCodeCenterImage:@"me"];
    self.creatQRCodeView = creatQRCodeView;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDid)];
    creatQRCodeView.userInteractionEnabled = YES;
    [creatQRCodeView addGestureRecognizer:longPress];
    
    [self.view addSubview:creatQRCodeView];
    
}

- (void)longPressDid{
    
    // 0.创建上下文
    CIContext *context = [[CIContext alloc] init];
    
    // 1.创建一个探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    
    // 2.直接开始识别图片,获取图片特征
    CIImage *imageCI = [[CIImage alloc] initWithImage:self.creatQRCodeView.image];
    NSArray<CIFeature *> *features = [detector featuresInImage:imageCI];
    CIQRCodeFeature *codef = (CIQRCodeFeature *)features.firstObject;
    
    // 弹框
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"识别图中二维码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }]];
    __weak ViewController *weakSelf = self;
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:codef.messageString]];
        [weakSelf presentViewController:safariVC animated:YES completion:nil];
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
