//
//  UIImageView+Scale.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Scale)

/**
 根据图片原始size对图片进行放缩，放缩方式为:通过比较原始图片的size决定放缩依据为设备的高度或者宽度

 @return 放缩后的图片size
 */
- (CGSize)scaleCGSize;

/**
 根据图片原始size对图片进行放缩，放缩方式为“- scaleCGSize”方法，并同时对图片在window层为背景的居中处理
 */
- (void)scaleCentryCGRect;

@end
