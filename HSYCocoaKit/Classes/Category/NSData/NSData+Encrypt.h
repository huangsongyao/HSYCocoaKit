//
//  NSData+Encrypt.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/19.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

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

/**
 MD5加密

 @param string 要加密的字符串
 @return MD5加密后的字符串
 */
+ (NSString *)md5:(NSString *)string;

@end
