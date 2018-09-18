//
//  HSYBaseWebViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseRefleshViewController.h"
#import <WebKit/WebKit.h>

@interface HSYBaseWebViewController : HSYBaseRefleshViewController <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong, readonly) WKWebView *webView;

/**
 native调用js，触发成功后方法会立即发送completed信号

 @param function js中触发postMessage方法的对象的名称
 @return 回调信号源
 */
- (RACSignal *)hsy_nativeRunJavaScriptFunction:(NSString *)function;

/**
 重新刷新web地址
 
 @param newContent 新地址内容，格式为：@{@(kHSYCocoaKitWKWebViewLoadType) : @"url、html、filePath"}
 */
- (void)hsy_resetRequest:(NSDictionary *)newContent;

@end
