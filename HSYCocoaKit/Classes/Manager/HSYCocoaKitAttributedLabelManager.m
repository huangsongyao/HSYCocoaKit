//
//  HSYCocoaKitAttributedLabelManager.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/8/7.
//

#import "HSYCocoaKitAttributedLabelManager.h"
#import "NSString+Replace.h"
#import "UIView+Frame.h"
#import "PublicMacroFile.h"
#import "NSObject+Runtime.h"

//********************************************************************************************************

@implementation TYAttributedLabel (Reset)

- (NSMutableDictionary *)reloadAttributed:(id)newAttributed
{
    NSMutableDictionary *textContainerParamter = self.textContainer.toRuntimeMutableDictionary;
    [textContainerParamter removeObjectsForKeys:@[@"text", @"attributedText", ]];
    if ([newAttributed isKindOfClass:[NSAttributedString class]]) {
        textContainerParamter[@"attributedText"] = newAttributed;
    } else {
        textContainerParamter[@"text"] = newAttributed;
    }
    return textContainerParamter;
}

- (void)reloadNewTextContainer:(TYTextContainer *)textContainer
{
    if (textContainer) {
        self.textContainer = textContainer;
        self.height = [self getSizeWithWidth:self.width].height;
    }
}

- (void)reloadAttributed:(id)newAttributed locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter
{
    NSMutableDictionary *textContainerParamter = [self reloadAttributed:newAttributed];
    TYTextContainer *newTextContainer = [HSYCocoaKitAttributedLabelManager hsy_baseTextContainer:textContainerParamter locationSymbolParamter:symbolParamter displayWidth:self.textContainer.textWidth];
    
    [self reloadNewTextContainer:newTextContainer];
}

- (void)reloadAttributed:(id)newAttributed locationSymbolParamters:(NSArray<NSDictionary<NSString *, UIView *> *> *)symbolParamters
{
    NSMutableDictionary *textContainerParamter = [self reloadAttributed:newAttributed];
    TYTextContainer *newTextContainer = [HSYCocoaKitAttributedLabelManager hsy_baseTextContainer:textContainerParamter locationSymbolParamters:symbolParamters displayWidth:self.textContainer.textWidth];
    
    [self reloadNewTextContainer:newTextContainer];
}

@end

//********************************************************************************************************

@interface TYTextContainer (Reset)

/**
 将特殊字符串动态替换为指定的UIView，实现文字+UIView的动态混排，只支持单一特殊占位符
 
 @param symbolParamter 格式：@{@"特殊占位符" : @[UIView_1, UIView_2, UIView_3, ]}
 */
- (void)resetSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter;

/**
 将特殊字符串动态替换为指定的UIView，实现文字+UIView的动态混排，支持多种特殊占位符

 @param symbolParamters 格式：@[@{@"特殊占位符_1" : UIView_1}, @{@"特殊占位符_2" : UIView_2}, @{@"特殊占位符_3" : UIView_3},...]
 */
- (void)resetSymbolParamters:(NSArray<NSDictionary<NSString *, UIView *> *> *)symbolParamters;

@end

@implementation TYTextContainer (Reset)

- (void)resetSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter
{
    //遍历并获取字符串中所有用于占位的特殊符号，并将其替换为对应的view，用于只存在一种类型的占位符
    NSString *symbol = symbolParamter.allKeys.firstObject;
    NSArray<NSValue *> *locations = [self.text allSymbolLocations:symbol];
    if (locations.count > 0) {
        NSArray<UIView *> *views = symbolParamter.allValues.firstObject;
        for (NSValue *value in locations) {
            [self addView:views[[locations indexOfObject:value]] range:value.rangeValue];
        }
    }
}

- (void)resetSymbolParamters:(NSArray<NSDictionary<NSString *, UIView *> *> *)symbolParamters
{
    //遍历并获取字符串中所有用于占位的特殊符号，并将其替换为对应的view，用于混排存在多种特殊占位符
    for (NSDictionary<NSString *, UIView *> *dic in symbolParamters) {
        NSString *symbol = dic.allKeys.firstObject;
        UIView *view = dic.allValues.firstObject;
        NSArray<NSValue *> *locations = [self.text allSymbolLocations:symbol];
        if (locations.count > 0) {
            NSValue *value = locations.firstObject;
            [self addView:view range:value.rangeValue];
        }
    }
}

@end

//********************************************************************************************************

@implementation HSYCocoaKitAttributedLabelManager

+ (TYAttributedLabel *)hsy_baseAttributedLabel:(NSDictionary *)textContainerParamter locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter displayWidth:(CGFloat)width
{
    //文本生成器
    TYTextContainer *textContainer = [self.class hsy_baseTextContainer:textContainerParamter locationSymbolParamter:symbolParamter displayWidth:width];
    
    //通过TYTextContainer的方法动态将真正的height计算出来，并更新高度
    TYAttributedLabel *attributedLabel = [[TYAttributedLabel alloc] init];
    attributedLabel.textContainer = textContainer;
    CGSize size = [attributedLabel getSizeWithWidth:width];
    attributedLabel.size = size;
    
    return attributedLabel;
}

+ (TYTextContainer *)hsy_baseTextContainer:(NSDictionary *)textContainerParamter locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter displayWidth:(CGFloat)width
{
    TYTextContainer *textContainer = [self.class hsy_baseTextContainer:textContainerParamter displayWidth:width];
    //遍历并获取字符串中所有用于占位的特殊符号，并将其替换为对应的view
    [textContainer resetSymbolParamter:symbolParamter];
    return textContainer;
}

+ (TYTextContainer *)hsy_baseTextContainer:(NSDictionary *)textContainerParamter locationSymbolParamters:(NSArray<NSDictionary<NSString *, UIView *> *> *)symbolParamters displayWidth:(CGFloat)width
{
    TYTextContainer *textContainer = [self.class hsy_baseTextContainer:textContainerParamter displayWidth:width];
    //遍历并获取字符串中所有用于占位的特殊符号，并将其替换为对应的view
    [textContainer resetSymbolParamters:symbolParamters];
    return textContainer;
}

+ (TYTextContainer *)hsy_baseTextContainer:(NSDictionary *)textContainerParamter displayWidth:(CGFloat)width
{
    //利用kvc动态setValue
    TYTextContainer *textContainer = [[TYTextContainer alloc] createTextContainerWithTextWidth:width];
    for (NSString *key in textContainerParamter.allKeys) {
        id value = textContainerParamter[key];
        [textContainer setValue:value forKey:key];
    }
    return textContainer;
}

@end
