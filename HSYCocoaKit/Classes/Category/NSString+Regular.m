//
//  NSString+Regular.m
//  Pods
//
//  Created by huangsongyao on 2018/5/7.
//
//

#import "NSString+Regular.h"

@implementation NSString (Regular)

- (BOOL)isValidateByRegex:(NSString *)regex
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:self];
}

#pragma mark - Number For Regex

- (kHSYCocoaKitRegularResult)hsy_isPureNumber
{
    if (self.length == 0) {
        return kHSYCocoaKitRegularResultLengthIsZero;
    }
    kHSYCocoaKitRegularResult res = kHSYCocoaKitRegularResultConform;
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSInteger i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:characterSet];
        if (range.length == 0) {
            res = kHSYCocoaKitRegularResultUnconform;
            break;
        }
        i ++;
    }
    return res;
}

- (BOOL)isPureNumber
{
    kHSYCocoaKitRegularResult result = self.hsy_isPureNumber;
    if (result == kHSYCocoaKitRegularResultConform) {
        return YES;
    }
    return NO;
}

- (kHSYCocoaKitRegularResult)hsy_isPureNumberFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix
{
    kHSYCocoaKitRegularResult result = self.hsy_isPureNumber;
    if (result == kHSYCocoaKitRegularResultLengthIsZero) {
        return result;
    }
    result = ((self.integerValue >= prefix.integerValue && self.integerValue <= suffix.integerValue) ? kHSYCocoaKitRegularResultConform : kHSYCocoaKitRegularResultUnconform);
    return result;
}

- (BOOL)isPureNumberFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix
{
    kHSYCocoaKitRegularResult result = [self hsy_isPureNumberFromPrefix:prefix suffixNumber:suffix];
    if (result == kHSYCocoaKitRegularResultConform) {
        return YES;
    }
    return NO;
}

#pragma mark - Email For Regex

- (kHSYCocoaKitRegularResult)hsy_isEmailAddress
{
    if (self.length == 0) {
        return kHSYCocoaKitRegularResultLengthIsZero;
    }
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    BOOL isPassRegex = [self isValidateByRegex:emailRegex];
    if (isPassRegex) {
        return kHSYCocoaKitRegularResultConform;
    }
    return kHSYCocoaKitRegularResultUnconform;
}

- (BOOL)isEmailAddress
{
    kHSYCocoaKitRegularResult result = self.hsy_isEmailAddress;
    if (result == kHSYCocoaKitRegularResultConform) {
        return YES;
    }
    return NO;
}

#pragma mark - 汉字+字符+数字+常用字符 For Regex

- (kHSYCocoaKitRegularResult)hsy_isPassword
{
    return [self hsy_isPasswordFromPrefix:@"6" suffixNumber:@"16"];
}

- (BOOL)isPassword
{
    kHSYCocoaKitRegularResult result = self.hsy_isPassword;
    if (result == kHSYCocoaKitRegularResultConform) {
        return YES;
    }
    return NO;
}

- (kHSYCocoaKitRegularResult)hsy_isPasswordFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix
{
    if (self.length == 0) {
        return kHSYCocoaKitRegularResultLengthIsZero;
    }
    NSString *passwordRegex = [NSString stringWithFormat:@"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{%@,%@}$", prefix, suffix];
    kHSYCocoaKitRegularResult result = ([self isValidateByRegex:passwordRegex] ? kHSYCocoaKitRegularResultConform : kHSYCocoaKitRegularResultUnconform);
    return result;
}

- (BOOL)isPasswordFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix
{
    kHSYCocoaKitRegularResult result = [self hsy_isPasswordFromPrefix:prefix suffixNumber:suffix];
    if (result == kHSYCocoaKitRegularResultConform) {
        return YES;
    }
    return NO;
}

@end
