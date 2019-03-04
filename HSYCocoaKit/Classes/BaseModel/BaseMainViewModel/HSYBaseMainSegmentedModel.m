//
//  HSYBaseMainSegmentedModel.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2019/3/4.
//

#import "HSYBaseMainSegmentedModel.h"
#import "HSYBaseSegmentedPageViewController.h"
#import "HSYBaseSegmentedPageControlModel.h"

@interface HSYBaseMainSegmentedModel ()

@property (nonatomic, strong, readonly) HSYBaseSegmentedPageViewController *mainSegmentedPageViewController;

@end

@implementation HSYBaseMainSegmentedModel

- (instancetype)initWithSegmentedController:(HSYBaseSegmentedPageViewController *)segmentedController
{
    if (self = [super init]) {
        _hsy_segmentPageConfigs = [[(HSYBaseSegmentedPageControlModel *)segmentedController.hsy_viewModel hsy_configs] mutableCopy];
        _mainSegmentedPageViewController = segmentedController;
    }
    return self;
}

- (HSYBaseSegmentedPageViewController *)hsy_segmentedPageViewController
{
    return self.mainSegmentedPageViewController;
}

@end
