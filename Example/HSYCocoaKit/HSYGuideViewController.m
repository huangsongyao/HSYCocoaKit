//
//  HSYGuideViewController.m
//  HSYCocoaKit_Example
//
//  Created by huangsongyao on 2018/7/11.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYGuideViewController.h"
#import "HSYCustomGuideView.h"

@interface HSYGuideViewController ()

@end

@implementation HSYGuideViewController

+ (void)test
{
    HSYGuideViewController *vc = [[HSYGuideViewController alloc] init];
    HSYCustomGuideView *view = [HSYCustomGuideView hsy_appGuides:@[@"i4_sp", @"i5_sp", @"i6_sp", @"iX_sp", ] rootViewController:vc scrollPage:^(HSYCustomGuideView *guide, NSInteger currentPage) {
        NSLog(@"page = %@", @(currentPage));
    } completed:^(HSYCustomGuideView *guide, BOOL finished) {
        
    }];
    [vc.view addSubview:view];
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
