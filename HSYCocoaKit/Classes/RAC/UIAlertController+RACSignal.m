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

+ (RACSignal *)rac_showAlertController:(NSString *)title message:(NSString *)message alertActions:(NSArray<NSDictionary *> *)alertActions
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSDictionary *dic  in alertActions) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:dic.allValues.firstObject style:((UIAlertActionStyle)[dic.allKeys.firstObject integerValue]) handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendNext:action];
                [subscriber sendCompleted];
            }];
            [alertController addAction:action];
        }
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

+ (RACSignal *)rac_showAlertController:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)alertActionTitles
{
    NSMutableArray *alertActions = [NSMutableArray arrayWithCapacity:alertActionTitles.count];
    for (NSString *string in alertActionTitles) {
        [alertActions addObject:@{[string mutableCopy] : @([alertActionTitles indexOfObject:string] == 0 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault)}];
    }
    return [self.class rac_showAlertController:title message:message alertActions:alertActions];
}

#pragma mark - Sheet

+ (RACSignal *)rac_showSheetController:(NSString *)title message:(NSString *)message sheetActions:(NSArray<NSDictionary *> *)sheetActions
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSDictionary *dic  in sheetActions) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:dic.allValues.firstObject style:((UIAlertActionStyle)[dic.allKeys.firstObject integerValue]) handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendNext:action];
                [subscriber sendCompleted];
            }];
            [sheetController addAction:action];
        }
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

+ (RACSignal *)rac_showSheetController:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)sheetActionTitles
{
    NSMutableArray *alertActions = [NSMutableArray arrayWithCapacity:sheetActionTitles.count];
    for (NSString *string in sheetActionTitles) {
        [alertActions addObject:@{[string mutableCopy] : @([sheetActionTitles indexOfObject:string] == 0 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault)}];
    }
    return [self.class rac_showSheetController:title message:message sheetActions:alertActions];
}


@end
