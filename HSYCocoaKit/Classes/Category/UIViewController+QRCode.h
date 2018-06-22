//
//  UIViewController+QRCode.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/22.
//

#import <UIKit/UIKit.h>

@interface UIViewController (QRCode)

/**
 通过有效区域的扫描框的CGRect换算为相机的有效识别区域

 @param boxCGRect 扫描框的CGRect
 @return 相机的有效识别区域
 */
- (CGRect)qrCodeScaningZone:(CGRect)boxCGRect;

/**
 扫描动画

 @param toValue 终止值
 @param layer 所添加到的渲染层
 @param key 动画的key值
 */
- (void)qrCodeScaningAnimation:(CGFloat)toValue
                       onLayer:(CALayer *)layer
                        forKey:(NSString *)key;

@end
