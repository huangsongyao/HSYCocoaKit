//
//  UIAlertController+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "UIAlertController+RACSignal.h"

@implementation UIAlertController (RACSignal)

#pragma mark - Alert

+ (RACSignal *)hsy_rac_showAlertController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message alertActions:(NSArray<NSDictionary *> *)alertActions
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSDictionary *dic  in alertActions) {
            NSString *title = dic.allKeys.firstObject;
            UIAlertActionStyle style = (UIAlertActionStyle)[dic.allValues.firstObject integerValue];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendNext:action];
                [subscriber sendCompleted];
            }];
            [alertController addAction:action];
        }
        [viewController presentViewController:alertController animated:YES completion:^{}];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

+ (RACSignal *)hsy_rac_showAlertController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)alertActionTitles
{
    NSMutableArray *alertActions = [NSMutableArray arrayWithCapacity:alertActionTitles.count];
    for (NSString *string in alertActionTitles) {
        [alertActions addObject:@{[string mutableCopy] : @([alertActionTitles indexOfObject:string] == 0 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault)}];
    }
    return [self.class hsy_rac_showAlertController:viewController title:title message:message alertActions:alertActions];
}

#pragma mark - Sheet

+ (RACSignal *)hsy_rac_showSheetController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sheetActions:(NSArray<NSDictionary *> *)sheetActions
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSDictionary *dic  in sheetActions) {
            NSString *title = dic.allKeys.firstObject;
            UIAlertActionStyle style = (UIAlertActionStyle)[dic.allValues.firstObject integerValue];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendNext:action];
                [subscriber sendCompleted];
            }];
            [sheetController addAction:action];
            [viewController presentViewController:sheetController animated:YES completion:^{}];
        }
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

+ (RACSignal *)hsy_rac_showSheetController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)sheetActionTitles
{
    NSMutableArray *alertActions = [NSMutableArray arrayWithCapacity:sheetActionTitles.count];
    for (NSString *string in sheetActionTitles) {
        [alertActions addObject:@{[string mutableCopy] : @([sheetActionTitles indexOfObject:string] == 0 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault)}];
    }
    return [self.class hsy_rac_showSheetController:viewController title:title message:message sheetActions:alertActions];
}


@end
