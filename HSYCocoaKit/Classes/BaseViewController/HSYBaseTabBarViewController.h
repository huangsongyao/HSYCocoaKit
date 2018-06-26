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

#pragma mark - Load

/**
 tabBarItem的布局方式------image的size，子类可重写本方法，返回需要定制的size，默认已有一个size

 @return image的size
 */
+ (CGSize)hsy_loadItemImageSize;

/**
 tabBarItem的布局方式------Image的上边距，子类可重写本方法，返回需要定制的top，默认已有一个top

 @return image的top
 */
+ (CGFloat)hsy_loadItemImageOffsetTop;

/**
 tabBarItem的布局方式------title的高度，子类可重写本方法，返回需要定制的height，默认已有一个height

 @return title的height
 */
+ (CGFloat)hsy_loadItemLabelHeight;

/**
 tabBarItem的布局方式------title的上边距，子类可重写本方法，返回需要定制的top，默认已有一个top

 @return title的top
 */
+ (CGFloat)hsy_loadItemLabelOffsetTop;

/**
 tabBarItem的布局方式------红点的上边距，子类可重写本方法，返回需要定制的top，默认已有一个top

 @return 红点的top
 */
+ (CGFloat)hsy_loadItemRedPointOffsetTop;

/**
 tabBarItem的布局方式------红点的右边距的偏移量，红点的x坐标为item的中心点的x+本方法返回的偏移量，子类可重写本方法，返回需要定制的右偏移量，默认已有一个右偏移量

 @return 红点的右偏移量
 */
+ (CGFloat)hsy_loadItemRedPointCentryRight;

@end
