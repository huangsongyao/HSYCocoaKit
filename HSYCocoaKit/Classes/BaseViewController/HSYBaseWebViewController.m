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

+ (WKWebViewConfiguration *)webViewConfiguration:(NSString *)runNativeName delegate:(id<WKScriptMessageHandler>)delegate
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContent = [[WKUserContentController alloc] init];
    [userContent addScriptMessageHandler:delegate name:runNativeName];
    config.userContentController = userContent;
    
    return config;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[HSYBaseWebViewController webViewConfiguration:self.runNativeName delegate:self]];
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

- (RACSignal *)nativeRunJavaScriptFunction:(NSString *)function
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

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //js调用native
    NSString *messageName = message.name;
    if ([messageName isEqualToString:self.runNativeName]) {
        [self.viewModel.subject sendNext:message.body];
    }
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    //HTML或者js的alert、confirm、prompt方法调用时，直接触发此回调
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    //web页面加载完毕
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    //web页面加载失败
}

@end
