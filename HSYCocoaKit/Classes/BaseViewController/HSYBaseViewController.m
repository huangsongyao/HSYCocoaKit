//
//  HSYBaseViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "HSYBaseViewController.h"
#import "NSError+Message.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"
#import "UIView+Gestures.h"

#define DEFAULT_NAVIGATION_BAR_HEIGHT           IPHONE_BAR_HEIGHT

@interface HSYBaseViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation HSYBaseViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.hsy_addKeyboardObserver = NO;
        self.hsy_addCustomNavigationBarBackButton = YES;
        self.hsy_addEndEditedKeyboard = NO;
        self.backItemImage = @"nav_icon_back";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //viewModel不允许为nil，可以指向它的子类对象
    NSParameterAssert(self.hsy_viewModel);
    if (VERSION_GTR_IOS8) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.class adapterScrollView_iOS_11];
    //监听一般网络请求成功
    @weakify(self);
    [[RACObserve(self, self.hsy_viewModel.hsy_successStatusCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeRequestSuccess subscribeContents:@[x]];
            [self.hsy_viewModel.subject sendNext:object];
        }
    }];
    //监听一般网络请求失败
    [[RACObserve(self, self.hsy_viewModel.hsy_errorStatusCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeRequestFailure subscribeContents:@[x]];
            [self.hsy_viewModel.subject sendNext:object];
        }
    }];
    if (self.hsy_addKeyboardObserver) {
        //键盘监听
        [self observerToKeyboardDidChange:nil subscribeCompleted:^(CGRect frameBegin, CGRect frameEnd) {
            @strongify(self);
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeObserverKeyboard subscribeContents:@[[NSValue valueWithCGRect:frameBegin], [NSValue valueWithCGRect:frameEnd]]];
            [self.hsy_viewModel.subject sendNext:object];
        }];
    }
    if (self.hsy_addEndEditedKeyboard) {
        //点击屏幕收起键盘的手势
        [self.view hsy_addTapGestureRecognizerDelegate:self subscribeNext:^(UITapGestureRecognizer *gesture) {
            @strongify(self);
            [self.view endEditing:YES];
            [self hsy_endEditing];
        }];
    }
    //如果开启了自定义转场，则添加定制化的navigationBar
    if (self.navigationController && [self.navigationController isKindOfClass:[HSYBaseCustomNavigationController class]]) {
        HSYBaseCustomNavigationController *nav = (HSYBaseCustomNavigationController *)self.navigationController;
        if (nav.openTransitionAnimation) {
            [self hsy_addCustomNavigationBar];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Network State Code

- (kHSYHUDModelCodeType)hsy_requestStateCodeWithStateCode:(id)stateCode
{
    if([stateCode isKindOfClass:[NSError class]]) {
        [HSYHUDHelper hsy_hideAllHUDView];
        NSError *error = (NSError *)stateCode;
        if (error.userInfo[kErrorForNotNetworkKey]) {
            [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWrong codeType:kHSYHUDModelCodeTypeDefault text:error.userInfo[kErrorForNotNetworkKey] animationTime:HUD_HIDE_TIME];
        } else if (error.userInfo[NSLocalizedDescriptionKey]) {
            [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWrong codeType:kHSYHUDModelCodeTypeDefault text:error.userInfo[NSLocalizedDescriptionKey] animationTime:HUD_HIDE_TIME ];
        }
        return kHSYHUDModelCodeTypeError;
    } else if ([stateCode isKindOfClass:[HSYHUDModel class]]) {
        HSYHUDModel *model = (HSYHUDModel *)stateCode;
        [HSYHUDHelper hsy_hideAllHUDView];//清除loading页面
        if (model.hsy_codeType == kHSYHUDModelCodeTypeUpdateLoading) {
            if (model.hsy_showPromptContent) {
                [HSYHUDHelper hsy_showHUDViewForShowType:model.hsy_showType text:model.hsy_hudString hideAfter:model.hsy_animationTime];
            }
        } else if (model.hsy_codeType == kHSYHUDModelCodeTypeRequestFailure) {
            if (model.hsy_showPromptContent) {
                [HSYHUDHelper hsy_showHUDViewForShowType:model.hsy_showType text:model.hsy_hudString hideAfter:model.hsy_animationTime];
            }
        } else if (model.hsy_codeType == kHSYHUDModelCodeTypeRequestPullUpSuccess) {
            
        } else if (model.hsy_codeType == kHSYHUDModelCodeTypeRequestPullDownSuccess) {
            
        } else if(model.hsy_codeType == kHSYHUDModelCodeTypeRequestSuccess) {
            
        }
        return model.hsy_codeType;
    }
    return kHSYHUDModelCodeTypeDefault;
}

#pragma mark - Setting

- (void)showSystemLoading:(BOOL)hsy_showLoading
{
    _hsy_showLoading = hsy_showLoading;
    if (hsy_showLoading) {
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicatorView.frame = self.view.bounds;
        if (self.customNavigationBar && !self.customNavigationBar.hidden) {
            self.activityIndicatorView.frame = CGRectMake(0, self.customNavigationBar.bottom, IPHONE_WIDTH, (self.view.height - self.customNavigationBar.bottom));
        }
        if (![self.activityIndicatorView isAnimating]) {
            [self.activityIndicatorView startAnimating];
        }
        [self.view addSubview:self.activityIndicatorView];
        [self.view bringSubviewToFront:self.activityIndicatorView];
    }
}

#pragma mark - Custom NavigationBar

- (void)hsy_addCustomNavigationBar
{
    if (!self.customNavigationBar) {
        if (@available(iOS 11.0, *)) {
            _customNavigationBar = [[HSYCustomNavigationContentViewBar alloc] initWithObject:nil];
        } else {
            _customNavigationBar = [[HSYCustomNavigationBar alloc] initWithObject:nil];
        }
        self.navigationController.navigationBar.backItem.hidesBackButton = YES;
        [self.view addSubview:self.customNavigationBar];
        //添加一个外部标识位用于子类便捷是否创建back按钮，当该标识位为YES并且栈控制器的vc大于1时创建
        if (self.navigationController.viewControllers.count > 1 && self.hsy_addCustomNavigationBarBackButton) {
            [self hsy_pushNavigationItemInLeft];
        }
    }
}

- (void)hsy_pushNavigationItemInLeft
{
    @weakify(self);
    UIBarButtonItem *backButtonItem = [HSYCustomNavigationBar hsy_backButtonItemForImage:self.backItemImage subscribeNext:^(UIButton *button, kHSYCustomBarButtonItemTag tag) {
        @strongify(self);
        if (tag == kHSYCustomBarButtonItemTagBack) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = @[backButtonItem];
}

- (void)hsy_setCustomNavigationBarBackButtonInLeft:(BOOL)left title:(NSString *)title image:(NSString *)image
{
    @weakify(self);
    UIBarButtonItem *backButtonItem = [HSYCustomNavigationBar hsy_backButtonItemForImage:image title:title subscribeNext:^(UIButton *button, kHSYCustomBarButtonItemTag tag) {
        @strongify(self);
        if (tag == kHSYCustomBarButtonItemTagBack) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    if (left) {
        self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = @[backButtonItem];
    } else {
        self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = @[backButtonItem];
    }
}

- (void)hsy_setCustomNavigationBarBackButtonInLeft:(BOOL)left title:(NSString *)title
{
    return [self hsy_setCustomNavigationBarBackButtonInLeft:left title:title image:nil];
}

- (void)hsy_setCustomNavigationBarBackButtonInLeft:(BOOL)left image:(NSString *)image
{
    return [self hsy_setCustomNavigationBarBackButtonInLeft:left title:nil image:image];
}

- (void)hiddenCustomNavigationBar
{
    [self.customNavigationBar removeFromSuperview];
    _customNavigationBar = nil;
}

#pragma mark - End Editing

- (void)hsy_endEditing
{
    //子类如有需要在键盘关闭后实现逻辑时，请重写本方法
}

#pragma mark - Adapter iOS 11

+ (void)adapterScrollView_iOS_11
{
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
}

- (UINavigationItem *)hsy_customNavigationBarNavigationItem
{
    return self.hsy_realCustomNativigation.customNavigationItem;
}

#pragma mark - Loading

- (void)hsy_endSystemLoading
{
    if (self.activityIndicatorView && [self.activityIndicatorView isAnimating]) {
        [self.activityIndicatorView stopAnimating];
    }
}

#pragma mark - Set Custom NavigationBar BackgroundImage

- (void)hsy_setCustomNavigationBarBackgroundImage:(UIImage *)backgroundImage
{
    if (@available(iOS 11.0, *)) {
        HSYCustomNavigationContentViewBar *aboveBar = (HSYCustomNavigationContentViewBar *)self.customNavigationBar;
        [aboveBar setCustomNavigationContentBarBackgroundImage:backgroundImage];
    } else {
        HSYCustomNavigationBar *blewBar = (HSYCustomNavigationBar *)self.customNavigationBar;
        [blewBar setCustomNavigationBarBackgroundImage:backgroundImage];
    }
}

#pragma mark - Real Custom NavigationBar

- (HSYCustomNavigationBar *)hsy_realCustomNativigation
{
    HSYCustomNavigationBar *navigationBar = nil;
    if (@available(iOS 11.0, *)) {
        HSYCustomNavigationContentViewBar *aboveBar = (HSYCustomNavigationContentViewBar *)self.customNavigationBar;
        navigationBar = aboveBar.navigationBar;
    } else {
        HSYCustomNavigationBar *blewBar = (HSYCustomNavigationBar *)self.customNavigationBar;
        navigationBar = blewBar;
    }
    return navigationBar;
}

#pragma mark - StatusBar Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //允许外部设置StatusBar的字体颜色，如果本getter方法未被处分，请检测工程的Info.plist文件，查看是否设置了“View controller-based status bar appearance”项，该项必须设置为YES，才能触发
    return self.statusBarStyle;
}


@end
