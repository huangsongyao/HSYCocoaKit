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
#import "UIScrollView+Page.h"

static NSString *const HSYBaseTabBarItemIdentifier = @"kHSYBaseTabBarItemIdentifier";

@interface HSYBaseTabBarViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HSYBaseTabBarViewController

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs
{
    if (self = [super init]) {
        self.hsy_viewModel = [[HSYBaseTabBarModel alloc] initWithConfigs:configs];
        _tabbarHeight = @(44.0f);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    CGFloat y = (self.customNavigationBar ? self.customNavigationBar.bottom : 0.0f);
    CGFloat h = (self.customNavigationBar ? (IPHONE_HEIGHT - self.customNavigationBar.bottom - self.collectionView.height) : (self.view.height - self.collectionView.height));
    CGRect scrollRect = CGRectMake(0, y, self.view.width, h);
    self.scrollView = [NSObject createScrollViewByParam:@{@(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : [NSValue valueWithCGRect:scrollRect], @(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(NO), @(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator) : @(YES),}];
    [self.view addSubview:self.scrollView];
    
    NSMutableArray *hsy_viewController = [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers];
    CGFloat x = 0.0f;
    NSString *tableString = @"tableView";
    NSString *collectionString = @"collectionView";
    for (UIViewController *vc in hsy_viewController) {
        NSInteger i = [hsy_viewController indexOfObject:vc];
        NSString *title = [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_titles][i];
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
    // Do any additional setup after loading the view.
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
    [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_reloadDatas:indexPath];
    [self.scrollView setXPage:indexPath.item];
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
