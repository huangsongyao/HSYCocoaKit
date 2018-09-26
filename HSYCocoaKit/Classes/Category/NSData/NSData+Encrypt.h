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

#pragma mark - HMAC-SHA1

/**
 HMAC_SHA1加密，结果“=不进行=”base64编码
 
 @param string 加密消息體
 @param key 密匙
 @return HMAC_SHA1加密結果的字符串
 */
+ (NSString *)HMAC_SHA1EncryptString:(NSString *)string forKey:(NSString *)key;

/**
 HMAC_SHA1加密，结果“=进行=”base64编码
 
 @param string 加密消息體
 @param key 密匙
 @return HMAC_SHA1加密結果的字符串并执行了base64编码后的结果
 */
+ (NSString *)HMAC_SHA1Base64EncryptString:(NSString *)string forKey:(NSString *)key;

/**
 对字符串进行URLEncoded

 @param string string
 @return URLEncoded后的string
 */
+ (NSString *)URL_encoded:(NSString *)string;

/**
 对字符串进行URLDecoded

 @param string string
 @return URLDecoded后的string
 */
+ (NSString *)URL_decodedString:(NSString *)string;

@end
