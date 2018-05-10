//
//  HSYBaseTabBarModel.h
//  Pods
//
//  Created by huangsongyao on 2018/5/3.
//
//

#import "HSYBaseRefleshModel.h"
#import "HSYBaseSegmentedPageConfig.h"

@interface HSYBaseTabBarConfigItem : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIImage *normalImage;
@property (nonatomic, strong, readonly) UIImage *selectedImage;
@property (nonatomic, strong, readonly) UIColor *normalColor;
@property (nonatomic, strong, readonly) UIColor *selectedColor;

@property (nonatomic, assign) BOOL selectedItem;

- (instancetype)initWithTitle:(NSString *)title normalParamter:(NSDictionary *)norParamter selectedParamter:(NSDictionary *)selParamter;

@end

@interface HSYBaseTabBarModel : HSYBaseRefleshModel

//配置内容原始数据集合
@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseTabBarControllerConfig *> *hsy_configs;
//配置内容集合内的原始控制器集合
@property (nonatomic, strong, readonly) NSMutableArray<UIViewController *> *hsy_viewControllers;
//配置内容集合内的原始title数据集合
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *hsy_titles;
//配置内容集合内的原始的tabBarController---item的数据集合
@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseTabBarConfigItem *> *hsy_configItems;
//当前显示的视图内容只有“- hsy_tabBarItemViewControllers:”被执行后，该指针才部位nil
@property (nonatomic, strong, readonly) UIView *currentContentView;

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs;

/**
 更新数据并且移除旧的content视图同时添加新的content视图

 @param indexPath item的选中位置
 @return 新的content视图
 */
- (UIView *)hsy_reloadDatas:(NSIndexPath *)indexPath;

/**
 本方法在控制器的生命周期中只执行一次，并且只会在"- viewDidLoad"方法中执行

 @param height content内容视图的高度
 @return 第一次获取到的content内容视图
 */
- (NSArray<UIViewController *> *)hsy_tabBarItemViewControllers:(CGFloat)height;

@end
