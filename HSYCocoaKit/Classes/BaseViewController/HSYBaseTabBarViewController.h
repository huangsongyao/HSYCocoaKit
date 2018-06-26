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
//请在"- initWithConfigs:"方法的子类重载中设置高度，默认为系统Tabbar高度，即IPHONE_TABBAR_HEIGHT宏
@property (nonatomic, strong) NSNumber *tabbarHeight;

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs;

/**
 添加接口允许外部设置翻页页面
 
 @param page 要翻页的页码
 */
- (void)scrollToPage:(NSInteger)page;

/**
 外部设置红点

 @param page 红点的显示位置
 @param numbers 红点数目
 */
- (void)hsy_setRedPointInPage:(NSInteger)page redPointNumbers:(NSNumber *)numbers;

@end
