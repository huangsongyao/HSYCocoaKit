//
//  HSYCocoaKitCoreGraphicsManager.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/7.
//

#import <Foundation/Foundation.h>

@interface HSYCocoaKitCoreGraphicsManager : NSObject

/**
 CoreGraphicsFramework关于CGContextRef的圆形/椭圆形绘制，默认无描边
 
 @param fillColor 圆形/椭圆形的填充色
 @param rect 圆形/椭圆形的frame
 */
+ (void)hsy_contextRefGraphicsCircular:(UIColor *)fillColor circularCGRect:(CGRect)rect;

@end
