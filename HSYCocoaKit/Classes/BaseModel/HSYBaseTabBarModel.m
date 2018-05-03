//
//  HSYBaseTabBarModel.m
//  Pods
//
//  Created by huangsongyao on 2018/5/3.
//
//

#import "HSYBaseTabBarModel.h"

@implementation HSYBaseTabBarConfigItem

- (instancetype)initWithTitle:(NSString *)title normalParamter:(NSDictionary *)norParamter selectedParamter:(NSDictionary *)selParamter
{
    if (self = [super init]) {
        _title = title;
        _normalImage = [UIImage imageNamed:norParamter.allKeys.firstObject];
        _normalColor = norParamter.allValues.firstObject;
        _selectedImage = [UIImage imageNamed:selParamter.allKeys.firstObject];
        _selectedColor = selParamter.allValues.firstObject;
    }
    return self;
}

@end

@implementation HSYBaseTabBarModel

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs
{
    if (self = [super init]) {
        _hsy_configs = [NSMutableArray arrayWithArray:configs];
        _hsy_configItems = [NSMutableArray arrayWithCapacity:self.hsy_configs.count];
        _hsy_viewControllers = [NSMutableArray arrayWithCapacity:self.hsy_configs.count];
        _hsy_titles = [NSMutableArray arrayWithCapacity:self.hsy_configs.count];
        for (HSYBaseTabBarControllerConfig *config in self.hsy_configs) {
            [self.hsy_viewControllers addObject:config.hsy_viewController];
            [self.hsy_titles addObject:config.hsy_title];
            HSYBaseTabBarConfigItem *item = [[HSYBaseTabBarConfigItem alloc] initWithTitle:config.hsy_title normalParamter:@{config.imageParamter.allKeys.firstObject : config.titleColorParamter.allKeys.firstObject} selectedParamter:@{config.imageParamter.allValues.firstObject : config.titleColorParamter.allValues.firstObject}];
            item.selectedItem = ([self.hsy_configs indexOfObject:config] == 0);
            [self.hsy_configItems addObject:item];
        }
    }
    return self;
}

- (void)hsy_reloadDatas:(NSIndexPath *)indexPath
{
    for (HSYBaseTabBarConfigItem *item in self.hsy_configItems) {
        item.selectedItem = ([self.hsy_configItems indexOfObject:item] == indexPath.item);
    }
}

@end
