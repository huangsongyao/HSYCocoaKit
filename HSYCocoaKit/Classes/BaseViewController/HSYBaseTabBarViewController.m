//
//  HSYBaseTabBarViewController.m
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseTabBarViewController.h"
#import "NSObject+UIKit.h"
#import "HSYBaseTabBarItemCollectionViewCell.h"
#import "HSYBaseSegmentedPageViewController.h"
#import "HSYBaseLaunchScreenViewController.h"

static NSString *const HSYBaseTabBarItemIdentifier = @"kHSYBaseTabBarItemIdentifier";

@interface HSYBaseTabBarViewController ()

@end

@implementation HSYBaseTabBarViewController

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs
{
    if (self = [super init]) {
        self.hsy_viewModel = [[HSYBaseTabBarModel alloc] initWithConfigs:configs];
        _tabbarHeight = @(44.0f);
        if ([HSYBaseLaunchScreenViewController iPhoneXDevice]) {
            _tabbarHeight = @(87.0f);
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenCustomNavigationBar];
    //底部的tabbar
    NSDictionary *layoutParam = @{
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset) : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero],
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection) : @(UICollectionViewScrollDirectionHorizontal),
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize) : [NSValue valueWithCGSize:CGSizeMake((IPHONE_WIDTH/[(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers].count), self.tabbarHeight.floatValue)],
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing) :@(0),
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing) : @(0),
                                  };
    UICollectionViewFlowLayout *layout = [NSObject createFlowLayoutByParam:layoutParam];
    CGRect rect = CGRectMake(0, ((self.customNavigationBar ? IPHONE_HEIGHT : self.view.height) - self.tabbarHeight.floatValue), IPHONE_WIDTH, self.tabbarHeight.floatValue);
    NSMutableDictionary *collectionParam = [@{
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeFrame) : [NSValue valueWithCGRect:rect],
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeLayout) : layout,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeDataSource) : self,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeDelegate) : self,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeScrollEnabled) : @(NO),
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator) : @(YES),
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeBounces) : @(NO),
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass) : @[@{@"HSYBaseTabBarItemCollectionViewCell" : HSYBaseTabBarItemIdentifier}],
                                              } mutableCopy];
    
    _collectionView = [NSObject createCollectionViewByParam:collectionParam];
    [self.view addSubview:self.collectionView];
    
    //添加默认的index == 0的item的所属content内容视图
    NSArray *viewControllers = [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_tabBarItemViewControllers:(IPHONE_HEIGHT - self.collectionView.height)];
    [self.view addSubview:[viewControllers.firstObject view]];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers].count > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HSYBaseTabBarItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HSYBaseTabBarItemIdentifier forIndexPath:indexPath];
    cell.configItem = [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_configItems][indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_reloadDatas:indexPath];
    [self.view addSubview:view];
    [self.collectionView reloadData];
}

#pragma mark - Scroll Page

- (void)scrollToPage:(NSInteger)page
{
    if (page >= 0 && page < [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers].count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:page inSection:0];
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - Set Red Point

- (void)hsy_setRedPointInPage:(NSInteger)page redPointNumbers:(NSNumber *)numbers
{
    if (page < 0 || page > [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers].count) {
        NSLog(@"Set Red Point Failure!----Page Over viewControllers.count");
        return;
    }
    HSYBaseTabBarConfigItem *item = [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_configItems][page];
    item.redPointNumber = numbers;
    [self.collectionView reloadData];
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
