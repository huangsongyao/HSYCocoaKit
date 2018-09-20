//
//  HSYBaseWebModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseWebModel.h"

@implementation HSYBaseWebModel

- (instancetype)initWithRequestParam:(NSDictionary<NSNumber *, id> *)param addUserScripts:(NSArray<WKUserScript *> *)userScripts addScriptMessageHandlers:(NSDictionary<id, NSArray<NSString *> *> *)scriptMessageHandlers
{
    if (self = [super init]) {
        NSDictionary *dic = @{@(kHSYCocoaKitWKWebViewLoadTypeRequest) : [NSURLRequest requestWithURL:[NSURL URLWithString:param.allValues.firstObject]], @(kHSYCocoaKitWKWebViewLoadTypeHTMLString) : param.allValues.firstObject, @(kHSYCocoaKitWKWebViewLoadTypeFilePath) : [NSURL fileURLWithPath:param.allValues.firstObject], };
        _hsy_requestContent = dic[param.allKeys.firstObject];
        _hsy_loadType = (kHSYCocoaKitWKWebViewLoadType)[param.allKeys.firstObject integerValue];
        _hsy_userScripts = userScripts;
        _hsy_scriptMessageHandlers = scriptMessageHandlers.allValues.firstObject;
        
        //WKWebView配置项
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContent = [[WKUserContentController alloc] init];
        if (userScripts.count > 0) {
            for (WKUserScript *userScript in userScripts) {
                [userContent addUserScript:userScript];
            }
        }
        if (scriptMessageHandlers) {
            id<WKScriptMessageHandler>delegate = scriptMessageHandlers.allKeys.firstObject;
            NSArray<NSString *> *scriptHandlers = scriptMessageHandlers.allValues.firstObject;
            for (NSString *script in scriptHandlers) {
                [userContent addScriptMessageHandler:delegate name:script];
            }
        }
        configuration.userContentController = userContent;
        _hsy_webViewConfiguration = configuration;
    }
    return self;
}

- (instancetype)initWithRequestParam:(NSDictionary<NSNumber *, id> *)param addUserScripts:(NSArray<WKUserScript *> *)userScripts
{
    return [self initWithRequestParam:param addUserScripts:userScripts addScriptMessageHandlers:nil];
}

- (instancetype)initWithRequestParam:(NSDictionary<NSNumber *, id> *)param addScriptMessageHandlers:(NSDictionary<id,NSArray<NSString *> *> *)scriptMessageHandlers
{
    return [self initWithRequestParam:param addUserScripts:nil addScriptMessageHandlers:scriptMessageHandlers];
}

- (instancetype)initWithRequestParam:(NSDictionary<NSNumber *,id> *)param
{
    return [self initWithRequestParam:param addUserScripts:nil addScriptMessageHandlers:nil];
}

#pragma mark - Cookies

+ (void)hsy_deleteAllCookies:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

+ (void)hsy_setCookies:(NSArray<NSDictionary *> *)cookies
{
    for (NSDictionary *cookieDictionary in cookies) {
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDictionary];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
}

+ (NSDictionary *)hsy_setDefaultCookies:(NSString *)urlString defaultsCookie:(NSDictionary *)cookie
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *host = url.host;
    NSString *path = url.path;
    NSNumber *port = url.port;
    NSMutableDictionary *cookies = [@{NSHTTPCookieName : cookie.allKeys.firstObject, NSHTTPCookieValue : cookie.allValues.firstObject, } mutableCopy];
    if (host.length > 0) {
        cookies[NSHTTPCookieDomain] = host;
    }
    if (path.length > 0) {
        cookies[NSHTTPCookiePath] = path;
    }
    if (port) {
        cookies[NSHTTPCookiePort] = port;
    }
    return cookies;
}

#pragma mark - Reset Web

- (RACSignal *)hsy_resetRequestContent:(NSDictionary *)newContent
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *dic = @{@(kHSYCocoaKitWKWebViewLoadTypeRequest) : [NSURLRequest requestWithURL:[NSURL URLWithString:newContent.allValues.firstObject]], @(kHSYCocoaKitWKWebViewLoadTypeHTMLString) : newContent.allValues.firstObject, @(kHSYCocoaKitWKWebViewLoadTypeFilePath) : [NSURL fileURLWithPath:newContent.allValues.firstObject], };
        self->_hsy_requestContent = dic[newContent.allKeys.firstObject];
        self->_hsy_loadType = (kHSYCocoaKitWKWebViewLoadType)[newContent.allKeys.firstObject integerValue];
        [subscriber sendNext:newContent];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release signal “- hsy_resetRequestContent:” in %@ class", NSStringFromClass(self.class));
        }];
    }];
}

@end
