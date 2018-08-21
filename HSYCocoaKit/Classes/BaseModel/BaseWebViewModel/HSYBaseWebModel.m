//
//  HSYBaseWebModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseWebModel.h"

@implementation HSYBaseWebModel

- (instancetype)initWithContent:(NSString *)content loadType:(kHSYCocoaKitWKWebViewLoadType)type runNativeNames:(NSArray<NSString *> *)names
{
    if (self = [super init]) {
        NSDictionary *dic = @{@(kHSYCocoaKitWKWebViewLoadTypeRequest) : [NSURLRequest requestWithURL:[NSURL URLWithString:content]], @(kHSYCocoaKitWKWebViewLoadTypeHTMLString) : content, @(kHSYCocoaKitWKWebViewLoadTypeFilePath) : [NSURL fileURLWithPath:content], };
        _hsy_requestContent = dic[@(type)];
        _hsy_loadType = type;
        _hsy_runNativeNames = names;
    }
    return self;
}

#pragma mark - WKWebViewConfiguration

+ (WKWebViewConfiguration *)hsy_webViewConfigurations:(NSArray<NSString *> *)runNativeNames delegate:(id<WKScriptMessageHandler>)delegate
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContent = [[WKUserContentController alloc] init];
    for (NSString *runNativeName in runNativeNames) {
        [userContent addScriptMessageHandler:delegate name:runNativeName];
    }
    config.userContentController = userContent;
    return config;
}

- (WKWebViewConfiguration *)hsy_webViewConfigurations:(id<WKScriptMessageHandler>)delegate
{
    WKWebViewConfiguration *config = [self.class hsy_webViewConfigurations:self.hsy_runNativeNames delegate:delegate];
    return config;
}

@end
