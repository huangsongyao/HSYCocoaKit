//
//  NSData+Encrypt.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/19.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

#pragma mark - base64

/**
 base64加密

 @param string 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)base64EncodedString:(NSString *)string;

/**
 base64解密

 @param string 要解密的字符串
 @return 解密后的字符串
 */
+ (NSString *)base64DecodeData:(NSString *)string;

#pragma mark - MD5

/**
 MD5加密

 @param string 要加密的字符串
 @return MD5加密后的字符串
 */
+ (NSString *)md5:(NSString *)string;

#pragma mark - AES-128-CBC

/**
 AES-128-CBC加密

 @param string 要加密的字符串
 @param key 公匙
 @param iv 偏移量
 @return 加密后的字符串
 */
+ (NSString *)AES128EncryptString:(NSString *)string forKey:(NSString *)key offsetIv:(NSString *)iv;

/**
 AES-128-CBC解密

 @param string 要解密的字符串
 @param key 公匙
 @param iv 偏移量
 @return 解密后的字符串
 */
+ (NSString *)AES128DecryptString:(NSString *)string forKey:(NSString *)key offsetIv:(NSString *)iv;

@end
