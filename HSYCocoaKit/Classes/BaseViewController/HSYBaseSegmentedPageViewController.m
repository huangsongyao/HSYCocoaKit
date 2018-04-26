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

@interface HSYBaseSegmentedPageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

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
    self.segmentedControlInView = kHSYCocoaKitBaseSegmentedPageControlInNavigationItem;
    self.segmentedControlHeight = @(IPHONE_NAVIGATION_BAR_HEIGHT);
    self.canScroll = YES;
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
                           @(kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView) : (self.customNavigationBar ? @(self.customNavigationBar.bottom + self.segmentedControlHeight.floatValue) : @(self.segmentedControlHeight.floatValue)),
                           @(kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView) : (self.customNavigationBar ? @(self.customNavigationBar.bottom) : @(0.0f)),
                          };
    NSDictionary *hDic = @{
                           @(kHSYCocoaKitBaseSegmentedPageControlInNavigationItem) : @(TABLE_VIEW_HEIGHT),
                           @(kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView) :@(IPHONE_HEIGHT - (self.customNavigationBar.bottom + self.segmentedControlHeight.floatValue)),
                           @(kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView) : @(IPHONE_HEIGHT - (self.customNavigationBar.bottom + self.segmentedControlHeight.floatValue)),
                           };
    CGFloat y = [yDic[@(self.segmentedControlInView)] floatValue];
    CGFloat h = [hDic[@(self.segmentedControlInView)] floatValue];
    NSValue *value = [NSValue valueWithCGRect:CGRectMake(0, y, self.view.width, h)];
    return @{
             @(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : value,
             @(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self,
             @(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(self.canScroll),
             @(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator) : @(YES),
             @(kHSYCocoaKitOfScrollViewPropretyTypeBounces) : @(NO),
             };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView = [NSObject createScrollViewByParam:self.hsy_scrollParamters];
    [self.view addSubview:self.scrollView];
    
    CGRect rect = CGRectMake(0, 0, (self.buttonSizeValue.CGSizeValue.width * [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_configs].count), self.segmentedControlHeight.floatValue);
    @weakify(self);
    _segmentedPageControl = [HSYBaseSegmentedPageControl hsy_showSegmentedPageControlFrame:rect paramters:self.hsy_paramters pageControls:[(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_titles] selectedBlock:^(HSYBaseCustomButton *button, NSInteger index) {
        @strongify(self);
        [self.scrollView setXPage:index animated:YES];
    }];
    switch (self.segmentedControlInView) {
        case kHSYCocoaKitBaseSegmentedPageControlInNavigationItem: {
            UINavigationItem *navigationItem = self.navigationItem;
            if (self.customNavigationBar) {
                navigationItem = self.customNavigationBar.customNavigationItem;
            }
            navigationItem.titleView = self.segmentedPageControl;
        }
            break;
        case kHSYCocoaKitBaseSegmentedPageControlInScrollViewFooterView:
        case kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView: {
            [self.view addSubview:self.segmentedPageControl];
            if (self.segmentedControlInView == kHSYCocoaKitBaseSegmentedPageControlInScrollViewFooterView) {
                self.segmentedPageControl.y = self.scrollView.bottom;
            }
        }
            break;
        default:
            break;
    }
    
    NSMutableArray *hsy_viewController = [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_viewControllers];
    CGFloat x = 0.0f;
    NSString *tableString = @"tableView";
    NSString *collectionString = @"collectionView";
    for (UIViewController *vc in hsy_viewController) {
        NSInteger i = [hsy_viewController indexOfObject:vc];
        NSString *title = [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_titles][i];
        if ([vc respondsToSelector:@selector(view)]) {
            vc.view.height = self.scrollView.height;
            vc.view.origin = CGPointMake(x, 0);
        }
        if ([vc respondsToSelector:NSSelectorFromString(tableString)]) {
            UITableViewController *tvc = (UITableViewController *)vc;
            tvc.tableView.frame = tvc.view.bounds;
        } else if ([vc respondsToSelector:NSSelectorFromString(collectionString)]) {
            UICollectionViewController *cvc = (UICollectionViewController *)vc;
            cvc.collectionView.frame = cvc.view.bounds;
        }
        [self.scrollView addSubview:vc.view];
        self.navigationItem.title = title;
        if (self.customNavigationBar) {
            self.customNavigationBar.customNavigationItem.title = title;
        }
        x = vc.view.right;
    }
    [self.scrollView setContentSize:CGSizeMake(x, 0)];
    // Do any additional setup after loading the view.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.canScroll) {
        CGFloat scale = scrollView.contentOffset.x / (self.scrollView.width * ([(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_titles].count - 1));
        [self.segmentedPageControl hsy_setContentOffsetFromScale:scale];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"- scrollViewDidEndScrollingAnimation:");
    _canScroll = YES;
    _currentSelectedIndex = @(scrollView.currentPage);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"- scrollViewDidEndDecelerating:");
    if (self.currentSelectedIndex.integerValue != scrollView.currentPage) {
        
    }
    _currentSelectedIndex = @(scrollView.currentPage);
    [self.segmentedPageControl hsy_scrollToSelected:self.segmentedPageControl.segmentedButton[self.currentSelectedIndex.integerValue]];
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
