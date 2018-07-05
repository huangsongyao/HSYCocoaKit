//
//  HSYBaseSegmentedPageControlModel.h
//  Pods
//
//  Created by huangsongyao on 2018/4/25.
//
//

#import "HSYBaseRefleshModel.h"

@class HSYBaseSegmentedPageConfig;
@interface HSYBaseSegmentedPageControlModel : HSYBaseRefleshModel

//配置项的集合
@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseSegmentedPageConfig *> *hsy_configs;
//由配置项所提取的控制器集合
@property (nonatomic, strong, readonly) NSMutableArray<UIViewController *> *hsy_viewControllers;
//由配置项所提取的title的集合
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *hsy_titles;

/**
 初始化

 @param configs 配置项集合
 @return self
 */
- (instancetype)initWithConfigs:(NSArray<HSYBaseSegmentedPageConfig *> *)configs;

@end
