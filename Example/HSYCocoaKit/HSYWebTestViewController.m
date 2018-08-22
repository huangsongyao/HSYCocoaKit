
//
//  HSYWebTestViewController.m
//  HSYCocoaKit_Example
//
//  Created by huangsongyao on 2018/8/21.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYWebTestViewController.h"
#import "HSYBaseWebModel.h"
#import "NSFileManager+Finder.h"
#import "HSYBaseViewController+CustomNavigationItem.h"
#import "HSYAppDelegate.h"
#import "UIViewController+Alert.h"

@interface HSYWebTestViewController ()

@end

@implementation HSYWebTestViewController

- (void)viewDidLoad {
    
//    NSString *path = [NSFileManager finderFileFromName:@"index" fileType:@"html"];
    self.hsy_viewModel = [[HSYBaseWebModel alloc] initWithContent:@"http://192.168.20.24:3000" loadType:kHSYCocoaKitWKWebViewLoadTypeRequest runNativeNames:@[]];
    [super viewDidLoad];
    
    @weakify(self);
    [self.hsy_viewModel.subject subscribeNext:^(HSYCocoaKitRACSubscribeNotification *notification) {
        @strongify(self);
        if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypeDidFinished) {
            [self hsy_rightItemsImages:@[@{@(kHSYCocoaKitDefaultCustomBarItemTag) : @"nav_back@2x"}] subscribeNext:^(UIButton *button, NSInteger tag) {
                NSString *jsStr = [NSString stringWithFormat:@"store.fullScreen('%@')", @"测试一下native调用JavaScript"];
                [[[self hsy_nativeRunJavaScriptFunction:jsStr] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
                    NSLog(@"\n result = %@", x);
                }];
                HSYAppDelegate *appDelegate = (HSYAppDelegate *)[UIApplication appDelegate];
                button.selected = !button.selected;
                [appDelegate landscapeDirection:button.selected];
                self.customNavigationBar.width = IPHONE_WIDTH;
                CGRect rect = CGRectMake(0, self.customNavigationBar.bottom, IPHONE_WIDTH, IPHONE_HEIGHT - self.customNavigationBar.bottom);
                self.webView.frame = rect;
            }];
            
        } else if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNativeForAlert) {
            [[[UIViewController hsy_rac_showAlertViewController:self title:@"测试" message:notification.subscribeContents.firstObject alertActionTitles:@[@"确定"]] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            }];
        }
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
