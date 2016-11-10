//
//  JWDCreatQRCodeView.m
//  JWDQRCode
//
//  Created by 蒋伟东 on 2016/11/10.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "JWDCreatQRCodeView.h"

#define KmeImageW  60
#define KmeImageH  60

@implementation JWDCreatQRCodeView


- (instancetype)initWithFrame:(CGRect)frame withQRCodeString:(NSString *)qRCodeString withQRCodeCenterImage:(NSString *)qRCodeCenterImage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initUiConfigWithQRCodeString:qRCodeString withQRCodeCenterImage:qRCodeCenterImage];
    }
    return self;
}

- (void)initUiConfigWithQRCodeString:(NSString *)qRCodeString withQRCodeCenterImage:(NSString *)qRCodeCenterImage {
    
    // 1 创建二维码过滤器
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setDefaults];
    
    // 2 生成二维码
    NSData *data = [qRCodeString dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:data forKey:@"inputMessage"];
    CIImage *codeImage = qrFilter.outputImage;
    
    // 3 拉伸
    codeImage = [codeImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
    
    // 4 绘制二维码
    UIImage *qrImage = [UIImage imageWithCIImage:codeImage];
    UIImage *meImage = [UIImage imageNamed:qRCodeCenterImage];
    
    UIGraphicsBeginImageContext(qrImage.size);
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    
    CGFloat meImageX = (qrImage.size.width - KmeImageW) * 0.5;
    CGFloat meImageY = (qrImage.size.height - KmeImageH) * 0.5;
    [meImage drawInRect:CGRectMake(meImageX, meImageY, KmeImageW, KmeImageH)];
    
    UIImage *filnalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // 5 获取绘制好的二维码
    self.image = filnalImage;
}

@end
