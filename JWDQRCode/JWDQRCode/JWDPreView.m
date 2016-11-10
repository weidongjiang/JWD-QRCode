//
//  JWDPreView.m
//  JWDQRCode
//
//  Created by 蒋伟东 on 2016/11/10.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "JWDPreView.h"

@interface JWDPreView ()
{
    UIImageView   *_imageView;
    UIImageView   *_lineImageView;
    UIButton      *_backBtn;
}

@end


@implementation JWDPreView

// 修改当前View 的图层类别
+(Class)layerClass {

    return [AVCaptureVideoPreviewLayer class];
}

-(void)setSession:(AVCaptureSession *)session {

    _session = session;
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
    layer.session = session;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUiConfig];
    }
    return self;
}
- (void)initUiConfig {
    
    _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 50, 40, 20)];
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backButtonDid) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    _imageView.frame = CGRectMake(self.bounds.size.width * 0.5 - 140, self.bounds.size.height * 0.5 - 140, 280, 280);
    [self addSubview:_imageView];
    
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _lineImageView.image = [UIImage imageNamed:@"line.png"];
    [_imageView addSubview:_lineImageView];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}
- (void)animation
{
    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _lineImageView.frame = CGRectMake(30, 260, 220, 2);
        
    } completion:^(BOOL finished) {
        _lineImageView.frame = CGRectMake(30, 10, 220, 2);
    }];
}

- (void)backButtonDid {

    if (self.backPreView){
        self.backPreView(self);
    }
}


@end
