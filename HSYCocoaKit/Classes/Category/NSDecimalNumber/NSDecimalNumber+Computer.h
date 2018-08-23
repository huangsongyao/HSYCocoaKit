//
//  NSDecimalNumber+Computer.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/8/23.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitDecimalNumberHandlerRoundingMode) {
    
    kHSYCocoaKitDecimalNumberHandlerRoundingModePlain           = 6373,     //四舍五入
    kHSYCocoaKitDecimalNumberHandlerRoundingModeDown,                       //只舍不入
    kHSYCocoaKitDecimalNumberHandlerRoundingModeUp,                         //只入不舍
    kHSYCocoaKitDecimalNumberHandlerRoundingModeBankers,                    //四舍五入，并且当最后一位为5时，舍入为偶数，如：1.25返回1.2，1.15返回1.2
};

@interface NSDecimalNumber (Computer)

/**
 精度加法运算，默认不使用精度计算处理方法

 @param addingDictionary 加法运算内容，格式为：@{@"加法内容A" : @"加法内容B"}，结果为A+B
 @return A+B
 */
+ (NSDecimalNumber *)addingDecimalNumber:(NSDictionary<NSString *, NSString *> *)addingDictionary;

/**
 精度加法运算

 @param addingDictionary 加法运算内容，格式为：@{@"加法内容A" : @"加法内容B"}，结果为“A+B”
 @param handler 精度计算处理方法
 @return A+B
 */
+ (NSDecimalNumber *)addingDecimalNumber:(NSDictionary<NSString *, NSString *> *)addingDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler;

/**
 精度减法运算，默认不使用精度计算处理方法

 @param subtractingDictionary 减法运算内容，格式为：@{@"加法内容A" : @"加法内容B"}，结果为“A-B”
 @return A-B
 */
+ (NSDecimalNumber *)subtractingDecimalNumber:(NSDictionary<NSString *, NSString *> *)subtractingDictionary;

/**
 精度减法运算

 @param subtractingDictionary 减法运算内容，格式为：@{@"减法内容A" : @"减法内容B"}，结果为“A-B”
 @param handler 精度计算处理方法
 @return A-B
 */
+ (NSDecimalNumber *)subtractingDecimalNumber:(NSDictionary<NSString *, NSString *> *)subtractingDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler;

/**
 精度乘法运算，默认不使用精度计算处理方法

 @param multiplyingDictionary 乘法运算内容，格式为：@{@"乘法内容A" : @"乘法内容B"}，结果为“A*B”
 @return A*B
 */
+ (NSDecimalNumber *)multiplyingDecimalNumber:(NSDictionary<NSString *, NSString *> *)multiplyingDictionary;

/**
 精度乘法运算

 @param multiplyingDictionary 乘法运算内容，格式为：@{@"乘法内容A" : @"乘法内容B"}，结果为“A*B”
 @param handler 精度计算处理方法
 @return A*B
 */
+ (NSDecimalNumber *)multiplyingDecimalNumber:(NSDictionary<NSString *, NSString *> *)multiplyingDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler;

/**
 精度除法运算，默认不使用精度计算处理方法

 @param dividingDiction 除法运算内容，格式为：@{@"除法内容A" : @"除法内容B"}，结果为“A/B”
 @return A/B
 */
+ (NSDecimalNumber *)dividingDecimalNumber:(NSDictionary<NSString *, NSString *> *)dividingDiction;

/**
 精度除法运算

 @param dividingDiction 除法运算内容，格式为：@{@"除法内容A" : @"除法内容B"}，结果为“A/B”
 @param handler 精度计算处理方法
 @return A/B
 */
+ (NSDecimalNumber *)dividingDecimalNumber:(NSDictionary<NSString *, NSString *> *)dividingDiction decimalNumberHandler:(NSDecimalNumberHandler *)handler;

/**
 精度次方运算，默认不使用精度计算处理方法

 @param powerDictionary 次方运算内容，格式为：@{@"次方的底数A" : @"次方的指数B"}，结果为“A^B”，例如@{@"2" : @"3"} => 2^3[2的3次方]=9
 @return “A^B”，例如@{@"2" : @"3"} => 2^3[2的3次方]=9
 */
+ (NSDecimalNumber *)powerDecimalNumber:(NSDictionary<NSString *, NSString*> *)powerDictionary;

/**
 精度次方运算

 @param powerDictionary 次方运算内容，格式为：@{@"次方的底数A" : @"次方的指数B"}，结果为“A^B”，例如@{@"2" : @"3"} => 2^3[2的3次方]=8
 @param handler 精度计算处理方法
 @return “A^B”，例如@{@"2" : @"3"} => 2^3[2的3次方]=8
 */
+ (NSDecimalNumber *)powerDecimalNumber:(NSDictionary<NSString *, NSString *> *)powerDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler;

/**
 精度以10为底的乘方运算

 @param powerOf10Dictionary 以10为底的乘方运算内容，格式为：@{@"以10为底的乘方A" : @"以10为底的乘方的指数B"}，结果为“A*10^B”，例如@{@"2" : @"3"} => 2*10^3[2乘以10的3次方]=2000
 @return “A*10^B”，例如@{@"2" : @"3"} => 2*10^3[2乘以10的3次方]=2000
 */
+ (NSDecimalNumber *)powerOf10DecimalNumber:(NSDictionary<NSString *, NSString *> *)powerOf10Dictionary;

/**
 精度以10为底的乘方运算，默认不使用精度计算处理方法

 @param powerOf10Dictionary 以10为底的乘方运算内容，格式为：@{@"以10为底的乘方A" : @"以10为底的乘方的指数B"}，结果为“A*10^B”，例如@{@"2" : @"3"} => 2*10^3[2乘以10的3次方]=2000
 @param handler 精度计算处理方法
 @return “A*10^B”，例如@{@"2" : @"3"} => 2*10^3[2乘以10的3次方]=2000
 */
+ (NSDecimalNumber *)powerOf10DecimalNumber:(NSDictionary<NSString *, NSString *> *)powerOf10Dictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler;

/**
 创建一个精度计算处理办法，默认内部的：精度错误处理、溢出错误处理、下溢出错误处理以及除以0错误处理均忽略

 @param mode kHSYCocoaKitDecimalNumberHandlerRoundingMode枚举，表示处理的四舍五入方法
 @param scale 小数点后的舍入的位数
 @return NSDecimalNumberHandler
 */
+ (NSDecimalNumberHandler *)defaultDecimalNumberHandler:(kHSYCocoaKitDecimalNumberHandlerRoundingMode)mode scale:(short)scale;

@end
