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

@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseSegmentedPageConfig *> *hsy_configs;
@property (nonatomic, strong, readonly) NSMutableArray<UIViewController *> *hsy_viewControllers;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *hsy_titles;

- (instancetype)initWithConfigs:(NSArray<HSYBaseSegmentedPageConfig *> *)configs;

@end
