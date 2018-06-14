//
//  HSYCustomLargerImageView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import "HSYCustomGestureView.h"

@interface HSYCustomLargerImageView : HSYCustomGestureView

/**
 初始化，默认的style为UIBlurEffectStyleLight

 @param selectedImage 所选中图片
 @param paramter 图片组的内容，格式为：@{@(所选中的图片所在的图片组的位置) : @[图片组的成员，UIImage或者NSString]}
 @param imageCGRects 图片组的原始rect集合，格式为：@[@NSValue-CGRect, ...]
 @param superView 图片组所在的父视图
 @return self
 */
- (instancetype)initWithDefaultSelectedImage:(UIImage *)selectedImage
                              imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
                                imageCGRects:(NSArray<NSValue *> *)imageCGRects
                            callMapSuperView:(UIView *)superView;

/**
 初始化

 @param style UIBlurEffectStyle枚举
 @param selectedImage 所选中图片
 @param paramter 图片组的内容，格式为：@{@(所选中的图片所在的图片组的位置) : @[图片组的成员，UIImage或者NSString]}
 @param imageCGRects 图片组的原始rect集合，格式为：@[@NSValue-CGRect, ...]
 @param superView 图片组所在的父视图
 @return self
 */
- (instancetype)initWithStyle:(UIBlurEffectStyle)style
                selectedImage:(UIImage *)selectedImage
               imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
                 imageCGRects:(NSArray<NSValue *> *)imageCGRects
             callMapSuperView:(UIView *)superView;

@end

@interface HSYCustomLargerImageView (HSYCocoaKit)

/**
 默认初始化

 @param selectedImage 所选中图片
 @param paramter 图片组的内容，格式为：@{@(所选中的图片所在的图片组的位置) : @[图片组的成员，UIImage或者NSString]}
 @param imageCGRects 图片组的原始rect集合，格式为：@[@NSValue-CGRect, ...]
 @param superView 图片组所在的父视图
 @return HSYCustomLargerImageView
 */
+ (HSYCustomLargerImageView *)showLargerImageViewSelectedImage:(UIImage *)selectedImage
                                                imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
                                                  imageCGRects:(NSArray<NSValue *> *)imageCGRects
                                              callMapSuperView:(UIView *)superView;

@end
