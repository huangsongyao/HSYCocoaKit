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
 初始化，用于http开头的URL链接

 @param urlString url的链接地址
 @param name js调用native需要的触发postMessage方法的对象的名称
 @return self
 */
- (instancetype)initWithUrlString:(NSString *)urlString runNativeName:(NSString *)name;

/**
 初始化，用于HTML文件或者HTML格式的web数据

 @param htmlString HTML数据
 @param name js调用native需要的触发postMessage方法的对象的名称
 @return self
 */
- (instancetype)initWithHtmlString:(NSString *)htmlString runNativeName:(NSString *)name;

/**
 native调用js，触发成功后方法会立即发送completed信号

 @param function js中触发postMessage方法的对象的名称
 @return 回调信号源
 */
- (RACSignal *)hsy_nativeRunJavaScriptFunction:(NSString *)function;

@end
