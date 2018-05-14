//
//  HSYBaseWebViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseWebViewController.h"

@interface HSYBaseWebViewController () 

@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSString *htmlString;
@property (nonatomic, copy, readonly) NSString *runNativeName;

@end

@implementation HSYBaseWebViewController

- (instancetype)initWithUrlString:(NSString *)urlString runNativeName:(NSString *)name
{
    if (self = [super init]) {
        BOOL canOpen = [urlString hasPrefix:@"http"];
        NSAssert(canOpen != NO, @"warning！！通常链接必须含有http协议");
        _url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        _runNativeName = name;
    }
    return self;
}

- (instancetype)initWithHtmlString:(NSString *)htmlString runNativeName:(NSString *)name
{
    if (self = [super init]) {
        _htmlString = htmlString;
        _runNativeName = name;
    }
    return self;
}

+ (WKWebViewConfiguration *)hsy_webViewConfiguration:(NSString *)runNativeName delegate:(id<WKScriptMessageHandler>)delegate
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    if (runNativeName.length > 0) {
        WKUserContentController *userContent = [[WKUserContentController alloc] init];
        [userContent addScriptMessageHandler:delegate name:runNativeName];
        config.userContentController = userContent;
    }
    return config;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = self.view.bounds;
    if (self.customNavigationBar && !self.customNavigationBar.hidden) {
        rect = CGRectMake(rect.origin.x, self.customNavigationBar.bottom, rect.size.width, (IPHONE_HEIGHT - self.customNavigationBar.bottom));
    }
    _webView = [[WKWebView alloc] initWithFrame:rect configuration:[HSYBaseWebViewController hsy_webViewConfiguration:self.runNativeName delegate:self]];
    if (self.url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        [self.webView loadRequest:request];
    } else {
        [self.webView loadHTMLString:self.htmlString baseURL:nil];
    }
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
}

#pragma mark - Native Run JS

- (RACSignal *)hsy_nativeRunJavaScriptFunction:(NSString *)function
{
    //native调用js
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.webView evaluateJavaScript:function completionHandler:^(id _Nullable object, NSError * _Nullable error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:object];
                [subscriber sendCompleted];
            }
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

#pragma mark - WKScriptMessageHandler-----JS Run Native

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //js调用native
    NSString *messageName = message.name;
    if ([messageName isEqualToString:self.runNativeName]) {
        if (message.body) {
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNative subscribeContents:@[message.body]];
            [self.hsy_viewModel.subject sendNext:object];
        }
    }
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    //HTML或者js的alert、confirm、prompt方法调用时，直接触发此回调
    if (message) {
        HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNativeForAlert subscribeContents:@[message]];
        [self.hsy_viewModel.subject sendNext:object];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    //web页面加载完毕
    if (self.hsy_showLoading) {
        [self hsy_endSystemLoading];
    }
    if (navigation) {
        HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeDidFinished subscribeContents:@[navigation]];
        [self.hsy_viewModel.subject sendNext:object];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    //web页面加载失败
    if (self.hsy_showLoading) {
        [self hsy_endSystemLoading];
    }
    if (navigation) {
        HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeDidFailed subscribeContents:@[navigation]];
        [self.hsy_viewModel.subject sendNext:object];
    }
    if (error) {
        [self.hsy_viewModel.subject sendError:error];
    }
}

@end
