//
//  CIDetector+QRCode.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/10.
//

#import <CoreImage/CoreImage.h>

@interface CIDetector (QRCode)

/**
 识别图片中的二维码

 @param image 图片
 @return 识别结果
 */
+ (NSString *)detectorQRCodeImage:(UIImage *)image;

@end
