//
//  UIView+Gestures.m
//  Pods
//
//  Created by huangsongyao on 2018/5/7.
//
//

#import "UIView+Gestures.h"
#import "ReactiveCocoa.h"

@implementation UIView (Gestures)

- (void)hsy_addTapGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UITapGestureRecognizer *gesture))next
{
    UITapGestureRecognizer *tapGestrue = [[UITapGestureRecognizer alloc] init];
    tapGestrue.delegate = delegate;
    tapGestrue.numberOfTouchesRequired = 1;
    tapGestrue.numberOfTapsRequired = 1;
    [[[tapGestrue rac_gestureSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        if (next) {
            next(x);
        }
    }];
    [self addGestureRecognizer:tapGestrue];
}

@end
