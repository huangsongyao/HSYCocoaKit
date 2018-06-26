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
#import "PublicMacroFile.h"
#import "UIImage+Canvas.h"

static NSString *const HSYBaseTabBarItemIdentifier = @"kHSYBaseTabBarItemIdentifier";

@implementation UIViewController (TabBar)

- (RACSignal *)hsy_layoutTabBarReset
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSValue *value = [NSValue valueWithCGRect:self.view.frame];
        [subscriber sendNext:value];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods“- hsy_layoutTabBarReset + %@ Class”", NSStringFromClass(self.class));
        }];
    }];
}

@end

//****************************************************************************************************

@interface HSYBaseTabBarViewController ()

@property (nonatomic, strong) UIImageView *tabBarBackgroundImage;

@end

@implementation HSYBaseTabBarViewController

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs
{
    if (self = [super init]) {
        self.hsy_viewModel = [[HSYBaseTabBarModel alloc] initWithConfigs:configs];
        _tabbarHeight = @(IPHONE_TABBAR_HEIGHT);
        _hsy_tabBarBackgroundImage = [UIImage imageWithFillColor:WHITE_COLOR];
        _hsy_lineShow = @(YES);
        _hsy_lineDictionary = @{@(0.5f) : RGB(104, 104, 104)};
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenCustomNavigationBar];
    //底部的tabbar的布局
    NSDictionary *layoutParam = @{ @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset) : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero], @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection) : @(UICollectionViewScrollDirectionHorizontal), @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize) : [NSValue valueWithCGSize:CGSizeMake((IPHONE_WIDTH/[(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers].count), self.tabbarHeight.floatValue)], @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing) :@(0), @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing) : @(0), };
    
    UICollectionViewFlowLayout *layout = [NSObject createFlowLayoutByParam:layoutParam];
    CGRect rect = CGRectMake(0, ((self.customNavigationBar ? IPHONE_HEIGHT : self.view.height) - self.tabbarHeight.floatValue), IPHONE_WIDTH, self.tabbarHeight.floatValue);
    
    //作为伪tabBar的背景图
    self.tabBarBackgroundImage = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : self.hsy_tabBarBackgroundImage, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : self.hsy_tabBarBackgroundImage, }];
    self.tabBarBackgroundImage.frame = rect;
    [self.view addSubview:self.tabBarBackgroundImage];
    
    if (self.hsy_lineShow.boolValue) {
        //顶部的横线
        UIView *line = [[UIView alloc] initWithSize:CGSizeMake(self.tabBarBackgroundImage.width, [self.hsy_lineDictionary.allKeys.firstObject floatValue])];
        line.backgroundColor = self.hsy_lineDictionary.allValues.firstObject;
        [self.tabBarBackgroundImage addSubview:line];
    }
    
    //伪tabBar
    NSMutableDictionary *collectionParam = [@{ @(kHSYCocoaKitOfCollectionViewPropretyTypeFrame) : [NSValue valueWithCGRect:rect], @(kHSYCocoaKitOfCollectionViewPropretyTypeLayout) : layout, @(kHSYCocoaKitOfCollectionViewPropretyTypeDataSource) : self, @(kHSYCocoaKitOfCollectionViewPropretyTypeDelegate) : self, @(kHSYCocoaKitOfCollectionViewPropretyTypeScrollEnabled) : @(NO), @(kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator) : @(YES), @(kHSYCocoaKitOfCollectionViewPropretyTypeBounces) : @(NO), @(kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass) : @[@{@"HSYBaseTabBarItemCollectionViewCell" : HSYBaseTabBarItemIdentifier}], } mutableCopy];
    
    _collectionView = [NSObject createCollectionViewByParam:collectionParam];
    self.collectionView.backgroundColor = CLEAR_COLOR;
    [self.view addSubview:self.collectionView];
    
    //添加默认的index == 0的item的所属content内容视图
    NSArray *viewControllers = [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_tabBarItemViewControllers:(IPHONE_HEIGHT - self.collectionView.height)];
    [self.view addSubview:[viewControllers.firstObject view]];
    for (UIViewController *vc in viewControllers) {
        [[[vc hsy_layoutTabBarReset] rac_willDeallocSignal] subscribeCompleted:^{
            NSLog(@"%@ Class rac_willDeallocSignal", NSStringFromClass(vc.class));
        }];
    }
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
