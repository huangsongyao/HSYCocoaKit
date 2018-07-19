//
//  NSData+Encrypt.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/19.
//

#import "NSData+Encrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Encrypt)

#pragma mark - Base64

+ (NSString *)base64EncodedString:(NSString *)string
{
    NSData *base64Data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [base64Data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return base64String;
}

+ (NSString *)base64DecodeData:(NSString *)string
{
    NSData *decode64Data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decode64String = [[NSString alloc] initWithData:decode64Data encoding:NSUTF8StringEncoding];
    return decode64String;
}

#pragma mark - MD5

+ (NSString *)md5:(NSString *)string
{
    const char *str = [string UTF8String];
    unsigned char hash[16];
    CC_MD5(str, (CC_LONG)strlen(str), hash);
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i = 0; i < 16; ++i) {
        [result appendFormat:@"%02X", hash[i]];
    }
    return result;
}

@end
