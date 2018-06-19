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

#pragma mark - Tap

+ (UITapGestureRecognizer *)hsy_tapGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate numberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired numberOfTapsRequired:(NSUInteger)numberOfTapsRequired subscribeNext:(void(^)(UITapGestureRecognizer *gesture))next
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
    return tapGestrue;
}

- (void)hsy_addTapGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UITapGestureRecognizer *gesture))next
{
    UITapGestureRecognizer *tapGestrue = [self.class hsy_tapGestureRecognizerDelegate:delegate
                                                              numberOfTouchesRequired:1
                                                                 numberOfTapsRequired:1
                                                                        subscribeNext:next];
    [self addGestureRecognizer:tapGestrue];
}

- (void)hsy_addDoubleGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UITapGestureRecognizer *gesture))next
{
    UITapGestureRecognizer *tapGestrue = [self.class hsy_tapGestureRecognizerDelegate:delegate
                                                              numberOfTouchesRequired:1
                                                                 numberOfTapsRequired:2
                                                                        subscribeNext:next];
    [self addGestureRecognizer:tapGestrue];
}

#pragma mark - Long

+ (UILongPressGestureRecognizer *)hsy_addLongGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate minimumPressDuration:(CFTimeInterval)duration subscribeNext:(void(^)(UILongPressGestureRecognizer *gesture))next
{
    UILongPressGestureRecognizer *longs = [[UILongPressGestureRecognizer alloc] init];
    longs.delegate = delegate;
    longs.minimumPressDuration = duration;
    [[[longs rac_gestureSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        if (next) {
            next(x);
        }
    }];
    return longs;
}

- (void)hsy_addLongGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UILongPressGestureRecognizer *gesture))next
{
    UILongPressGestureRecognizer *longs = [self.class hsy_addLongGestureRecognizerDelegate:delegate minimumPressDuration:0.5f subscribeNext:next];
    [self addGestureRecognizer:longs];
}


@end
