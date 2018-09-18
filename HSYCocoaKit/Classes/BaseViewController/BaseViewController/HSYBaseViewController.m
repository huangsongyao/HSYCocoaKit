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
#import "HSYBaseViewController+CustomNavigationItem.h"

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
        self.backItemHighImage = @"nav_icon_back";
        self.barButtonUIEdgeInset = @(DEFAULT_BUTTOM_EDGE_INSETS_LEFT);
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
            [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeRequestSuccess subscribeContents:@[x]];
        }
    }];
    //监听一般网络请求失败
    [[RACObserve(self, self.hsy_viewModel.hsy_errorStatusCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeRequestFailure subscribeContents:@[x]];
        }
    }];
    if (self.hsy_addKeyboardObserver) {
        //键盘监听
        [self observerToKeyboardWillChanged:self.hsy_keyboardObserObject subscribeCompleted:^(CGRect frameBegin, CGRect frameEnd) {
            @strongify(self);
            [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeObserverKeyboard subscribeContents:@[[NSValue valueWithCGRect:frameBegin], [NSValue valueWithCGRect:frameEnd]]];
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
        [HSYHUDHelper hsy_hideHUDView];
        NSError *error = (NSError *)stateCode;
        NSString *message = error.userInfo[kErrorForNotNetworkKey];
        if (!message) {
            message = error.userInfo[NSLocalizedDescriptionKey];
            if (message.length == 0) {
                message = HSYLOCALIZED(@"未知错误！");
            }
        }
        [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWait codeType:kHSYHUDModelCodeTypeDefault text:message animationTime:HUD_HIDE_TIME];
        return kHSYHUDModelCodeTypeError;
    } else if ([stateCode isKindOfClass:[HSYHUDModel class]]) {
        HSYHUDModel *model = (HSYHUDModel *)stateCode;
        [HSYHUDHelper hsy_hideHUDView];//清除loading页面
        if (model.hsy_showPromptContent) {
            [HSYHUDHelper hsy_showHUDViewForShowType:model.hsy_showType text:model.hsy_hudString hideAfter:model.hsy_animationTime];
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
        if (!self.activityIndicatorView) {
            self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.activityIndicatorView.frame = self.view.bounds;
            self.activityIndicatorView.backgroundColor = WHITE_COLOR;
            if (self.customNavigationBar && !self.customNavigationBar.hidden) {
                self.activityIndicatorView.frame = CGRectMake(0, self.customNavigationBar.bottom, IPHONE_WIDTH, (self.view.height - self.customNavigationBar.bottom));
            }
            [self.view addSubview:self.activityIndicatorView];
            [self.view bringSubviewToFront:self.activityIndicatorView];
        }
        if (![self.activityIndicatorView isAnimating]) {
            [self.activityIndicatorView startAnimating];
        }
    }
}

#pragma mark - Loading

- (void)hsy_endSystemLoading
{
    if (self.activityIndicatorView && [self.activityIndicatorView isAnimating]) {
        [self.activityIndicatorView stopAnimating];
    }
}

#pragma mark - NavigationBar

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

- (void)hiddenCustomNavigationBar
{
    [self.customNavigationBar removeFromSuperview];
    _customNavigationBar = nil;
}

#pragma mark - Custom NavigationBar BarButton

- (void)hsy_pushNavigationItemInLeft
{
    @weakify(self);
    UIBarButtonItem *backButtonItem = [HSYCustomNavigationBar hsy_backButtonItemForImage:self.backItemImage highImage:self.backItemHighImage subscribeNext:^(UIButton *button, NSInteger tag) {
        @strongify(self);
        if (tag == kHSYCocoaKitDefaultCustomBarItemTag) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = @[backButtonItem];
}

- (void)hsy_setLeftBarButtonImages:(NSArray<NSDictionary *> *)images
                     subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsImages:images left:-self.barButtonUIEdgeInset.floatValue subscribeNext:next];
}

- (void)hsy_setLeftBarButtonImages:(NSArray<NSDictionary *> *)images
                        highImages:(NSArray<NSDictionary *> *)highImages
                     subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsImages:images highImages:highImages left:-self.barButtonUIEdgeInset.floatValue subscribeNext:next];
}

- (void)hsy_setRightBarButtonImages:(NSArray<NSDictionary *> *)images
                      subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsImages:images left:self.barButtonUIEdgeInset.floatValue subscribeNext:next];
}

- (void)hsy_setRightBarButtonImages:(NSArray<NSDictionary *> *)images
                         highImages:(NSArray<NSDictionary *> *)highImages
                      subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsImages:images highImages:highImages left:self.barButtonUIEdgeInset.floatValue subscribeNext:next];
}

- (void)hsy_setLeftBarButtonTitles:(NSArray<NSDictionary *> *)titles
                       titleColors:(NSArray<UIColor *> *)titleColors
                        titleFonts:(NSArray<UIFont *> *)titleFonts
                     subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsTitles:titles titleColors:titleColors titleFonts:titleFonts left:-self.barButtonUIEdgeInset.floatValue subscribeNext:next];
}

- (void)hsy_setRightBarButtonTitles:(NSArray<NSDictionary *> *)titles
                        titleColors:(NSArray<UIColor *> *)titleColors
                         titleFonts:(NSArray<UIFont *> *)titleFonts
                      subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsTitles:titles titleColors:titleColors titleFonts:titleFonts left:self.barButtonUIEdgeInset.floatValue subscribeNext:next];
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

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    for (NSString *className in self.hsy_clashGestures) {
        if ([NSStringFromClass(touch.view.class) isEqualToString:className]) {
            return NO;
        }
    }
    return YES;
}

@end
