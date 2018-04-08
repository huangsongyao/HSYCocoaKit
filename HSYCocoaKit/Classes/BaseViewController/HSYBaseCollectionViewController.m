//
//  HSYBaseCollectionViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseCollectionViewController.h"
#import "NSObject+UIKit.h"

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
     }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加默认的collectionView
    NSParameterAssert(self.registerClasses);
    NSDictionary *layoutParam = @{
                                  @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection) : @(UICollectionViewScrollDirectionVertical),
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
        [self addRefresh:self.collectionView];
    } else {
        if (self.showPullUp) {
            [self addPullUpRefresh:self.collectionView];
        }
        if (self.showPullDown) {
            [self addPullDownRefresh:self.collectionView];
        }
    }
    
    //监听上下拉
    @weakify(self);
    [self.viewModel.subject subscribeNext:^(NSDictionary *signal) {
        @strongify(self);
        kHSYCocoaKitRACSubjectOfNextType type = (kHSYCocoaKitRACSubjectOfNextType)[signal.allKeys.firstObject integerValue];
        if (type == kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess || type == kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess) {
            //下拉刷新成功//上拉加载更多成功
            [self.collectionView reloadData];
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
    [self.viewModel.subject sendNext:@{@(kHSYCocoaKitRACSubjectOfNextTypeCollectionViewDidSelectRow) : indexPath}];
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

@end
