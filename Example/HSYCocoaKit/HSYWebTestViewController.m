
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

@interface HSYWebTestViewController ()

@end

@implementation HSYWebTestViewController

- (void)viewDidLoad {
    
    NSString *path = [NSFileManager finderFileFromName:@"index" fileType:@"html"];
    self.hsy_viewModel = [[HSYBaseWebModel alloc] initWithContent:path loadType:kHSYCocoaKitWKWebViewLoadTypeFilePath runNativeNames:@[@"Location"]];
    [super viewDidLoad];
    
    @weakify(self);
    [self.hsy_viewModel.subject subscribeNext:^(HSYCocoaKitRACSubscribeNotification *notification) {
        if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypeDidFinished) {
            @strongify(self);
            NSString *jsStr = @"alert('1111')"; //[NSString stringWithFormat:@"store.fullScreen('%@')", @"测试一下native调用JavaScript"];
            [[[self hsy_nativeRunJavaScriptFunction:jsStr] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
                NSLog(@"\n result = %@", x);
            }];
        } else if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNativeForAlert) {
            
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
