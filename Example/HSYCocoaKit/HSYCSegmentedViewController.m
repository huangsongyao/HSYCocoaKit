//
//  HSYCSegmentedViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/4/25.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYCSegmentedViewController.h"
#import "HSYBViewController.h"

@interface HSYCSegmentedViewController ()

@end

@implementation HSYCSegmentedViewController

- (instancetype)init
{
    HSYBaseSegmentedPageConfig *config1 = [HSYBaseSegmentedPageConfig initWithViewControllerClassName:@"HSYViewController" viewControllerTitle:@"vc_1" paramters:@{}];
    HSYBaseSegmentedPageConfig *config2 = [HSYBaseSegmentedPageConfig initWithViewControllerClassName:@"HSYTestsViewController" viewControllerTitle:@"vc_1" paramters:@{}];
    HSYBaseSegmentedPageConfig *config3 = [HSYBaseSegmentedPageConfig initWithViewControllerClassName:@"HSYViewController" viewControllerTitle:@"vc_1" paramters:@{}];
    
    NSArray *configs = @[config1, config2, config3];
    
    if (self = [super initWithConfigs:configs]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

@implementation HSYTabBarController

- (instancetype)initWithConfigs:(NSArray<HSYBaseTabBarControllerConfig *> *)configs
{
    if (self = [super initWithConfigs:configs]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self scrollToPage:0];
    @weakify(self);
    self.hsy_responseRuntimeDelegate = ^RACSignal *(UIViewControllerRuntimeDelegateObject *object) {
        @strongify(self);
        HSYBViewController *vc = [[HSYBViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return [RACSignal empty];
    };
}


@end
