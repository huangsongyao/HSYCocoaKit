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
- (RACSignal *)nativeRunJavaScriptFunction:(NSString *)function;

@end
