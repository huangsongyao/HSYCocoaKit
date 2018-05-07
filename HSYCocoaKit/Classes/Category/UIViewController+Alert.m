//
//  UIViewController+Alert.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "UIViewController+Alert.h"
#import "UIAlertView+RACSignal.h"
#import "UIAlertController+RACSignal.h"
#import "UIActionSheet+RACSignal.h"
#import "HSYHUDHelper.h"
#import "UIApplication+Device.h"

@implementation UIViewController (Alert)

+ (RACSignal *)hsy_rac_showAlertView:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)titles
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        [[[UIAlertController hsy_rac_showAlertController:title message:message alertActionTitles:titles] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
#else
        NSString *cancelString = titles.firstObject;
        NSMutableArray *others = [NSMutableArray arrayWithArray:titles];
        [others removeObject:cancelString];
        [[[UIAlertView hsy_rac_showAlertViewWithTitle:title message:message cancelButtonTitle:cancelString otherButtonTitles:[others mutableCopy]] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
#endif
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_rac_showAlertView:message:alertActionTitles:”");
        }];
    }];
}

+ (RACSignal *)hsy_rac_showSheetView:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)titles
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        [[UIAlertController hsy_rac_showSheetController:title message:message sheetActionTitles:titles] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
#else
        NSString *cancelString = titles.firstObject;
        NSString *destructiveString = titles.lastObject;
        NSMutableArray *others = [NSMutableArray arrayWithArray:titles];
        [others removeObject:cancelString];
        [others removeObject:destructiveString];
        [[[UIActionSheet hsy_rac_showSheetInView:[UIApplication keyWindows] withTitle:title cancelButtonTitle:cancelString destructiveButtonTitle:destructiveString otherButtonTitles:others] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
#endif
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_rac_showSheetView:message:sheetActionTitles:”");
        }];
    }];
}

#pragma mark - HUD

+ (void)hsy_hudWithMessage:(NSString *)message
{
    [HSYHUDHelper hsy_showHUDViewForMessage:message];
}

@end
