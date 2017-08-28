//
//  HSYBaseRefleshViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "HSYBaseViewController.h"

@interface HSYBaseRefleshViewController : HSYBaseViewController

@property (nonatomic, assign) BOOL showPullDown;
@property (nonatomic, assign) BOOL showPullUp;
@property (nonatomic, assign) BOOL showAllReflesh;

@property (nonatomic, copy) void(^observeRefleshPullDown)(id x);
@property (nonatomic, copy) void(^observeRefleshPullUp)(id x);

@end
