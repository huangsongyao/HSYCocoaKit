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

@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseTabBarControllerConfig *> *hsy_configs;
@property (nonatomic, strong, readonly) NSMutableArray<UIViewController *> *hsy_viewControllers;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *hsy_titles;
@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseTabBarConfigItem *> *hsy_configItems;

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs;
- (void)hsy_reloadDatas:(NSIndexPath *)indexPath;

@end
