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
    
    
    // 如果要生成的二维码带有颜色 就打开2.1操作
    
     //2.1创建颜色过滤器
//    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
//    // 2.1.2设置默认值
//    [colorFilter setDefaults];
//     //2.1.3输入内容
//    /*
//     inputImage   要画颜色的图片
//     inputColor0  前景色
//     inputColor1  背景色
//     */
//    [colorFilter setValue:codeImage forKey:@"inputImage"];
//     //必须要使用CIColor
//    [colorFilter setValue:[CIColor colorWithRed:1 green:0 blue:0] forKey:@"inputColor0"];
//    [colorFilter setValue:[CIColor colorWithRed:0 green:1 blue:0] forKey:@"inputColor1"];
//    codeImage = colorFilter.outputImage;
    
    
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
