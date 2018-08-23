//
//  NSDecimalNumber+Computer.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/8/23.
//

#import "NSDecimalNumber+Computer.h"

@implementation NSDecimalNumber (Computer)

#pragma mark - NSDecimalNumber Computer

+ (NSDictionary<NSDecimalNumber *, NSDecimalNumber *> *)hsy_decimalNumber:(NSDictionary<NSString *, NSString *> *)addingDictionary
{
    NSDecimalNumber *keyDecimal = [[NSDecimalNumber alloc] initWithString:addingDictionary.allKeys.firstObject];
    NSDecimalNumber *valueDecimal = [[NSDecimalNumber alloc] initWithString:addingDictionary.allValues.firstObject];
    return @{keyDecimal : valueDecimal};
}

#pragma mark - 加法

+ (NSDecimalNumber *)addingDecimalNumber:(NSDictionary<NSString *, NSString *> *)addingDictionary
{
    return [NSDecimalNumber addingDecimalNumber:addingDictionary decimalNumberHandler:nil];
}

+ (NSDecimalNumber *)addingDecimalNumber:(NSDictionary<NSString *, NSString *> *)addingDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler
{
    NSDictionary *dictionaryDecimal = [NSDecimalNumber hsy_decimalNumber:addingDictionary];
    NSDecimalNumber *addingDecimal = nil;
    if (handler) {
        addingDecimal = [dictionaryDecimal.allKeys.firstObject decimalNumberByAdding:dictionaryDecimal.allValues.firstObject withBehavior:handler];
    } else {
        addingDecimal = [dictionaryDecimal.allKeys.firstObject decimalNumberByAdding:dictionaryDecimal.allValues.firstObject ];
    }
    return addingDecimal;
}

#pragma mark - 减法

+ (NSDecimalNumber *)subtractingDecimalNumber:(NSDictionary<NSString *, NSString *> *)subtractingDictionary
{
    return [NSDecimalNumber subtractingDecimalNumber:subtractingDictionary decimalNumberHandler:nil];
}

+ (NSDecimalNumber *)subtractingDecimalNumber:(NSDictionary<NSString *, NSString *> *)subtractingDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler
{
    NSDictionary *dictionaryDecimal = [NSDecimalNumber hsy_decimalNumber:subtractingDictionary];
    NSDecimalNumber *dividingDecimal = nil;
    if (handler) {
        dividingDecimal = [dictionaryDecimal.allKeys.firstObject decimalNumberBySubtracting:dictionaryDecimal.allValues.firstObject withBehavior:handler];
    } else {
        dividingDecimal = [dictionaryDecimal.allKeys.firstObject decimalNumberBySubtracting:dictionaryDecimal.allValues.firstObject];
    }
    return dividingDecimal;
}

#pragma mark - 乘法

+ (NSDecimalNumber *)multiplyingDecimalNumber:(NSDictionary<NSString *, NSString *> *)multiplyingDictionary
{
    return [NSDecimalNumber multiplyingDecimalNumber:multiplyingDictionary decimalNumberHandler:nil];
}

+ (NSDecimalNumber *)multiplyingDecimalNumber:(NSDictionary<NSString *, NSString *> *)multiplyingDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler
{
    NSDictionary *dictionaryDecimal = [NSDecimalNumber hsy_decimalNumber:multiplyingDictionary];
    NSDecimalNumber *multiplyingDecimal = nil;
    if (handler) {
        multiplyingDecimal = [dictionaryDecimal.allKeys.firstObject decimalNumberByMultiplyingBy:dictionaryDecimal.allValues.firstObject withBehavior:handler];
    } else {
        multiplyingDecimal = [dictionaryDecimal.allKeys.firstObject decimalNumberByMultiplyingBy:dictionaryDecimal.allValues.firstObject];
    }
    return multiplyingDecimal;
}

#pragma mark - 除法

+ (NSDecimalNumber *)dividingDecimalNumber:(NSDictionary<NSString *, NSString *> *)dividingDictionary
{
    return [NSDecimalNumber dividingDecimalNumber:dividingDictionary decimalNumberHandler:nil];
}

