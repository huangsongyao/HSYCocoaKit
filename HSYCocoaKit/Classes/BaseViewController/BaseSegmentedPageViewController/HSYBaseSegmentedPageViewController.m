//
//  HSYBaseSegmentedPageViewController.m
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseSegmentedPageViewController.h"
#import "UIImage+Canvas.h"
#import "UIScrollView+Page.h"
#import "NSObject+UIKit.h"
#import "UIView+Frame.h"
#import "UIViewController+NavigationItem.h"
#import "HSYBaseTabBarViewController.h"
#import "UIViewController+Runtime.h"
#import "HSYBaseTableViewController.h"

static NSString *tableString = @"tableView";
static NSString *collectionString = @"collectionView";

@implementation UIViewController (SegmentdPage)

- (RACSignal *)hsy_layoutReset
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSValue *value = [NSValue valueWithCGRect:self.view.frame];
        [subscriber sendNext:value];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods“- hsy_layoutReset + %@ Class”", NSStringFromClass(self.class));
        }];
    }];
}

@end

//********************************************************************************************************

@interface HSYBaseSegmentedPageViewController () <UIViewControllerRuntimeDelegate>

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation HSYBaseSegmentedPageViewController

- (instancetype)initWithConfigs:(NSArray<HSYBaseSegmentedPageConfig *> *)configs
{
    if (self = [super init]) {
        self.hsy_viewModel = [[HSYBaseSegmentedPageControlModel alloc] initWithConfigs:configs];
        [self defaultsParamters];
    }
    return self;
}

- (void)defaultsParamters
{
    self.normalFont = UI_SYSTEM_FONT_15;
    self.selectedFont = UI_SYSTEM_FONT_15;
    self.normalColor = BLACK_COLOR;
    self.selectedColor = SEGMENTED_CONTROL_DEFAULT_SELECTED_COLOR;
    self.lineColor = SEGMENTED_CONTROL_DEFAULT_SELECTED_COLOR;
    self.lineSizeValue = [NSValue valueWithCGSize:CGSizeMake(60.0f, 1.0f)];
    self.buttonSizeValue = [NSValue valueWithCGSize:CGSizeMake(70.0f, 44.0f)];
    self.segmentBackgroundImage = [UIImage imageWithFillColor:CLEAR_COLOR];
    self.currentSelectedIndex = @(0);
    self.scrollViewHeight = @(0.0f);
    self.segmentedControlInView = kHSYCocoaKitBaseSegmentedPageControlInNavigationItem;
    self.segmentedControlHeight = @(IPHONE_NAVIGATION_BAR_HEIGHT);
    self.canScroll = YES;
    self.openScroll = YES;
}

- (NSDictionary *)hsy_paramters
{
    return @{
             @(kHSYCocoaKitCustomSegmentedTypeTitleFont) : self.normalFont,
             @(kHSYCocoaKitCustomSegmentedTypeSelectedTitleFont) : self.selectedFont,
             @(kHSYCocoaKitCustomSegmentedTypeNorTitleColor) : self.normalColor,
             @(kHSYCocoaKitCustomSegmentedTypeSelTitleColor) : self.selectedColor,
             @(kHSYCocoaKitCustomSegmentedTypeLineColor) : self.lineColor,
             @(kHSYCocoaKitCustomSegmentedTypeLineSize) : self.lineSizeValue,
             @(kHSYCocoaKitCustomSegmentedTypeButtonSize) : self.buttonSizeValue,
             @(kHSYCocoaKitCustomSegmentedTypeBackgroundImage) : self.segmentBackgroundImage,
             @(kHSYCocoaKitCustomSegmentedTypeSelectedIndex) : self.currentSelectedIndex,
             };
}

