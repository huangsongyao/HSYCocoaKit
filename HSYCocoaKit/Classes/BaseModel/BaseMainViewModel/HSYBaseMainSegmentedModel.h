//
//  HSYBaseMainSegmentedModel.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2019/3/4.
//

#import "HSYBaseRefleshModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HSYBaseSegmentedPageConfig, HSYBaseSegmentedPageViewController;
@interface HSYBaseMainSegmentedModel : HSYBaseRefleshModel

@property (nonatomic, copy, readonly) NSArray<HSYBaseSegmentedPageConfig *> *hsy_segmentPageConfigs;
- (instancetype)initWithSegmentedController:(HSYBaseSegmentedPageViewController *)segmentedController;
- (HSYBaseSegmentedPageViewController *)hsy_segmentedPageViewController;

@end

NS_ASSUME_NONNULL_END
