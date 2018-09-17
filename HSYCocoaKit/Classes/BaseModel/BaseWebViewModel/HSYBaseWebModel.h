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
@property (nonatomic, copy, readonly) NSArray<NSString *> *hsy_runNativeNames;

/**
 初始化

 @param content 加载的内容，包括：完整的url链接地址、完整的HTML网页的string内容、完整的本地HTML文件地址
 @param names js调用native需要的触发postMessage方法的对象的名称的集合
 @return HSYBaseWebModel
 */
- (instancetype)initWithContent:(NSString *)content loadType:(kHSYCocoaKitWKWebViewLoadType)type runNativeNames:(NSArray<NSString *> *)names;

/**
 创建一个WKWebViewConfiguration用于native和JavaScript的交互

 @param runNativeNames js调用native需要的触发postMessage方法的对象的名称的集合
 @param delegate 签订了WKScriptMessageHandler委托的协议
 @return WKWebViewConfiguration
 */
+ (WKWebViewConfiguration *)hsy_webViewConfigurations:(NSArray<NSString *> *)runNativeNames delegate:(id<WKScriptMessageHandler>)delegate;

/**
 使用“hsy_runNativeNames”属性创建一个WKWebViewConfiguration用于native和JavaScript的交互

 @param delegate 签订了WKScriptMessageHandler委托的协议
 @return WKWebViewConfiguration
 */
- (WKWebViewConfiguration *)hsy_webViewConfigurations:(id<WKScriptMessageHandler>)delegate;

/**
 删除某个HTTP地址的cookies
 
 @param urlString 完整的url地址
 */
+ (void)hsy_deleteAllCookies:(NSString *)urlString;

/**
 设置HTTP多个的cookies
 
 @param cookies cookies内容，格式为@[@{@"cookieA--key" : id}, @{@"cookieA--key" : id}, ...]，其中，cookie--key取值为：@[NSHTTPCookieName, NSHTTPCookieValue, NSHTTPCookieOriginURL, NSHTTPCookieVersion, NSHTTPCookieDomain, NSHTTPCookiePath, NSHTTPCookieSecure, NSHTTPCookieExpires, NSHTTPCookieComment, NSHTTPCookieCommentURL, NSHTTPCookieDiscard, NSHTTPCookieMaximumAge, NSHTTPCookiePort]
 */
+ (void)hsy_setCookies:(NSArray<NSDictionary *> *)cookies;

/**
 设置单个的HTTP的cookie
 
 @param urlString 完整的url地址
 @param cookie 单个的cookie内容，只需要包含NSHTTPCookieName和NSHTTPCookieValue的内容
 @return NSDictionary *类型的单个cookie内容，其中，key为NSHTTPCookieName的类型值，value为NSHTTPCookieValue的类型值
 */
+ (NSDictionary *)hsy_setDefaultCookies:(NSString *)urlString defaultsCookie:(NSDictionary *)cookie;

@end
