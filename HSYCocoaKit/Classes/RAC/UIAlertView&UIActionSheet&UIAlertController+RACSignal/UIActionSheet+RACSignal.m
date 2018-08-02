//
//  UIActionSheet+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIActionSheet+RACSignal.h"

@implementation UIActionSheet (RACSignal)

+ (RACSignal *)hsy_rac_showSheetInView:(UIView *)view withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles {
    
    return [UIActionSheet hsy_rac_showSheetInView:view withTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles];
}

+ (RACSignal *)hsy_rac_showSheetInView:(UIView *)view withTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    
    for (NSString *other in otherButtonTitles) {
        [sheet addButtonWithTitle:other];
    }
    [sheet showInView:view];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[sheet rac_buttonClickedSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_rac_showSheetInView:withTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:” file is “UIActionSheet+RACSignal.h”");
        }];
    }];
}


@end
