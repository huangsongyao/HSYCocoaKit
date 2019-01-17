//
//  UIViewController+SystemShare.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2019/1/17.
//

#import "UIViewController+SystemShare.h"
#import "ReactiveCocoa.h"

@implementation UIViewController (SystemShare)

+ (UIActivityViewController *)defaultSystemShareViewController:(NSArray *)shareItems applicationActivities:(NSArray<UIActivity *> *)activitis shareCompleted:(RACSignal *(^)(BOOL shared, UIActivityType activityType, NSError *activityError))shareCompleted
{
    UIActivityViewController *shareViewController = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:activitis];
    @weakify(shareViewController);
    UIActivityViewControllerCompletionWithItemsHandler itemsHandler = ^(UIActivityType activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        @strongify(shareViewController);
        //shareCompleted block必须实现，不能为nil
        RACSignal *signal = shareCompleted(completed, activityType, activityError);
        [[signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^{
            @strongify(shareViewController);
            [shareViewController dismissViewControllerAnimated:YES completion:nil];
        }];
    };
    shareViewController.completionWithItemsHandler = itemsHandler;
    return shareViewController;
}

- (void)hsy_systemShare:(NSArray *)shareItems shareResult:(RACSignal *(^)(BOOL shared, UIActivityType activityType, NSError *activityError))result
{
    UIActivityViewController *viewController = [self.class defaultSystemShareViewController:shareItems applicationActivities:nil shareCompleted:result];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)hsy_systemShare:(NSArray *)shareItems applicationActivities:(NSArray<UIActivity *> *)activitis shareResult:(RACSignal *(^)(BOOL shared, UIActivityType activityType, NSError *activityError))result
{
    UIActivityViewController *viewController = [self.class defaultSystemShareViewController:shareItems applicationActivities:activitis shareCompleted:result];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
