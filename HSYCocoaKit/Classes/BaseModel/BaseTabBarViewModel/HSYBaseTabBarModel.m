//
//  HSYBaseTabBarModel.m
//  Pods
//
//  Created by huangsongyao on 2018/5/3.
//
//

#import "HSYBaseTabBarModel.h"
#import "HSYBaseSegmentedPageViewController.h"
#import "NSString+Size.h"
#import "HSYBaseTabBarItemCollectionViewCell.h"

@implementation HSYBaseTabBarConfigItem

- (instancetype)initWithTitle:(NSString *)title normalParamter:(NSDictionary *)norParamter selectedParamter:(NSDictionary *)selParamter
{
    if (self = [super init]) {
        _title = title;
        NSString *nor = norParamter[@"normalImage"];
        _normalImage = CREATE_IMG(nor);
        _normalColor = norParamter[@"normalColor"];
        _normalFont = norParamter[@"normalFont"];
        NSString *sel = selParamter[@"selectedImage"];
        _selectedImage = CREATE_IMG(sel);
        _selectedColor = selParamter[@"selectedColor"];
        _selectedFont = selParamter[@"selectedFont"];
    }
    return self;
}

- (CGSize)hsy_redPointWidth:(CGFloat)maxWidth
{
    NSString *string = self.redPointString;
    if (!string) {
        return CGSizeZero;
    } else if (string.length == 0) {
        return CGSizeMake(kHSYCocoaKitMinRedPointHeight, kHSYCocoaKitMinRedPointHeight);
    } else {
        CGSize size = [string contentOfSize:UI_RED_POINT_FONT maxHeight:kHSYCocoaKitMaxRedPointHeight];
        if (size.width < kHSYCocoaKitMaxRedPointHeight) {
            size = CGSizeMake(kHSYCocoaKitMaxRedPointHeight, kHSYCocoaKitMaxRedPointHeight);
        } else {
            size = CGSizeMake(maxWidth, kHSYCocoaKitMaxRedPointHeight);
        }
        return size;
    }
}

- (NSString *)redPointString
{
    NSInteger digital = self.redPointNumber.integerValue;
    NSString *string = nil;
    if (digital > 0) {
        NSString *suffix = @"";
        if (digital > 99) {
            digital = 99;
            suffix = @"+";
        }
        string = [NSString stringWithFormat:@"%@%ld", suffix, (long)digital];
    } else if (digital == -1) {
        string = @"";
    }
    return string;
}

@end

@interface HSYBaseTabBarModel ()

@property (nonatomic, assign, readonly) CGFloat contentHeight;

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
            HSYBaseTabBarConfigItem *item = [[HSYBaseTabBarConfigItem alloc] initWithTitle:config.hsy_title normalParamter:@{@"normalImage" : config.imageParamter.allKeys.firstObject, @"normalColor" : config.titleColorParamter.allKeys.firstObject, @"normalFont" : config.fontParamter.allKeys.firstObject, } selectedParamter:@{@"selectedImage" : config.imageParamter.allValues.firstObject, @"selectedColor" : config.titleColorParamter.allValues.firstObject, @"selectedFont" : config.fontParamter.allValues.firstObject, }];
            item.selectedItem = ([self.hsy_configs indexOfObject:config] == 0);
            [self.hsy_configItems addObject:item];
        }
    }
    return self;
}

- (UIView *)hsy_reloadDatas:(NSIndexPath *)indexPath
{
    for (HSYBaseTabBarConfigItem *item in self.hsy_configItems) {
        item.selectedItem = ([self.hsy_configItems indexOfObject:item] == indexPath.item);
    }
    NSArray *viewControllers = [self hsy_tabBarItemViewControllers:self.contentHeight];
    UIViewController *vc = viewControllers[indexPath.item];
    [self.currentContentView removeFromSuperview];
    _currentContentView = vc.view;
    return vc.view;
}

- (NSArray<UIViewController *> *)hsy_tabBarItemViewControllers:(CGFloat)height
{
    _contentHeight = height;
    NSMutableArray *viewControllers = [HSYBaseSegmentedPageViewController hsy_addSubViewController:self.hsy_viewControllers titles:self.hsy_titles configs:self.hsy_configs height:height];
    for (UIViewController *vc in viewControllers) {
        vc.view.origin = CGPointZero;
    }
    _currentContentView = [viewControllers.firstObject view];
    return [viewControllers mutableCopy];
}

@end
