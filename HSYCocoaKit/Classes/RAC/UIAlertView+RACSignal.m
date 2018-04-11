//
//  UIAlertView+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIAlertView+RACSignal.h"

@implementation UIAlertView (RACSignal)

+ (RACSignal *)hsy_rac_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
{
    return [UIAlertView hsy_rac_showAlertViewWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
}

+ (RACSignal *)hsy_rac_showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
{    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    for (NSString *other in otherButtonTitles) {
        [alertView addButtonWithTitle:other];
    }
    [alertView show];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[alertView rac_buttonClickedSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

@end
