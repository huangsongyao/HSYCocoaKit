//
//  HSYBaseTabBarViewController.h
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseViewController.h"
#import "HSYBaseTabBarModel.h"

@interface HSYBaseTabBarViewController : HSYBaseViewController

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@property (nonatomic, strong) NSNumber *tabbarHeight;

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs;

@end
