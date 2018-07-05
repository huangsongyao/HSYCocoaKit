//
//  NSString+Regular.h
//  Pods
//
//  Created by huangsongyao on 2018/5/7.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitRegularResult) {
    
    kHSYCocoaKitRegularResultConform            = 256,      //符合正则表达式的过滤
    kHSYCocoaKitRegularResultUnconform,                     //不符合正则表达式的过滤
    kHSYCocoaKitRegularResultLengthIsZero,                  //长度为零
    
};

@interface NSString (Regular)

#pragma mark - Number

/**
 正则过滤字符串必须为纯数字

 @return YES表示字符串为纯数字
 */
- (BOOL)isPureNumber;

/**
 正则过滤字符串必须为纯数字，返回kHSYCocoaKitRegularResult结果

 @return YES表示字符串为纯数字，kHSYCocoaKitRegularResult类型
 */
- (kHSYCocoaKitRegularResult)hsy_isPureNumber;

/**
 正则过滤字符串必须为纯数字，限制该字符串的纯数字的取值范围为：[prefix, suffix] 闭区间

 @param prefix 最小取值
 @param suffix 最大取值
 @return 是否满足区间取值结果
 */
- (BOOL)isPureNumberFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix;

/**
 正则过滤字符串必须为纯数字，限制该字符串的纯数字的取值范围为：[prefix, suffix] 闭区间，返回kHSYCocoaKitRegularResult结果

 @param prefix 最小取值
 @param suffix 最大取值
 @return 是否满足区间取值结果，kHSYCocoaKitRegularResult类型
 */
- (kHSYCocoaKitRegularResult)hsy_isPureNumberFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix;

#pragma mark - Email

/**
 正则过滤字符串是否为邮箱

 @return YES表示邮箱格式，NO表示否
 */
- (BOOL)isEmailAddress;

/**
 正则过滤字符串是否为邮箱，返回kHSYCocoaKitRegularResult类型
 
 @return YES表示邮箱格式，NO表示否，kHSYCocoaKitRegularResult类型
 */
- (kHSYCocoaKitRegularResult)hsy_isEmailAddress;

#pragma mark - Password

/**
 正则过滤字符串是否为通用密码【字母+数字+常用字符】，限制6-16位长度

 @return YES or NO
 */
- (BOOL)isPassword;

/**
 正则过滤字符串是否为通用密码【字母+数字+常用字符】，限制6-16位长度，返回kHSYCocoaKitRegularResult类型
 
 @return YES or NO，kHSYCocoaKitRegularResult类型
 */
- (kHSYCocoaKitRegularResult)hsy_isPassword;

/**
 正则过滤字符串是否为通用密码【字母+数字+常用字符】，限制prefix-suffix为长度

 @param prefix 最小长度
 @param suffix 最大长度
 @return YES or NO
 */
- (BOOL)isPasswordFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix;

/**
 正则过滤字符串是否为通用密码【字母+数字+常用字符】，限制prefix-suffix为长度，返回kHSYCocoaKitRegularResult类型
 
 @param prefix 最小长度
 @param suffix 最大长度
 @return YES or NO，kHSYCocoaKitRegularResult类型
 */
- (kHSYCocoaKitRegularResult)hsy_isPasswordFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix;

@end
