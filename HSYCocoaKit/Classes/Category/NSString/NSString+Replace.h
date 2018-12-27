//
//  NSString+Replace.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Replace)

/**
 获取字符串中所有特殊占位符的位置

 @param symbol 占位符
 @return 占位符的位置的集合
 */
- (NSMutableArray<NSValue *> *)allSymbolLocations:(NSString *)symbol;

/**
 过滤字符串中的unicode表情

 @return 过滤后的字符串
 */
- (NSString *)stringByReplaceSomeCrashedUnicode;

/**
 去除字符串首尾的空格

 @return 过滤后的字符串
 */
- (NSString *)stringByTrimmingCharacters;

/**
 过滤字符串中的空格符

 @return 无空格符的字符串
 */
- (NSString *)stringByReplacingOccurrences;

/**
 过滤字符串中的特殊字符

 @param symbol 要过滤的特殊字符
 @return 无特殊字符的字符串
 */
- (NSString *)stringByReplacingOccurrencesOfSymbol:(NSString *)symbol;

/**
 过滤字符串中的symbol占位符，并且替换成content

 @param symbol 要过滤的占位符
 @param content 替换占位符的内容
 @return 替换后的字符串
 */
- (NSString *)stringByReplacingOccurrencesOfSymbol:(NSString *)symbol fillContent:(NSString *)content;

/**
 将小数点后保留的位数转为精度位数的单位，例如：decimal = 5，则结果为：0.00001

 @param decimal 小数点后保留的位数
 @return 例如：decimal = 5，则结果为：0.00001
 */
+ (NSString *)unitFromDecimal:(NSInteger)decimal;

/**
 通过index的位置，逐一截取，例如对字符串@"123456789"执行逐一截取，index为2，则返回@[@"12", @"34", @"56", @"78", @"9"]

 @param index 逐一截取的位置
 @return 逐一截取的集合
 */
- (NSArray<NSString *> *)hsy_replaceSections:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
