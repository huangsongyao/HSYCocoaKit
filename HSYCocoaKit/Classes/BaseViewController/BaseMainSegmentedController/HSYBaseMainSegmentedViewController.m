//
//  HSYBaseMainSegmentedViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2019/3/4.
//

#import "HSYBaseMainSegmentedViewController.h"
#import "ReactiveCocoa.h"
#import "PublicMacroFile.h"
#import "HSYBaseMainSegmentedModel.h"
#import "HSYBaseSegmentedPageViewController.h"

@interface HSYBaseMainSegmentedViewController ()

@end

@implementation HSYBaseMainSegmentedViewController

- (instancetype)initWithSegmentedController:(HSYBaseSegmentedPageViewController *)segmentedController
{
    if (self = [super init]) {
        self.hsy_viewModel = [[HSYBaseMainSegmentedModel alloc] initWithSegmentedController:segmentedController];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.customNavigationBar.hidden = YES;
    
    HSYBaseSegmentedPageViewController *segmentedPageViewController = [(HSYBaseMainSegmentedModel *)self.hsy_viewModel hsy_segmentedPageViewController];
    
    _pageScrollView = [[HSYBasePageScrollView alloc] initWithDelegate:self];
    [self.view addSubview:self.pageScrollView];
    
    @weakify(self);
    segmentedPageViewController.scrollViewWillBeginDragging = ^(UIScrollView *scrollView) {
        @strongify(self);
        self.pageScrollView.userHorizonScroll = NO;
    };
    segmentedPageViewController.scrollViewDidEndDecelerating = ^(UIScrollView *scrollView) {
        @strongify(self);
        self.pageScrollView.userHorizonScroll = YES;
    };
    segmentedPageViewController.scrollViewWillDecelerate = ^(UIScrollView *scrollView) {
        @strongify(self);
        self.pageScrollView.userHorizonScroll = YES;
    };
    // Do any additional setup after loading the view.
}

#pragma mark - HSYBasePageScrollDelegate

- (UIView *)hsy_tableHeaderViewInPageScrollView:(HSYBasePageScrollView *)scrollView
{
    return nil;
}

- (CGFloat)hsy_listViewHeightInPageScrollView:(HSYBasePageScrollView *)scrollView
{
    return (IPHONE_HEIGHT - scrollView.hsy_mainTableView.contentOffset.y);
}

- (UIView *)hsy_pageViewInPageScrollView:(HSYBasePageScrollView *)scrollView
{
    return [(HSYBaseMainSegmentedModel *)self.hsy_viewModel hsy_segmentedPageViewController].view;
}

- (NSArray<id<HSYBasePageTableDelegate>> *)hsy_listViewsInPageScrollView:(HSYBasePageScrollView *)scrollView
{
    HSYBaseSegmentedPageControlModel *segmentedViewModel = (HSYBaseSegmentedPageControlModel *)[(HSYBaseMainSegmentedModel *)self.hsy_viewModel hsy_segmentedPageViewController].hsy_viewModel;
    return [segmentedViewModel.hsy_viewControllers mutableCopy];
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
