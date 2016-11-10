//
//  JWDCreatQRCodeView.h
//  JWDQRCode
//
//  Created by 蒋伟东 on 2016/11/10.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^distinguishQRCode) (NSString *qRCodeUrl);


@interface JWDCreatQRCodeView : UIImageView

@property (nonatomic, copy) distinguishQRCode   distinguishQRCode;//!< 识别二维码跳转

- (instancetype)initWithFrame:(CGRect)frame withQRCodeString:(NSString *)qRCodeString withQRCodeCenterImage:(NSString *)qRCodeCenterImage;

@end

