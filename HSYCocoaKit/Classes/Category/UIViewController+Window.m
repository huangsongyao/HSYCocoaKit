//
//  UIViewController+Window.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import "UIViewController+Window.h"
#import "UIApplication+Device.h"
#import "UIViewController+Keyboard.h"
#import "ReactiveCocoa.h"

@implementation UIViewController (Window)

- (void)hsy_keyboardGestureRecycles:(id)object subscribeNext:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view, BOOL isRecycle))next
{
    @weakify(self);
    [self observerToKeyboardWillChanged:object subscribeCompleted:^(CGRect frameBegin, CGRect frameEnd) {
        @strongify(self);
        BOOL isRecycle = (frameBegin.origin.y < frameEnd.origin.y);
        HSYCustomSingleGestureMaskView *single = nil;
        if (isRecycle) {
            single = [self.view viewWithTag:kHSYCocoaKitSingleGestureDefaultTags];
            if (single) {
                [single removeFromSuperview];
                single = nil;
            }
        } else {
            single = [[HSYCustomSingleGestureMaskView alloc] initWithSingleGesture:^(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view) {
                @strongify(self);
                if (next) {
                    next(ges, view, isRecycle);
                    [self.view endEditing:YES];
                }
            }];
            [self.view addSubview:single];
            [self.view bringSubviewToFront:single];
        }
    }];
}

- (void)hsy_keyboardGestureRecycles:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view, BOOL isRecycle))next
{
    [self hsy_keyboardGestureRecycles:nil subscribeNext:next];
}

- (void)hsy_keyboardGestureRecycle:(id)object subscribeNext:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next
{
    [self hsy_keyboardGestureRecycles:object subscribeNext:^(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view, BOOL isRecycle) {
        if (next) {
            next(ges, view);
        }
    }];
}

- (void)hsy_keyboardGestureRecycle:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next
{
    [self hsy_keyboardGestureRecycles:^(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view, BOOL isRecycle) {
        if (next) {
            next(ges, view);
        }
    }];
}


@end
