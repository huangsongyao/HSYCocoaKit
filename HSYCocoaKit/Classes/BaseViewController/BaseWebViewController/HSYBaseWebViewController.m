//
//  HSYBaseWebViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseWebViewController.h"
#import "HSYBaseWebModel.h"

@interface HSYBaseWebViewController () 

@end

@implementation HSYBaseWebViewController

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
    _webView = [[WKWebView alloc] initWithFrame:rect configuration:[HSYBaseWebViewController hsy_webViewConfiguration:[(HSYBaseWebModel *)self.hsy_viewModel hsy_runNativeName] delegate:self]];
    if ([(HSYBaseWebModel *)self.hsy_viewModel hsy_url]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[(HSYBaseWebModel *)self.hsy_viewModel hsy_url]];
        [self.webView loadRequest:request];
    } else {
        [self.webView loadHTMLString:[(HSYBaseWebModel *)self.hsy_viewModel hsy_htmlString] baseURL:nil];
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
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_nativeRunJavaScriptFunction:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

#pragma mark - WKScriptMessageHandler-----JS Run Native

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //js调用native
    NSString *messageName = message.name;
    if ([messageName isEqualToString:[(HSYBaseWebModel *)self.hsy_viewModel hsy_runNativeName]]) {
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