- (NSDictionary *)hsy_scrollParamters
{
    NSDictionary *yDic = @{
                           @(kHSYCocoaKitBaseSegmentedPageControlInNavigationItem) : (self.customNavigationBar ? @(self.customNavigationBar.bottom) : @(0.0f)),
                           @(kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView) : (self.customNavigationBar ? @(self.customNavigationBar.bottom + self.segmentedControlHeight.floatValue) : (self.navigationController.navigationBar.hidden ? @(self.segmentedControlHeight.floatValue) : @(self.segmentedControlHeight.floatValue + IPHONE_BAR_HEIGHT))),
                           @(kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView) : (self.customNavigationBar ? @(self.customNavigationBar.bottom) : @(0.0f)),
                          };
    NSDictionary *hDic = @{
                           @(kHSYCocoaKitBaseSegmentedPageControlInNavigationItem) : @(TABLE_VIEW_HEIGHT),
                           @(kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView) : @(IPHONE_HEIGHT - (self.customNavigationBar.bottom + self.segmentedControlHeight.floatValue)),
                           @(kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView) : @(IPHONE_HEIGHT - (self.customNavigationBar.bottom + self.segmentedControlHeight.floatValue)),
                           };
    CGFloat y = [yDic[@(self.segmentedControlInView)] floatValue];
    CGFloat h = [hDic[@(self.segmentedControlInView)] floatValue];
    if (self.scrollViewHeight.floatValue > 0.0f) {
        h = self.scrollViewHeight.floatValue;
    }
    NSValue *value = [NSValue valueWithCGRect:CGRectMake(0, y, self.view.width, h)];
    return @{
             @(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : value,
             @(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self,
             @(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(self.openScroll),
             @(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator) : @(YES),
             @(kHSYCocoaKitOfScrollViewPropretyTypeBounces) : @(NO),
             };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [NSObject createScrollViewByParam:self.hsy_scrollParamters];
    [self.view addSubview:self.scrollView];
    
    CGRect rect = CGRectMake(0, 0, (self.buttonSizeValue.CGSizeValue.width * [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_configs].count), self.segmentedControlHeight.floatValue);
    @weakify(self);
    NSMutableDictionary *hsy_paramters = [NSMutableDictionary dictionaryWithDictionary:self.hsy_paramters];
    for (NSNumber *key in self.segmentedControlParamter.allKeys) {
        hsy_paramters[key] = self.segmentedControlParamter[key];
    }
    _segmentedPageControl = [HSYBaseSegmentedPageControl hsy_showSegmentedPageControlFrame:rect paramters:hsy_paramters pageControls:[(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_titles] selectedBlock:^(HSYBaseCustomButton *button, NSInteger index) {
        @strongify(self);
        self.canScroll = NO;
        [self.scrollView setXPage:index animated:YES];
    }];
    switch (self.segmentedControlInView) {
        case kHSYCocoaKitBaseSegmentedPageControlInNavigationItem: {
            UINavigationItem *navigationItem = self.navigationItem;
            if (self.customNavigationBar) {
                navigationItem = self.hsy_customNavigationBarNavigationItem;
            }
            navigationItem.titleView = self.segmentedPageControl;
        }
            break;
        case kHSYCocoaKitBaseSegmentedPageControlInScrollViewFooterView:
        case kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView: {
            [self.view addSubview:self.segmentedPageControl];
            if (self.segmentedControlInView == kHSYCocoaKitBaseSegmentedPageControlInScrollViewFooterView) {
                self.segmentedPageControl.y = self.scrollView.bottom;
            } else {
                CGFloat y = IPHONE_BAR_HEIGHT;
                if (self.customNavigationBar) {
                    y = self.customNavigationBar.bottom;
                } else if (self.navigationController.navigationBar.hidden) {
                    y = 0.0f;
                }
                self.segmentedPageControl.y = y;
            }
        }
            break;
        default:
            break;
    }
    
    NSMutableArray *hsy_viewControllers = [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_viewControllers];
    CGFloat x = [HSYBaseSegmentedPageViewController hsy_addSubViewController:hsy_viewControllers titles:[(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_titles] configs:[(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_configs] scrollView:self.scrollView];
    [self.scrollView setContentSize:CGSizeMake(x, 0)];
    if (self.currentSelectedIndex.integerValue > 0) {
        [self.scrollView setXPage:self.currentSelectedIndex.integerValue];
    }
    for (UIViewController *vc in hsy_viewControllers) {
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)vc;
            [nav.viewControllers firstObject].hsy_runtimeDelegate = self;
            [self dobi_observerChilsScroll:nav.viewControllers.firstObject];
        } else {
            vc.hsy_runtimeDelegate = self;
            [self dobi_observerChilsScroll:vc];
        }
        //分页控制设置完子控制器布局后，对每个子控制器均发送一个信号，自控制器如果订阅该冷信号，可在next中调整自控制view布局
        [[[vc hsy_layoutReset] rac_willDeallocSignal] subscribeCompleted:^{
            NSLog(@"%@ Class rac_willDeallocSignal", NSStringFromClass(vc.class));
        }];
    }
    // Do any additional setup after loading the view.
}

#pragma mark - Observer Chils Scrolling

- (void)dobi_observerChilsScroll:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:NSClassFromString(@"HSYBaseRefleshViewController")]) {
        HSYBaseRefleshViewController *refreshViewController = (HSYBaseRefleshViewController *)viewController;
        if (self.hsy_observerChilsScrollControllerDidScroll) {
            refreshViewController.hsy_scrollViewDidScroll = ^(UIScrollView *scrollView) {
                self.hsy_observerChilsScrollControllerDidScroll(scrollView);
            };
        }
    }
}

#pragma mark - Add Subview

+ (NSMutableArray<UIViewController *> *)hsy_addSubViewController:(NSMutableArray *)hsy_viewControllers titles:(NSArray *)titles configs:(NSMutableArray *)configs height:(CGFloat)height
{
    CGFloat x = 0.0f;
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:configs.count];
    for (UIViewController *viewController in hsy_viewControllers) {
        NSInteger i = [hsy_viewControllers indexOfObject:viewController];
        NSString *title = titles[i];
        if ([viewController respondsToSelector:@selector(view)]) {
            viewController.view.height = height;
            viewController.view.origin = CGPointMake(x, 0);
        }
        if ([viewController respondsToSelector:NSSelectorFromString(tableString)]) {
            UITableViewController *tableViewController = (UITableViewController *)viewController;
            tableViewController.tableView.frame = tableViewController.view.bounds;
        } else if ([viewController respondsToSelector:NSSelectorFromString(collectionString)]) {
            UICollectionViewController *collectionViewController = (UICollectionViewController *)viewController;
            collectionViewController.collectionView.frame = collectionViewController.view.bounds;
        }
        BOOL hidden = ![configs[i] showNavigationBar];
        viewController.navigationItem.title = title;
        viewController.navigationController.navigationBar.hidden = hidden;
        if ([viewController isKindOfClass:[HSYBaseViewController class]]) {
            HSYBaseViewController *baseViewController = (HSYBaseViewController *)viewController;
            if (baseViewController.customNavigationBar) {
                [(HSYBaseViewController *)viewController hsy_customNavigationBarNavigationItem].title = title;
                [(HSYBaseViewController *)viewController customNavigationBar].hidden = hidden;
            }
        }
        x = viewController.view.right;
        [viewControllers addObject:viewController];
    }
    return viewControllers;
}

