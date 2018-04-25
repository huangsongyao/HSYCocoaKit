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
    self.lineSizeValue = [NSValue valueWithCGSize:CGSizeMake(80.0f, 1.0f)];
    self.buttonSizeValue = [NSValue valueWithCGSize:CGSizeMake((IPHONE_WIDTH / [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_configs].count), 44.0f)];
    self.segmentBackgroundImage = [UIImage imageWithFillColor:WHITE_COLOR];
    self.currentSelectedIndex = @(0);
    self.segmentedControlInView = kHSYCocoaKitBaseSegmentedPageControlInNavigationItem;
    self.segmentedControlHeight = @(IPHONE_BAR_HEIGHT);
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
    CGFloat y = (self.segmentedControlInView == kHSYCocoaKitBaseSegmentedPageControlInNavigationItem ? 0.0f : (self.segmentedControlInView == kHSYCocoaKitBaseSegmentedPageControlInNavigationItem ? self.segmentedControlHeight.floatValue : 0.0f));
    CGFloat h = (y > 0.0f ? (TABLE_VIEW_HEIGHT - IPHONE_BAR_HEIGHT): TABLE_VIEW_HEIGHT);
    NSValue *value = [NSValue valueWithCGRect:CGRectMake(0, y, self.view.width, h)];
    return @{
             @(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : value,
             @(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self,
             @(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(YES),
             @(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator) : @(YES),
             };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView = [NSObject createScrollViewByParam:self.hsy_scrollParamters];
    [self.view addSubview:self.scrollView];
    
    CGRect rect = CGRectMake(0, 0, IPHONE_WIDTH, self.segmentedControlHeight.floatValue);
    _segmentedPageControl = [HSYBaseSegmentedPageControl hsy_showSegmentedPageControlFrame:rect paramters:self.hsy_paramters pageControls:[(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_titles] selectedBlock:^(HSYBaseCustomButton *button, NSInteger index) {
        
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
    NSString *heightPath = @".frame.size.height";
    NSString *xPath = @".frame.orign.x";
    for (UIViewController *vc in hsy_viewController) {
        NSInteger i = [hsy_viewController indexOfObject:vc];
        NSString *title = [(HSYBaseSegmentedPageControlModel *)self.hsy_viewModel hsy_titles][i];
        if ([vc respondsToSelector:NSSelectorFromString(tableString)]) {
            [vc setValue:@(self.scrollView.height) forKey:[NSString stringWithFormat:@"%@%@", tableString, heightPath]];
            [vc setValue:@(x) forKey:[NSString stringWithFormat:@"%@%@", tableString, xPath]];
        } else if ([vc respondsToSelector:NSSelectorFromString(collectionString)]) {
            [vc setValue:@(self.scrollView.height) forKey:[NSString stringWithFormat:@"%@%@", collectionString, heightPath]];
            [vc setValue:@(x) forKey:[NSString stringWithFormat:@"%@%@", collectionString, xPath]];
        }
        if ([vc respondsToSelector:@selector(view)]) {
            vc.view.height = self.scrollView.height;
        }
        [self.scrollView addSubview:vc.view];
        self.navigationItem.title = title;
        if (self.customNavigationBar) {
            self.customNavigationBar.customNavigationItem.title = title;
        }
        x = vc.view.right;
    }
    // Do any additional setup after loading the view.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.canScroll) {
        CGFloat scale = scrollView.contentOffset.x / self.scrollView.contentSizeWidth;
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
