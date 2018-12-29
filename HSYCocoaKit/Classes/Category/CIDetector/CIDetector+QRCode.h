//
//  CIDetector+QRCode.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/10.
//

#import <CoreImage/CoreImage.h>
#import "PublicMacroFile.h"

@interface CIDetector (QRCode)

/**
 识别图片中的二维码，相机拍照获取的二维码不能非常准备的识别到

 @param image 图片
 @return 识别结果
 */
+ (NSString *)detectorQRCodeImage:(UIImage *)image NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 根据给定的字符串生成”高容错“率的二维码图片

 @param qrString 给定的字符串
 @param size 二维码图片的size
 @return 二维码图片
 */
+ (UIImage *)filterHighQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 根据给定的字符串生成“中容错”率的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @return 二维码图片
 */
+ (UIImage *)filterMiddleQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 根据给定的字符串生成“低容错”率的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @return 二维码图片
 */
+ (UIImage *)filterLowQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 根据给定的字符串生成”高容错“率的中间带logo的二维码图片

 @param qrString 给定的字符串
 @param size 二维码图片的size
 @param logo logo图片的名称
 @param logoSize logo图片的size
 @return 中间带logo的”高容错“率二维码图片
 */
+ (UIImage *)filterHighLogoQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size logo:(NSString *)logo logoSize:(CGFloat)logoSize NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 根据给定的字符串生成”中容错“率的中间带logo的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @param logo logo图片的名称
 @param logoSize logo图片的size
 @return 中间带logo的”中容错“率二维码图片
 */
+ (UIImage *)filterMiddleLogoQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size logo:(NSString *)logo logoSize:(CGFloat)logoSize NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 根据给定的字符串生成”低容错“率的中间带logo的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @param logo logo图片的名称
 @param logoSize logo图片的size
 @return 中间带logo的”低容错“率二维码图片
 */
+ (UIImage *)filterLowLogoQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size logo:(NSString *)logo logoSize:(CGFloat)logoSize NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
