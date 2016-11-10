//
//  JWDCreatQRCodeView.h
//  JWDQRCode
//
//  Created by 蒋伟东 on 2016/11/10.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWDCreatQRCodeView : UIImageView

- (instancetype)initWithFrame:(CGRect)frame withQRCodeString:(NSString *)qRCodeString withQRCodeCenterImage:(NSString *)qRCodeCenterImage;

@end

