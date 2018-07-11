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

@end
