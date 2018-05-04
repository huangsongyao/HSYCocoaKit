//
//  HSYBaseTabBarViewController.h
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseViewController.h"
#import "HSYBaseTabBarModel.h"

@interface HSYBaseTabBarViewController : HSYBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
//请在"- initWithConfigs:"方法的子类重载中设置高度，默认为44.0f
@property (nonatomic, strong) NSNumber *tabbarHeight;

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs;

/**
 静态方法设置自控制器

 @param hsy_viewControllers 控制器集合
 @param titles 控制器的title
 @param configs 数据格式集合
 @param scrollView scrollView
 @return 最后一个自控制器的right的值
 */
+ (CGFloat)hsy_addSubViewController:(NSMutableArray *)hsy_viewControllers
                             titles:(NSArray *)titles
                            configs:(NSMutableArray *)configs
                         scrollView:(UIScrollView *)scrollView;

@end
