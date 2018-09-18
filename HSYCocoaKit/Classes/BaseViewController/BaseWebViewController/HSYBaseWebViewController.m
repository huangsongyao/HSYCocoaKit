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

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = self.view.bounds;
    if (self.customNavigationBar && !self.customNavigationBar.hidden) {
        rect = CGRectMake(rect.origin.x, self.customNavigationBar.bottom, rect.size.width, (IPHONE_HEIGHT - self.customNavigationBar.bottom));
    }
    WKWebViewConfiguration *webViewConfiguration = [(HSYBaseWebModel *)self.hsy_viewModel hsy_webViewConfigurations:self];
    _webView = [[WKWebView alloc] initWithFrame:rect configuration:webViewConfiguration];
    [self hsy_resetPerformSelector];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
}

- (void)hsy_resetPerformSelector
{
    NSDictionary *methods = @{@(kHSYCocoaKitWKWebViewLoadTypeRequest) : NSStringFromSelector(@selector(loadRequest:)), @(kHSYCocoaKitWKWebViewLoadTypeHTMLString) : NSStringFromSelector(@selector(loadHTMLString:baseURL:)), @(kHSYCocoaKitWKWebViewLoadTypeFilePath) : NSStringFromSelector(@selector(loadFileURL:allowingReadAccessToURL:))};
    NSString *method = methods[@([(HSYBaseWebModel *)self.hsy_viewModel hsy_loadType])];
    if (method.length > 0) {
        HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING ([self.webView performSelector:NSSelectorFromString(method) withObject:[(HSYBaseWebModel *)self.hsy_viewModel hsy_requestContent]]);
    }
}

#pragma mark - Reset

- (void)hsy_resetRequest:(NSDictionary *)newContent
{
    @weakify(self);
    [[[(HSYBaseWebModel *)self.hsy_viewModel hsy_resetRequestContent:newContent] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        self.hsy_showLoading = YES;
        [self hsy_resetPerformSelector];
    }];
}

#pragma mark - Native Run JS

- (RACSignal *)hsy_nativeRunJavaScriptFunction:(NSString *)function
{
    //native调用js
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.webView evaluateJavaScript:function completionHandler:^(id _Nullable object, NSError * _Nullable error) {
            if (error) {
                NSLog(@"methods “- hsy_nativeRunJavaScriptFunction:” error is %@", error);
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
    if ([[(HSYBaseWebModel *)self.hsy_viewModel hsy_runNativeNames] containsObject:messageName]) {
        if (message) {
            [(HSYBaseWebModel *)self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNative subscribeContents:@[message]];
        }
    }
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(nonnull void (^)(void))completionHandler
{
    [self hsy_runJavaScriptAlertOrConfirm:message];
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler
{
    [self hsy_runJavaScriptAlertOrConfirm:message];
    completionHandler(YES);
}

- (void)hsy_runJavaScriptAlertOrConfirm:(NSString *)message
{
    //HTML或者js的alert、confirm、prompt方法调用时，直接触发此回调
    NSString *resultMessage = message;
    if (resultMessage.length == 0) {
        resultMessage = @"";
    }
    [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNativeForAlert subscribeContents:@[resultMessage]];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    //web页面加载完毕
    if (self.hsy_showLoading) {
        [self hsy_endSystemLoading];
    }
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    if (navigation) {
        [contents addObject:navigation];
    }
    [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeDidFinished subscribeContents:contents];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    //web页面加载失败
    if (self.hsy_showLoading) {
        [self hsy_endSystemLoading];
    }
    NSLog(@"\n web load failure, error is %@", error);
    NSMutableArray *contents = [@[error] mutableCopy];
    if (navigation) {
        [contents addObject:navigation];
    }
    [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeDidFailed subscribeContents:contents];
}


@end
