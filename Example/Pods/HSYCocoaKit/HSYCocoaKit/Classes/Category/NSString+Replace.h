//
//  NSString+Replace.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Replace)

/**
 获取字符串中所有特殊占位符的位置

 @param symbol 占位符
 @return 占位符的位置的集合
 */
- (NSMutableArray <NSValue *>*)allSymbolLocations:(NSString *)symbol;

/**
 过滤字符串中的unicode表情

 @return 过滤后的字符串
 */
- (NSString *)stringByReplaceSomeCrashedUnicode;

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

@end
