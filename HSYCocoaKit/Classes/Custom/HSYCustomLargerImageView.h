//
//  HSYCustomLargerImageView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import <UIKit/UIKit.h>

@interface HSYCustomLargerImageView : UIView

/**
 初始化，默认的style为UIBlurEffectStyleLight

 @param selectedParamter 所选中图片的信息，格式为：@{@(视图的坐标系映射到window层后的CGRect) : @"选中的图片"}
 @param paramter 图片组的内容，格式为：@{@(所选中的图片所在的图片组的位置) : @[图片组的成员，UIImage或者NSString]}
 @return self
 */
- (instancetype)initWithDefaultSelectedImageParamter:(NSDictionary<NSValue *, UIImage *> *)selectedParamter
                                      imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter;

/**
 初始化

 @param style UIBlurEffectStyle枚举
 @param selectedParamter 所选中图片的信息，格式为：@{@(视图的坐标系映射到window层后的CGRect) : @"选中的图片"}
 @param paramter 图片组的内容，格式为：@{@(所选中的图片所在的图片组的位置) : @[图片组的成员，UIImage或者NSString]}
 @return self
 */
- (instancetype)initWithStyle:(UIBlurEffectStyle)style
        selectedImageParamter:(NSDictionary<NSValue *, UIImage *> *)selectedParamter  
               imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter;

/**
 将视图view从该视图的父视图的坐标系映射到UIWindow层的坐标系

 @param view 视图a
 @param superView 视图a的父视图
 @return 映射到UIWindow上的坐标系
 */
+ (NSValue *)valueForSelectedImage:(UIView *)view superView:(UIView *)superView;

@end

@interface HSYCustomLargerImageView (HSYCocoaKit)

+ (HSYCustomLargerImageView *)showLargerImageViewSelectedImageParamter:(NSDictionary<NSValue *, UIImage *> *)selectedParamter imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter;

@end
