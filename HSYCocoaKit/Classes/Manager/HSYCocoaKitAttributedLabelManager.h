//
//  HSYCocoaKitAttributedLabelManager.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/8/7.
//

#import <Foundation/Foundation.h>
#import "TYAttributedLabel.h"

@interface TYAttributedLabel (Reset)

/**
 更新TYAttributedLabel混排的内容，只支持单一特殊占位符

 @param newAttributed NSString的text或者NSAttributedString的attributedText
 @param symbolParamter 格式为：@{@"特殊占位符" : @[UIView1, UIView2, ...], }
 */
- (void)reloadAttributed:(id)newAttributed locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter;

/**
 更新TYAttributedLabel混排的内容，支持多种类的特殊占位符

 @param newAttributed NSString的text或者NSAttributedString的attributedText
 @param symbolParamters 格式为：@[@{@"特殊占位符1" : UIView1}, @{@"特殊占位符2" : UIView2}, ...]
 */
- (void)reloadAttributed:(id)newAttributed locationSymbolParamters:(NSArray<NSDictionary<NSString *, UIView *> *> *)symbolParamters;

@end

@interface HSYCocoaKitAttributedLabelManager : NSObject

/**
 返回一个混排的文本视图

 @param textContainerParamter TYTextContainer的kvc模式，key为TYTextContainer的属性名称
 @param symbolParamter 特殊占位符和要被替换成的视图，格式为：@{@"特殊占位符" : @[UIView1, UIView2, ...], }
 @param width TYAttributedLabel的最大宽度，当动态计算的width_x小于给定的这个width，则使用width_x作为宽度
 @return TYAttributedLabel
 */
+ (TYAttributedLabel *)hsy_baseAttributedLabel:(NSDictionary *)textContainerParamter locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter displayWidth:(CGFloat)width;

/**
 返回一个文本编辑器，用于混排，且只有一种格式的特殊占位符

 @param textContainerParamter TYTextContainer的kvc格式，key为TYTextContainer的属性名称
 @param symbolParamter 特殊占位符和要被替换成的视图，格式为：@{@"特殊占位符" : @[UIView1, UIView2, ...], }
 @param width TYAttributedLabel的最大宽度，当动态计算的width_x小于给定的这个width，则使用width_x作为宽度
 @return TYTextContainer
 */
+ (TYTextContainer *)hsy_baseTextContainer:(NSDictionary *)textContainerParamter locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter displayWidth:(CGFloat)width;

/**
 返回一个文本编辑器，用于混排，允许多种特殊占位符

 @param textContainerParamter TYTextContainer的kvc格式，key为TYTextContainer的属性名称
 @param symbolParamters 特殊占位符和要被替换成的视图的集合，格式为：@[@{@"特殊占位符1" : UIView1}, @{@"特殊占位符2" : UIView2}, ...]
 @param width TYAttributedLabel的最大宽度，当动态计算的width_x小于给定的这个width，则使用width_x作为宽度
 @return TYTextContainer
 */
+ (TYTextContainer *)hsy_baseTextContainer:(NSDictionary *)textContainerParamter locationSymbolParamters:(NSArray<NSDictionary<NSString *, UIView *> *> *)symbolParamters displayWidth:(CGFloat)width;
@end
