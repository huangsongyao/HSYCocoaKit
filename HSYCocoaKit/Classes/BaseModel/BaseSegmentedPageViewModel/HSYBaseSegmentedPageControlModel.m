//
//  HSYBaseSegmentedPageControlModel.m
//  Pods
//
//  Created by huangsongyao on 2018/4/25.
//
//

#import "HSYBaseSegmentedPageControlModel.h"
#import "HSYBaseSegmentedPageConfig.h"

@implementation HSYBaseSegmentedPageControlModel

- (instancetype)initWithConfigs:(NSArray<HSYBaseSegmentedPageConfig *> *)configs
{
    if (self = [super init]) {
        _hsy_configs = [NSMutableArray arrayWithArray:configs];
        _hsy_viewControllers = [NSMutableArray arrayWithCapacity:self.hsy_configs.count];
        _hsy_titles = [NSMutableArray arrayWithCapacity:self.hsy_configs.count];
        for (HSYBaseSegmentedPageConfig *config in self.hsy_configs) {
            [self.hsy_viewControllers addObject:config.hsy_viewController];
            [self.hsy_titles addObject:config.hsy_title];
        }
    }
    return self;
}

@end
