//
//  HSYBaseTabBarViewController.h
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseViewController.h"
#import "HSYBaseTabBarModel.h"

@interface UIViewController (TabBar)

/**
 用于tabBar控制器内设置好布局后，如果外部需要对布局做调整，可在子控制器的"- viewDidLoad"方法中内部订阅本信号，重新调整布局
 
 @return RACSignal，会返回一个NSValue--CGRect，为每个子控制器的view在翻页控制器中的scrollView的布局frame
 */
- (RACSignal *)hsy_layoutTabBarReset;

@end

//**************************************************************************************************

@interface HSYBaseTabBarViewController : HSYBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>

//底部的tabbar
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
//请在"- initWithConfigs:"方法的子类重载中设置高度，默认为系统Tabbar高度，即IPHONE_TABBAR_HEIGHT宏
@property (nonatomic, strong) NSNumber *tabbarHeight;
//请在"- initWithConfigs:"方法的子类重载中设置，tabBar的背景图，默认为白色
@property (nonatomic, strong) UIImage *hsy_tabBarBackgroundImage;
//请在"- initWithConfigs:"方法的子类重载中设置，是否显示tabBar的顶部的横线，默认显示
@property (nonatomic, strong) NSNumber *hsy_lineShow;
//请在"- initWithConfigs:"方法的子类重载中设置，当“hsy_lineShow”为YES时，该属性有效，默认为@{@(高0.5f) : @"灰色"}
@property (nonatomic, strong) NSDictionary *hsy_lineDictionary;

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
