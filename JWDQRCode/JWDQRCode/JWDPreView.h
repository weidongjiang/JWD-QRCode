//
//  JWDPreView.h
//  JWDQRCode
//
//  Created by 蒋伟东 on 2016/11/10.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class JWDPreView;

typedef void(^backPreView) (JWDPreView *preView);

@interface JWDPreView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic, strong)AVCaptureSession    *session;//!< 渲染会话层
@property (nonatomic, copy) backPreView         backPreView;//!< 返回按钮回调
@property(nonatomic, strong)NSTimer             *timer;//!< <#value#>

@end
