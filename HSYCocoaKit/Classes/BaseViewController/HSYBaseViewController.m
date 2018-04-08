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

#define DEFAULT_NAVIGATION_BAR_HEIGHT           64.0f

@implementation HSYBaseViewController

- (instancetype)init
{
    if (self = [super init]) {
        _addKeyboardObserver = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //viewModel不允许为nil，可以指向它的子类对象
    NSParameterAssert(self.viewModel);
    if (VERSION_GTR_IOS8) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //监听一般网络请求成功
    @weakify(self);
    [[RACObserve(self, self.viewModel.successStatusCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeRequestSuccess subscribeContents:@[x]];
            [self.viewModel.subject sendNext:object];
        }
    }];
    //监听一般网络请求失败
    [[RACObserve(self, self.viewModel.errorStatusCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeRequestFailure subscribeContents:@[x]];
            [self.viewModel.subject sendNext:object];
        }
    }];
    if (self.addKeyboardObserver) {
        //键盘监听
        [self observerToKeyboardDidChange:nil subscribeCompleted:^(CGRect frameBegin, CGRect frameEnd) {
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypeObserverKeyboard subscribeContents:@[[NSValue valueWithCGRect:frameBegin], [NSValue valueWithCGRect:frameEnd]]];
            [self.viewModel.subject sendNext:object];
        }];
    }
    //如果开启了自定义转场，则添加定制化的navigationBar
    if (self.navigationController && [self.navigationController isKindOfClass:[HSYBaseCustomNavigationController class]]) {
        HSYBaseCustomNavigationController *nav = (HSYBaseCustomNavigationController *)self.navigationController;
        if (nav.openTransitionAnimation) {
            [self addCustomNavigationBar];
        }
    }
}

- (kHSYHUDModelCodeType)requestStateCodeWithStateCode:(id)stateCode
{
    if([stateCode isKindOfClass:[NSError class]]) {
        [HSYHUDHelper hideAllHUDView];
        NSError *error = (NSError *)stateCode;
        if (error.userInfo[kErrorForNotNetworkKey]) {
            [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWrong codeType:kHSYHUDModelCodeTypeDefault text:error.userInfo[kErrorForNotNetworkKey] animationTime:HUD_HIDE_TIME];
        } else if (error.userInfo[NSLocalizedDescriptionKey]) {
            [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWrong codeType:kHSYHUDModelCodeTypeDefault text:error.userInfo[NSLocalizedDescriptionKey] animationTime:HUD_HIDE_TIME ];
        }
        return kHSYHUDModelCodeTypeError;
    } else if ([stateCode isKindOfClass:[HSYHUDModel class]]) {
        HSYHUDModel *model = (HSYHUDModel *)stateCode;
        [HSYHUDHelper hideAllHUDView];//清除loading页面
        if (model.codeType == kHSYHUDModelCodeTypeUpdateLoading) {
            if (model.showPromptContent) {
                [HSYHUDHelper showHUDViewForShowType:model.showType text:model.hudString hideAfter:model.animationTime ];
            }
        } else if(model.codeType == kHSYHUDModelCodeTypeRequestSuccess) {
        
        } else if (model.codeType == kHSYHUDModelCodeTypeRequestFailure) {
            if (model.showPromptContent) {
                [HSYHUDHelper showHUDViewForShowType:model.showType text:model.hudString hideAfter:model.animationTime];
            }
        } else if (model.codeType == kHSYHUDModelCodeTypeRequestPullUpSuccess) {
            
        } else if (model.codeType == kHSYHUDModelCodeTypeRequestPullDownSuccess) {
            
        }
        return model.codeType;
    }
    return kHSYHUDModelCodeTypeDefault;
}

#pragma mark - NavigationBar

- (void)addCustomNavigationBar
{
    _customNavigationBar = [[HSYCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, DEFAULT_NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:self.customNavigationBar];
    if (self.navigationController.viewControllers.count > 1) {
        [self pushNavigationItemInLeft];
    }
}

- (void)pushNavigationItemInLeft
{
    @weakify(self);
    UIBarButtonItem *backButtonItem = [HSYCustomNavigationBar backButtonItem:^(UIButton *button, kHSYCustomBarButtonItemTag tag) {
        @strongify(self);
        if (tag == kHSYCustomBarButtonItemTagBack) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    self.customNavigationBar.customNavigationItem.leftBarButtonItems = @[backButtonItem];
}


@end
