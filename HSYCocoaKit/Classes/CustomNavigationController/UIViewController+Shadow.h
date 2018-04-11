//
//  UIViewController+Shadow.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (Shadow)

/**
 设置layer层的阴影效果
 
 @param ref     阴影颜色
 @param opacity 透明度
 @param radius  圆角
 */
- (void)hsy_setShadowForColorRef:(CGColorRef)ref shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius;

@end
