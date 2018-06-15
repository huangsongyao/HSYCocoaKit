//
//  NSString+Regular.h
//  Pods
//
//  Created by huangsongyao on 2018/5/7.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

/**
 正则过滤字符串必须为纯数字

 @return YES表示字符串为纯数字
 */
- (BOOL)isPureNumber;

/**
 正则过滤字符串必须为纯数字，限制该字符串的纯数字的取值范围为：[prefix, suffix] 闭区间

 @param prefix 最小取值
 @param suffix 最大取值
 @return 是否满足区间取值结果
 */
- (BOOL)isPureNumberFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix;

/**
 正则过滤字符串是否为邮箱

 @return YES表示邮箱格式，NO表示否
 */
- (BOOL)isEmailAddress;

@end
