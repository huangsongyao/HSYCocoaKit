//
//  UIViewController+Keyboard.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "UIViewController+Keyboard.h"
#import "ReactiveCocoa.h"

static NSString *const kHSYUIKeyboardCenterEndUserInfoKey = @"UIKeyboardCenterEndUserInfoKey";
static NSString *const kHSYUIKeyboardCenterBeginUserInfoKey = @"UIKeyboardCenterBeginUserInfoKey";
static NSString *const kHSYUIKeyboardBoundsUserInfoKey = @"UIKeyboardBoundsUserInfoKey";

@implementation UIViewController (Keyboard)

- (void)observerToKeyboardDidChanged:(id)object subscribeNext:(void(^)(CGRect bounds, CGPoint begin, CGPoint end, CGRect frameBegin, CGRect frameEnd, NSNumber *curve, NSNumber *duration, NSNumber *local))next
{
    [[[UIViewController rac_kvoToKeyboardDidChangeByObject:object] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNotification *notification) {
        if (notification.userInfo && next) {
            NSDictionary *userInfo = notification.userInfo;
            CGRect bounds = [userInfo[kHSYUIKeyboardBoundsUserInfoKey] CGRectValue];
            CGPoint begin = [userInfo[kHSYUIKeyboardCenterBeginUserInfoKey] CGPointValue];
            CGPoint end = [userInfo[kHSYUIKeyboardCenterEndUserInfoKey] CGPointValue];
            CGRect frameBegin = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
            CGRect frameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            NSNumber *curve = userInfo[UIKeyboardAnimationCurveUserInfoKey];
            NSNumber *duration = userInfo[UIKeyboardAnimationDurationUserInfoKey];
            NSNumber *local = nil;
            if (@available(iOS 9.0, *)) {
                local = userInfo[UIKeyboardIsLocalUserInfoKey];
            }
            next(bounds, begin, end, frameBegin, frameEnd, curve, duration, local);
        }
    }];
}

- (void)observerToKeyboardDidChanged:(id)object subscribeCompleted:(void(^)(CGRect frameBegin, CGRect frameEnd))completed
{
    [self observerToKeyboardDidChanged:object subscribeNext:^(CGRect bounds, CGPoint begin, CGPoint end, CGRect frameBegin, CGRect frameEnd, NSNumber *curve, NSNumber *duration, NSNumber *local) {
        if (completed) {
            completed(frameBegin, frameEnd);
        }
    }];
}

- (void)observerToKeyboardWillChanged:(id)object subscribeNext:(void(^)(CGRect bounds, CGPoint begin, CGPoint end, CGRect frameBegin, CGRect frameEnd, NSNumber *curve, NSNumber *duration, NSNumber *local))next
{
    [[[UIViewController rac_kvoToKeyboardWillChangedByObject:object] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNotification *notification) {
        if (notification.userInfo && next) {
            NSDictionary *userInfo = notification.userInfo;
            CGRect bounds = [userInfo[kHSYUIKeyboardBoundsUserInfoKey] CGRectValue];
            CGPoint begin = [userInfo[kHSYUIKeyboardCenterBeginUserInfoKey] CGPointValue];
            CGPoint end = [userInfo[kHSYUIKeyboardCenterEndUserInfoKey] CGPointValue];
            CGRect frameBegin = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
            CGRect frameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            NSNumber *curve = userInfo[UIKeyboardAnimationCurveUserInfoKey];
            NSNumber *duration = userInfo[UIKeyboardAnimationDurationUserInfoKey];
            NSNumber *local = nil;
            if (@available(iOS 9.0, *)) {
                local = userInfo[UIKeyboardIsLocalUserInfoKey];
            }
            next(bounds, begin, end, frameBegin, frameEnd, curve, duration, local);
        }
    }];
}

- (void)observerToKeyboardWillChanged:(id)object subscribeCompleted:(void(^)(CGRect frameBegin, CGRect frameEnd))completed
{
    [self observerToKeyboardWillChanged:object subscribeNext:^(CGRect bounds, CGPoint begin, CGPoint end, CGRect frameBegin, CGRect frameEnd, NSNumber *curve, NSNumber *duration, NSNumber *local) {
        if (completed) {
            completed(frameBegin, frameEnd);
        }
    }];
}

#pragma mark - RAC

+ (RACSignal *)rac_kvoToKeyboardWillShowByObject:(id)object
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:object] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNotification *notification) {
            [subscriber sendNext:notification];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- rac_kvoToKeyboardWillShowByObject” file is “UIViewController+Keyboard.h”");
        }];
    }];
}

+ (RACSignal *)rac_kvoToKeyboardDidShowByObject:(id)object
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:object] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNotification *notification) {
            [subscriber sendNext:notification];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- rac_kvoToKeyboardDidShowByObject:” file is “UIViewController+Keyboard.h”");
        }];
    }];
}
 
+ (RACSignal *)rac_kvoToKeyboardDidHideByObject:(id)object
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidHideNotification object:object] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNotification *notification) {
            [subscriber sendNext:notification];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- rac_kvoToKeyboardDidHideByObject:” file is “UIViewController+Keyboard.h”");
        }];
    }];
}

+ (RACSignal *)rac_kvoToKeyboardDidChangeByObject:(id)object
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidChangeFrameNotification object:nil]
         subscribeNext:^(NSNotification *notification) {
             [subscriber sendNext:notification];
         }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- rac_kvoToKeyboardDidChangeByObject:” file is “UIViewController+Keyboard.h”");
        }];
    }];
}

+ (RACSignal *)rac_kvoToKeyboardWillChangedByObject:(id)object
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil]
         subscribeNext:^(NSNotification *notification) {
             [subscriber sendNext:notification];
         }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- rac_kvoToKeyboardWillChangedByObject:” file is “UIViewController+Keyboard.h”");
        }];
    }];
}

@end
