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

- (BOOL)isPureNumber
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSInteger i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (BOOL)isPureNumberFromPrefix:(NSString *)prefix suffixNumber:(NSString *)suffix
{
    BOOL validate = [self isPureNumber];
    if (!validate) {
        return validate;
    }
    validate = (self.integerValue >= prefix.integerValue && self.integerValue <= suffix.integerValue);
    return validate;
}

#pragma mark - Email For Regex

- (BOOL)isEmailAddress
{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

@end
