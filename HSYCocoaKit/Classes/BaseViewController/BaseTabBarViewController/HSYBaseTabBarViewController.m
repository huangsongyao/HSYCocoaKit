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
#import "UIViewController+Runtime.h"

static NSString *const HSYBaseTabBarItemIdentifier = @"kHSYBaseTabBarItemIdentifier";

static CGFloat const kHSYCocoaKitDefaultItemImageSize             = 25.0f;
static CGFloat const kHSYCocoaKitDefaultItemImageOffsetTop        = 6.0f;
static CGFloat const kHSYCocoaKitDefaultItemLabelHieght           = 11.0f;
static CGFloat const kHSYCocoaKitDefaultItemLabelOffsetTop        = 4.5f;
static CGFloat const kHSYCocoaKitDefaultItemRedPointOffsetTop     = 4.0f;
static CGFloat const kHSYCocoaKitDefaultItemRedPointCentryRight   = 6.0f;

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

@interface HSYBaseTabBarViewController () <UIViewControllerRuntimeDelegate>

@property (nonatomic, strong) UIImageView *tabBarBackgroundImageView;

@end

@implementation HSYBaseTabBarViewController

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs
{
    if (self = [super init]) {
        self.hsy_viewModel = [[HSYBaseTabBarModel alloc] initWithConfigs:configs];
        _tabBarHeight = @(IPHONE_TABBAR_HEIGHT);
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
    NSDictionary *layoutParam = @{ @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset) : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero], @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection) : @(UICollectionViewScrollDirectionHorizontal), @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize) : [NSValue valueWithCGSize:CGSizeMake((IPHONE_WIDTH/[(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers].count), self.tabBarHeight.floatValue)], @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing) :@(0), @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing) : @(0), };
    
    UICollectionViewFlowLayout *layout = [NSObject createFlowLayoutByParam:layoutParam];
    CGRect rect = CGRectMake(0, ((self.customNavigationBar ? IPHONE_HEIGHT : self.view.height) - self.tabBarHeight.floatValue), IPHONE_WIDTH, self.tabBarHeight.floatValue);
    
    //作为伪tabBar的背景图
    self.tabBarBackgroundImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : self.hsy_tabBarBackgroundImage, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : self.hsy_tabBarBackgroundImage, }];
    self.tabBarBackgroundImageView.frame = rect;
    [self.view addSubview:self.tabBarBackgroundImageView];
    
    if (self.hsy_lineShow.boolValue) {
        //顶部的横线
        UIView *line = [[UIView alloc] initWithSize:CGSizeMake(self.tabBarBackgroundImageView.width, [self.hsy_lineDictionary.allKeys.firstObject floatValue])];
        line.backgroundColor = self.hsy_lineDictionary.allValues.firstObject;
        [self.tabBarBackgroundImageView addSubview:line];
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
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)vc;
            [nav.viewControllers firstObject].hsy_runtimeDelegate = self;
        } else {
            vc.hsy_runtimeDelegate = self;
        }
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
    if (self.selectedItem) {
        self.selectedItem(indexPath, [(HSYBaseTabBarModel *)self.hsy_viewModel hsy_viewControllers][indexPath.row]);
    }
}

#pragma mark - Load

+ (CGSize)hsy_loadItemImageSize
{
    return CGSizeMake(kHSYCocoaKitDefaultItemImageSize, kHSYCocoaKitDefaultItemImageSize);
}

+ (CGFloat)hsy_loadItemImageOffsetTop
{
    return kHSYCocoaKitDefaultItemImageOffsetTop;
}

+ (CGFloat)hsy_loadItemLabelHeight
{
    return kHSYCocoaKitDefaultItemLabelHieght;
}

+ (CGFloat)hsy_loadItemLabelOffsetTop
{
    return kHSYCocoaKitDefaultItemLabelOffsetTop;
}

+ (CGFloat)hsy_loadItemRedPointOffsetTop
{
    return kHSYCocoaKitDefaultItemRedPointOffsetTop;
}

+ (CGFloat)hsy_loadItemRedPointCentryRight
{
    return kHSYCocoaKitDefaultItemRedPointCentryRight;
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
