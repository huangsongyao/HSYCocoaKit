//
//  HSYBaseCollectionViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseCollectionViewController.h"
#import "NSObject+UIKit.h"
#import "HSYBaseCollectionModel.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitZeroValue) {
    
    kHSYCocoaKitZeroValueEdge,
    kHSYCocoaKitZeroValueSize,
    kHSYCocoaKitZeroValueRect,
    kHSYCocoaKitZeroValuePoint,
    
};

@implementation HSYBaseCollectionViewController

- (instancetype)init
{
    if (self = [super init]) {
        _scrollIndicator = @(NO);
        _scrollEnabled = @(YES);
        _bounces = @(YES);
        _scrollDirection = UICollectionViewScrollDirectionVertical;
     }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加默认的collectionView
    NSParameterAssert(self.registerClasses);
    NSDictionary *layoutParam = @{
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection) : @(self.scrollDirection),
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset) : self.sectionInset ? self.sectionInset : [self.class zeroValueForType:kHSYCocoaKitZeroValueEdge],
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize) : self.itemSize ? self.itemSize : [self.class zeroValueForType:kHSYCocoaKitZeroValueSize],
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing) : self.lineSpacing ? self.lineSpacing : @(0),
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing) : self.interitemSpacing ? self.interitemSpacing : @(0),
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeHeaderReferenceSize) : self.headerReferenceSize ? self.headerReferenceSize : [self.class zeroValueForType:kHSYCocoaKitZeroValueSize],
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeFooterReferenceSize) : self.footerReferenceSize ? self.footerReferenceSize : [self.class zeroValueForType:kHSYCocoaKitZeroValueSize],
                                  };
    UICollectionViewFlowLayout *layout = [NSObject createFlowLayoutByParam:layoutParam];
    NSMutableDictionary *collectionParam = [@{
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeFrame) : [NSValue valueWithCGRect:self.view.bounds],
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeLayout) : layout,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeDataSource) : self,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeDelegate) : self,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeScrollEnabled) : self.scrollEnabled,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator) : self.scrollIndicator,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeBounces) : self.bounces,
                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass) : self.registerClasses,
                                              } mutableCopy];
    
    _collectionView = [NSObject createCollectionViewByParam:collectionParam];
    [self.view addSubview:self.collectionView];
    
    //添加上下拉
    if (self.showAllReflesh) {
        [self hsy_addRefresh:self.collectionView];
    } else {
        if (self.showPullUp) {
            [self hsy_addPullUpRefresh:self.collectionView];
        }
        if (self.showPullDown) {
            [self hsy_addPullDownRefresh:self.collectionView];
        }
    }
    
    //监听上下拉
    @weakify(self);
    [self.hsy_viewModel.subject subscribeNext:^(HSYCocoaKitRACSubscribeNotification *signal) {
        @strongify(self);
        if (self.hsy_refreshResult) {
            RACSignal *refreshSignal = self.hsy_refreshResult(signal);
            [[refreshSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitRACSubscribeNotification *notification) {
                if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess ||
                    notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess) {
                    if (self.hsy_viewModel.hsy_isFirstTimes) {
                        self.hsy_viewModel.hsy_isFirstTimes = !self.hsy_viewModel.hsy_isFirstTimes;
                    }
                    if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess && [notification.subscribeContents.firstObject isKindOfClass:[HSYHUDModel class]]) {
                        HSYHUDModel *hudModel = notification.subscribeContents.firstObject;
                        if (hudModel.pullUpSize < self.hsy_viewModel.size) {
                            if (self.pullUpStatus == kHSYCocoaKitRefreshForPullUpCompletedStatusClose) {
                                [self hsy_closePullUp:self.collectionView];
                            } else {
                                [self hsy_notMorePullUp:self.collectionView];
                            }
                        }
                    }
                    //下拉刷新成功//上拉加载更多成功
                    [self.collectionView reloadData];
                }
            }];
        }
    }];
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeCollectionViewDidSelectRow subscribeContents:@[indexPath]];
}

#pragma mark - For Value

+ (NSValue *)zeroValueForType:(kHSYCocoaKitZeroValue)type
{
    NSValue *value = nil;
    switch (type) {
        case kHSYCocoaKitZeroValueEdge: {
            value = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
        }
            break;
        case kHSYCocoaKitZeroValueSize: {
            value = [NSValue valueWithCGSize:CGSizeZero];
        }
            break;
        case kHSYCocoaKitZeroValueRect: {
            value = [NSValue valueWithCGRect:CGRectZero];
        }
            break;
        case kHSYCocoaKitZeroValuePoint: {
            value = [NSValue valueWithCGPoint:CGPointZero];
        }
            break;
        default:
            break;
    }
    return value;
}

#pragma mark - First Request

- (void)firstRequest
{
    self.hsy_viewModel.hsy_isFirstTimes = YES;
    [self.collectionView.pullToRefreshView startAnimating];
    [self hsy_closePullUp:self.collectionView];
}


@end
