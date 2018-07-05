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

- (void)hsy_keyboardGestureRecycle:(id)object
                  observerKeyboard:(void(^)(BOOL isRecycle))keyboard
                     subscribeNext:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next
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
                    next(ges, view);
                    [self.view endEditing:YES];
                }
            }];
            [self.view addSubview:single];
            [self.view bringSubviewToFront:single];
        }
        if (keyboard) {
            keyboard(isRecycle);
        }
    }];
}

- (void)hsy_keyboardGestureRecycle:(void(^)(BOOL isRecycle))keyboard
                     subscribeNext:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next
{
    [self hsy_keyboardGestureRecycle:nil observerKeyboard:keyboard subscribeNext:next];
}

- (void)hsy_keyboardGestureRecycle:(id)object
                  observerKeyboard:(void(^)(BOOL isRecycle))keyboard
{
    [self hsy_keyboardGestureRecycle:object observerKeyboard:keyboard subscribeNext:^(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view) {
        NSLog(@"UITapGestureRecognizer is :%@, HSYCustomSingleGestureMaskView is:%@", ges, view);
    }];
}

- (void)hsy_keyboardGestureRecycleObject:(id)object subscribeNext:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next
{
    [self hsy_keyboardGestureRecycle:object observerKeyboard:^(BOOL isRecycle) {
        NSLog(@"this is %@ keyboard", @(isRecycle));
    } subscribeNext:next];
}

- (void)hsy_keyboardGestureRecycle:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next
{
    [self hsy_keyboardGestureRecycle:^(BOOL isRecycle) {
        NSLog(@"this is %@ keyboard", @(isRecycle));
    } subscribeNext:next];
}

- (void)hsy_keyboardGestureRecycleKeyboard:(void(^)(BOOL isRecycle))keyboard
{
    [self hsy_keyboardGestureRecycle:keyboard subscribeNext:^(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view) {
        NSLog(@"UITapGestureRecognizer is :%@, HSYCustomSingleGestureMaskView is:%@", ges, view);
    }];
}


@end
