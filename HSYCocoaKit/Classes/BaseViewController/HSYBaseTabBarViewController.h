//
//  HSYBaseTabBarViewController.h
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseViewController.h"
#import "HSYBaseTabBarModel.h"

@interface HSYBaseTabBarViewController : HSYBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>

//底部的tabbar
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
//请在"- initWithConfigs:"方法的子类重载中设置高度，默认为44.0f
@property (nonatomic, strong) NSNumber *tabbarHeight;

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs;

/**
 添加接口允许外部设置翻页页面
 
 @param page 要翻页的页码
 */
- (void)scrollToPage:(NSInteger)page;

@end
