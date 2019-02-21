//
//  UIAlertController+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "UIAlertController+RACSignal.h"
#import "NSObject+Property.h"

static NSString *kHSYCocoaKitTupleTagKey        = @"HSYCocoaKitTupleTagKey";

@implementation UIAlertAction (Tag)

- (RACTuple *)hsy_alertActionTuple
{
    return [self getPropertyForKey:kHSYCocoaKitTupleTagKey];
}

- (void)setHsy_alertActionTuple:(RACTuple *)hsy_alertActionTuple
{
    [self setProperty:hsy_alertActionTuple forKey:kHSYCocoaKitTupleTagKey nonatomic:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

@end

@implementation UIAlertController (RACSignal)

#pragma mark - Alert

+ (RACSignal *)hsy_rac_showAlertController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message alertActions:(NSArray<NSDictionary *> *)alertActions
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSDictionary *dic in alertActions) {
            NSString *title = dic.allKeys.firstObject;
            UIAlertActionStyle style = (UIAlertActionStyle)[dic.allValues.firstObject integerValue];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendNext:action];
                [subscriber sendCompleted];
            }];
            action.hsy_alertActionTuple = RACTuplePack(@([alertActions indexOfObject:dic]));
            [alertController addAction:action];
        }
        @weakify(alertController);
        [viewController presentViewController:alertController animated:YES completion:^{}];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_rac_showAlertController:title:message:alertActions:”");
        }];
    }];
}

+ (NSMutableArray *)hsy_rac_alertActions:(NSArray<NSString *> *)alertActionTitles
{
    NSMutableArray *alertActions = [NSMutableArray arrayWithCapacity:alertActionTitles.count];
    for (NSString *string in alertActionTitles) {
        [alertActions addObject:@{[string mutableCopy] : @([alertActionTitles indexOfObject:string] == 0 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault)}];
    }
    return alertActions;
}

+ (RACSignal *)hsy_rac_showAlertController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)alertActionTitles
{
    NSMutableArray *alertActions = [UIAlertController hsy_rac_alertActions:alertActionTitles];
    return [self.class hsy_rac_showAlertController:viewController title:title message:message alertActions:alertActions];
}

#pragma mark - Sheet

+ (RACSignal *)hsy_rac_showSheetController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sheetActions:(NSArray<NSDictionary *> *)sheetActions
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSDictionary *dic in sheetActions) {
            NSString *title = dic.allKeys.firstObject;
            UIAlertActionStyle style = (UIAlertActionStyle)[dic.allValues.firstObject integerValue];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendNext:action];
                [subscriber sendCompleted];
            }];
            action.hsy_alertActionTuple = RACTuplePack(@([sheetActions indexOfObject:dic]));
            [sheetController addAction:action];
        }
        @weakify(sheetController);
        [viewController presentViewController:sheetController animated:YES completion:^{}];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_rac_showSheetController:title:message:alertActions:”");
        }];
    }];
}

+ (NSMutableArray *)hsy_rac_sheetActions:(NSArray<NSString *> *)sheetActionTitles
{
    NSMutableArray *sheetActions = [NSMutableArray arrayWithCapacity:sheetActionTitles.count];
    for (NSString *string in sheetActionTitles) {
        [sheetActions addObject:@{[string mutableCopy] : @([sheetActionTitles indexOfObject:string] == 0 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault)}];
    }
    return sheetActions;
}

+ (RACSignal *)hsy_rac_showSheetController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)sheetActionTitles
{
    NSMutableArray *alertActions = [UIAlertController hsy_rac_sheetActions:sheetActionTitles];
    return [self.class hsy_rac_showSheetController:viewController title:title message:message sheetActions:alertActions];
}


@end
