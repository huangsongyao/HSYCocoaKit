//
//  HSYBaseCollectionViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseCollectionViewController.h"
#import "NSObject+UIKit.h"

@implementation HSYBaseCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _collectionView = [NSObject createCollectionViewByParam:@{
                                                              @(kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass) : @{@"UICollectionViewCell" : @"HSYCocoaKitIdentifier"},
                                                              }];
    [self.view addSubview:self.collectionView];
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
}

@end
