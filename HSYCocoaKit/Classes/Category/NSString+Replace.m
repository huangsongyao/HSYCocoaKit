//
//  NSString+Replace.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "NSString+Replace.h"

@implementation NSString (Replace)

- (NSMutableArray <NSValue *>*)allSymbolLocations:(NSString *)symbol
{
    if (!symbol || symbol.length == 0 || self.length == 0) {
        return nil;
    }
    NSRange rang = [self rangeOfString:symbol];
    if (rang.location != NSNotFound && rang.length != 0) {
        NSMutableArray *arrayRanges = [[NSMutableArray alloc] init];
        [arrayRanges addObject:@(rang.location)];
        NSRange locationRang = {0, 0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++) {
            if (0 == i) {
                location = rang.location + rang.length;
                length = self.length - rang.location - rang.length;
                locationRang = NSMakeRange(location, length);
            } else {
                location = locationRang.location + locationRang.length;
                length = self.length - locationRang.location - locationRang.length;
                locationRang = NSMakeRange(location, length);
            }
            locationRang = [self rangeOfString:symbol options:NSCaseInsensitiveSearch range:locationRang];
            if (locationRang.location == NSNotFound && locationRang.length == 0) {
                break;
            } else {
                NSValue *value = [NSValue valueWithRange:locationRang];
                [arrayRanges addObject:value];
            }
        }
        return arrayRanges;
    }
    return nil;
}

- (NSString *)stringByReplaceSomeCrashedUnicode
{
    NSString *string = nil;
    if ([self canBeConvertedToEncoding:NSUTF8StringEncoding]) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return string;
}

- (NSString *)stringByReplacingOccurrences
{
    return [self stringByReplacingOccurrencesOfSymbol:@" "];
}

- (NSString *)stringByReplacingOccurrencesOfSymbol:(NSString *)symbol
{
    return [self stringByReplacingOccurrencesOfString:symbol withString:@""];
}

- (NSString *)stringByReplacingOccurrencesOfSymbol:(NSString *)symbol fillContent:(NSString *)content
{
    return [self stringByReplacingOccurrencesOfString:symbol withString:content];
}

@end
