//
//  HSYViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 08/28/2017.
//  Copyright (c) 2017 huangsongyao. All rights reserved.
//

#import "HSYViewController.h"
#import "HSYCocoaKit.h"

@interface HSYViewController ()

@end

@implementation HSYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", [NSDate nextDay]);//stringyyyyMMddHHmmssFromDateByTimestamp
    NSLog(@"%@", [NSDate stringyyyyMMddHHmmssFromDateByTimestamp:@(1503975304000)]);
    [self observerToKeyboardDidChange:nil subscribeNext:^(CGRect bounds, CGPoint begin, CGPoint end, CGRect frameBegin, CGRect frameEnd, NSNumber *curve, NSNumber *duration, NSNumber *local) {
        
    }];
    
    UITextField *textField = [NSObject createTextFiledByParam:@{
                                                                @(kHSYCocoaKitOfTextFiledPropretyTypeBorderWidth) : @(1),
                                                                @(kHSYCocoaKitOfTextFiledPropretyTypeBorderColor) : [UIColor blackColor],
                                                                }
                                       didChangeSubscribeNext:^(NSString *text) {
                                           
                                       }];
    textField.frame = CGRectMake(100, 100, 200, 60);
    [self.view addSubview:textField];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
