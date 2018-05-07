//
//  NSString+Regular.m
//  Pods
//
//  Created by huangsongyao on 2018/5/7.
//
//

#import "NSString+Regular.h"

@implementation NSString (Regular)

- (BOOL)regularPureNumber
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

- (BOOL)regularPrefixNumber:(NSString *)prefix suffixNumber:(NSString *)suffix
{
    BOOL validate = [self regularPureNumber];
    if (!validate) {
        return validate;
    }
    validate = (self.integerValue >= prefix.integerValue && self.integerValue <= suffix.integerValue);
    return validate;
}

@end