+ (NSDecimalNumber *)dividingDecimalNumber:(NSDictionary<NSString *, NSString *> *)dividingDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler
{
    NSDictionary *dictionaryDecimal = [NSDecimalNumber hsy_decimalNumber:dividingDictionary];
    NSDecimalNumber *dividingDecimal = nil;
    if (handler) {
        dividingDecimal = [dictionaryDecimal.allKeys.firstObject decimalNumberByDividingBy:dictionaryDecimal.allValues.firstObject withBehavior:handler];
    } else {
        dividingDecimal = [dictionaryDecimal.allKeys.firstObject decimalNumberByDividingBy:dictionaryDecimal.allValues.firstObject];
    }
    return dividingDecimal;
}

#pragma mark - 次方

+ (NSDecimalNumber *)powerDecimalNumber:(NSDictionary<NSString *, NSString*> *)powerDictionary
{
    return [NSDecimalNumber powerDecimalNumber:powerDictionary decimalNumberHandler:nil];
}

+ (NSDecimalNumber *)powerDecimalNumber:(NSDictionary<NSString *, NSString *> *)powerDictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler
{
    NSDecimalNumber *keyDecimal = [[NSDecimalNumber alloc] initWithString:powerDictionary.allKeys.firstObject];
    NSDecimalNumber *powerDecimal = nil;
    if (handler) {
        powerDecimal = [keyDecimal decimalNumberByRaisingToPower:[powerDictionary.allValues.firstObject integerValue] withBehavior:handler];
    } else {
        powerDecimal = [keyDecimal decimalNumberByRaisingToPower:[powerDictionary.allValues.firstObject integerValue]];
    }
    return powerDecimal;
}

#pragma mark - 10位低的乘方

+ (NSDecimalNumber *)powerOf10DecimalNumber:(NSDictionary<NSString *, NSString *> *)powerOf10Dictionary
{
    return [NSDecimalNumber powerOf10DecimalNumber:powerOf10Dictionary decimalNumberHandler:nil];
}

+ (NSDecimalNumber *)powerOf10DecimalNumber:(NSDictionary<NSString *, NSString *> *)powerOf10Dictionary decimalNumberHandler:(NSDecimalNumberHandler *)handler
{
    NSDecimalNumber *keyDecimal = [[NSDecimalNumber alloc] initWithString:powerOf10Dictionary.allKeys.firstObject];
    NSDecimalNumber *powerOf10Decimal = nil;
    if (handler) {
        powerOf10Decimal = [keyDecimal decimalNumberByMultiplyingByPowerOf10:[powerOf10Dictionary.allValues.firstObject integerValue] withBehavior:handler];
    } else {
        powerOf10Decimal = [keyDecimal decimalNumberByMultiplyingByPowerOf10:[powerOf10Dictionary.allValues.firstObject integerValue]];
    }
    return powerOf10Decimal;
}

#pragma mark - NSDecimalNumberHandler

+ (NSDecimalNumberHandler *)defaultDecimalNumberHandler:(kHSYCocoaKitDecimalNumberHandlerRoundingMode)mode scale:(short)scale
{
    //raiseOnExactness:精度处理，YES表示错误时引发异常，NO表示忽略
    //raiseOnOverflow:溢出错误处理，YES表示出现错误时引发异常，NO表示忽略
    //raiseOnUnderflow:下溢出错误处理，YES表示出现错误时引发异常，NO表示忽略
    //raiseOnDivideByZero:除以0的错误处理，YES表示出现错误时引发异常，NO表示忽略
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:[NSDecimalNumber decimalNumberHandlerRoundingMode:mode] scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    return handler;
}

+ (NSRoundingMode)decimalNumberHandlerRoundingMode:(kHSYCocoaKitDecimalNumberHandlerRoundingMode)mode
{
    NSDictionary *modes = @{@(kHSYCocoaKitDecimalNumberHandlerRoundingModePlain) : @(NSRoundPlain), @(kHSYCocoaKitDecimalNumberHandlerRoundingModeDown) : @(NSRoundDown), @(kHSYCocoaKitDecimalNumberHandlerRoundingModeUp) : @(NSRoundUp), @(kHSYCocoaKitDecimalNumberHandlerRoundingModeBankers) : @(NSRoundBankers), };
    return ((NSRoundingMode)[modes[@(mode)] integerValue]);
}

@end
