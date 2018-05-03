//
//  HSYBaseTabBarItemCollectionViewCell.h
//  Pods
//
//  Created by huangsongyao on 2018/5/3.
//
//

#import "HSYBaseCollectionViewCell.h"

@class HSYBaseTabBarConfigItem;
@interface HSYBaseTabBarItemCollectionViewCell : HSYBaseCollectionViewCell

@property (nonatomic, strong, setter=setTabBarItem:) HSYBaseTabBarConfigItem *configItem;

@end
