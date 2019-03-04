//
//  HSYBaseMainSegmentedViewController.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2019/3/4.
//

#import "HSYBaseViewController.h"
#import "HSYBasePageScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@class HSYBaseSegmentedPageViewController;
@interface HSYBaseMainSegmentedViewController : HSYBaseViewController <HSYBasePageScrollDelegate>
 
//主界面的ScorllView
@property (nonatomic, strong, readonly) HSYBasePageScrollView *pageScrollView;

/**
 初始化，如果需要定制化，则子类继承后重写本方法的superr，然后传入对应的参数
 
 @param segmentedController HSYBaseSegmentedPageViewController的分页容器对象
 @return self
 */
- (instancetype)initWithSegmentedController:(HSYBaseSegmentedPageViewController *)segmentedController;;

@end

NS_ASSUME_NONNULL_END
