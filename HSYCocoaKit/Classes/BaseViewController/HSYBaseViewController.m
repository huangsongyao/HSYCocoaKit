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

@interface HSYBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation HSYBaseViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.hsy_addKeyboardObserver = NO;
        self.hsy_addCustomNavigationBarBackButton = YES;
        self.hsy_addEndEditedKeyboard = NO;
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

#pragma mark - State Code

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
        } else if(model.hsy_codeType == kHSYHUDModelCodeTypeRequestSuccess) {
        
        } else if (model.hsy_codeType == kHSYHUDModelCodeTypeRequestFailure) {
            if (model.hsy_showPromptContent) {
                [HSYHUDHelper hsy_showHUDViewForShowType:model.hsy_showType text:model.hsy_hudString hideAfter:model.hsy_animationTime];
            }
        } else if (model.hsy_codeType == kHSYHUDModelCodeTypeRequestPullUpSuccess) {
            
        } else if (model.hsy_codeType == kHSYHUDModelCodeTypeRequestPullDownSuccess) {
            
        }
        return model.hsy_codeType;
    }
    return kHSYHUDModelCodeTypeDefault;
}

#pragma mark - NavigationBar

- (void)hsy_addCustomNavigationBar
{
    if (!self.customNavigationBar) {
        _customNavigationBar = [[HSYCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, DEFAULT_NAVIGATION_BAR_HEIGHT)];
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
    UIBarButtonItem *backButtonItem = [HSYCustomNavigationBar hsy_backButtonItem:^(UIButton *button, kHSYCustomBarButtonItemTag tag) {
        @strongify(self);
        if (tag == kHSYCustomBarButtonItemTagBack) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    self.customNavigationBar.customNavigationItem.leftBarButtonItems = @[backButtonItem];
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
        self.customNavigationBar.customNavigationItem.leftBarButtonItems = @[backButtonItem];
    } else {
        self.customNavigationBar.customNavigationItem.rightBarButtonItems = @[backButtonItem];
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

@end
