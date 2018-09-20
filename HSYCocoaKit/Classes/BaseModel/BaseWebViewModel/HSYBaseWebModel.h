//
//  HSYBaseWebModel.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseRefleshModel.h"
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitWKWebViewLoadType) {
    
    kHSYCocoaKitWKWebViewLoadTypeRequest            = 732,      //正常的完整的url请求
    kHSYCocoaKitWKWebViewLoadTypeHTMLString,                    //正常的HTML网页string
    kHSYCocoaKitWKWebViewLoadTypeFilePath,                      //HTML文件地址
    
};

@interface HSYBaseWebModel : HSYBaseRefleshModel

@property (nonatomic, copy, readonly) id hsy_requestContent;
@property (nonatomic, assign, readonly) kHSYCocoaKitWKWebViewLoadType hsy_loadType;

@property (nonatomic, strong, readonly) NSArray<WKUserScript *> *hsy_userScripts;
@property (nonatomic, strong, readonly) NSArray<NSString *> *hsy_scriptMessageHandlers;
@property (nonatomic, strong, readonly) WKWebViewConfiguration *hsy_webViewConfiguration;

/**
 初始化

 @param param 加载的内容，包括：完整的url链接地址、完整的HTML网页的string内容、完整的本地HTML文件地址，格式为：@{@(kHSYCocoaKitWKWebViewLoadType枚举类型) : @"kHSYCocoaKitWKWebViewLoadType枚举对应的类型的链接"}
 @return HSYBaseWebModel
 */
- (instancetype)initWithRequestParam:(NSDictionary<NSNumber *, id> *)param;

/**
 初始化，用于注入js到web中

 @param param 加载的内容，包括：完整的url链接地址、完整的HTML网页的string内容、完整的本地HTML文件地址，格式为：@{@(kHSYCocoaKitWKWebViewLoadType枚举类型) : @"kHSYCocoaKitWKWebViewLoadType枚举对应的类型的链接"}
 @param userScripts 向web中注入JavaScript，格式为：@[WKUserScript_A, WKUserScript_B, ...]
 @return HSYBaseWebModel
 */
- (instancetype)initWithRequestParam:(NSDictionary<NSNumber *, id> *)param addUserScripts:(NSArray<WKUserScript *> *)userScripts;

/**
 初始化，用于添加好委托对象，便于js调用native

 @param param 加载的内容，包括：完整的url链接地址、完整的HTML网页的string内容、完整的本地HTML文件地址，格式为：@{@(kHSYCocoaKitWKWebViewLoadType枚举类型) : @"kHSYCocoaKitWKWebViewLoadType枚举对应的类型的链接"}
 @param scriptMessageHandlers 向web中添加监听，格式为：@{[添加过WKScriptMessageHandler委托的对像] : @[@"JavaScript方法A", @"JavaScript方法B", ...]}
 @return HSYBaseWebModel
 */
- (instancetype)initWithRequestParam:(NSDictionary<NSNumber *, id> *)param addScriptMessageHandlers:(NSDictionary<id, NSArray<NSString *> *> *)scriptMessageHandlers;

/**
 初始化，同时添加js对native的观察及注入js到web中

 @param param 加载的内容，包括：完整的url链接地址、完整的HTML网页的string内容、完整的本地HTML文件地址，格式为：@{@(kHSYCocoaKitWKWebViewLoadType枚举类型) : @"kHSYCocoaKitWKWebViewLoadType枚举对应的类型的链接"}
 @param userScripts 向web中注入JavaScript，格式为：@[WKUserScript_A, WKUserScript_B, ...]
 @param scriptMessageHandlers 向web中添加监听，格式为：@{[添加过WKScriptMessageHandler委托的对像] : @[@"JavaScript方法A", @"JavaScript方法B", ...]}
 @return HSYBaseWebModel
 */
- (instancetype)initWithRequestParam:(NSDictionary<NSNumber *, id> *)param addUserScripts:(NSArray<WKUserScript *> *)userScripts addScriptMessageHandlers:(NSDictionary<id, NSArray<NSString *> *> *)scriptMessageHandlers;

/**
 删除某个HTTP地址的cookies，适用于UIWebView，WKWebView不支持
 
 @param urlString 完整的url地址
 */
+ (void)hsy_deleteAllCookies:(NSString *)urlString;

/**
 设置HTTP多个的cookies，适用于UIWebView，WKWebView不支持
 
 @param cookies cookies内容，格式为@[@{@"cookieA--key" : id}, @{@"cookieA--key" : id}, ...]，其中，cookie--key取值为：@[NSHTTPCookieName, NSHTTPCookieValue, NSHTTPCookieOriginURL, NSHTTPCookieVersion, NSHTTPCookieDomain, NSHTTPCookiePath, NSHTTPCookieSecure, NSHTTPCookieExpires, NSHTTPCookieComment, NSHTTPCookieCommentURL, NSHTTPCookieDiscard, NSHTTPCookieMaximumAge, NSHTTPCookiePort]
 */
+ (void)hsy_setCookies:(NSArray<NSDictionary *> *)cookies;

/**
 设置单个的HTTP的cookie，适用于UIWebView，WKWebView不支持
 
 @param urlString 完整的url地址
 @param cookie 单个的cookie内容，只需要包含NSHTTPCookieName和NSHTTPCookieValue的内容
 @return NSDictionary *类型的单个cookie内容，其中，key为NSHTTPCookieName的类型值，value为NSHTTPCookieValue的类型值
 */
+ (NSDictionary *)hsy_setDefaultCookies:(NSString *)urlString defaultsCookie:(NSDictionary *)cookie;

/**
 重置请求地址
 
 @param newContent 新地址内容，格式为：@{@(kHSYCocoaKitWKWebViewLoadType) : @"url、html、filePath"}
 @return RACSignal RACSignal
 */
- (RACSignal *)hsy_resetRequestContent:(NSDictionary *)newContent;

@end
