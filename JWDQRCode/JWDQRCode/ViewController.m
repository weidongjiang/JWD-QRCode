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

@property(nonatomic, strong)UIButton *code;//!< <#value#>
@property(nonatomic, strong)UIButton *code1;//!< <#value#>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor greenColor];
    
    _code = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 60)];
    _code.backgroundColor = [UIColor yellowColor];
    [_code setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_code setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_code addTarget:self action:@selector(codeDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_code];
    
    
    _code1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 100, 60)];
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

    JWDCreatQRCodeView *creatQRCodeView = [[JWDCreatQRCodeView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)*0.5, 300, 100, 100) withQRCodeString:@"http://www.jianshu.com/users/5b9953c3d3ad/latest_articles" withQRCodeCenterImage:@"me"];
    [self.view addSubview:creatQRCodeView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