+ (CGFloat)hsy_addSubViewController:(NSMutableArray *)hsy_viewControllers
                             titles:(NSArray *)titles
                            configs:(NSMutableArray *)configs
                         scrollView:(UIScrollView *)scrollView
{
    NSMutableArray<UIViewController *> *viewControllers = [self.class hsy_addSubViewController:hsy_viewControllers titles:titles configs:configs height:scrollView.height];
    for (UIViewController *vc in viewControllers) {
        [scrollView addSubview:vc.view];
    }
    CGFloat x = [viewControllers.lastObject view].right;
    return x;
}

- (void)hsy_setCurrentSelectedIndex:(NSNumber *)selectedIndex
{
    HSYBaseCustomButton *button = self.segmentedPageControl.segmentedButton[selectedIndex.integerValue];
    [self.segmentedPageControl hsy_scrollToSelected:button animation:YES];
    [self.scrollView setXPage:selectedIndex.integerValue animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.canScroll) {
        CGFloat scale = scrollView.contentOffset.x / (self.scrollView.width * ([(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_titles].count - 1));
        [self.segmentedPageControl hsy_setContentOffsetFromScale:scale];
    }
    if (self.scrollViewDidScroll) {
        self.scrollViewDidScroll(scrollView);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.canScroll = YES;
    _currentSelectedIndex = @(scrollView.currentPage);
    if (self.scrollEndFinished) {
        self.scrollEndFinished(self.currentSelectedIndex.integerValue, [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_viewControllers][self.currentSelectedIndex.integerValue]);
    }
    if (self.scrollViewDidEndScrollingAnimation) {
        self.scrollViewDidEndScrollingAnimation(scrollView);
    }
    NSLog(@"- scrollViewDidEndScrollingAnimation: 按钮翻页结束, 当前页面位置:%@=%@", self.currentSelectedIndex, @(self.segmentedPageControl.selectedIndex));
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentSelectedIndex = @(scrollView.currentPage);
    [self.segmentedPageControl hsy_scrollToSelected:self.segmentedPageControl.segmentedButton[self.currentSelectedIndex.integerValue] animation:YES];
    if (self.scrollEndFinished) {
        self.scrollEndFinished(self.currentSelectedIndex.integerValue, [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_viewControllers][self.currentSelectedIndex.integerValue]);
    }
    if (self.scrollViewDidEndDecelerating) {
        self.scrollViewDidEndDecelerating(scrollView);
    }
    NSLog(@"- scrollViewDidEndDecelerating: 滚动手势结束, 当前页面位置:%@=%@", self.currentSelectedIndex, @(self.segmentedPageControl.selectedIndex));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.scrollViewWillBeginDragging) {
        self.scrollViewWillBeginDragging(scrollView);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.scrollViewWillDecelerate) {
        self.scrollViewWillDecelerate(scrollView);
    }
}

#pragma mark - UIViewControllerRuntimeDelegate

- (void)hsy_runtimeDelegate:(UIViewControllerRuntimeDelegateObject *)object
{
    if (self.hsy_responseRuntimeDelegate) {
        [[self.hsy_responseRuntimeDelegate(object) deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^{
            NSLog(@"UIViewControllerRuntimeDelegate completed!");
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
