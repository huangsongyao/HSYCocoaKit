//
//  HSYViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 08/28/2017.
//  Copyright (c) 2017 huangsongyao. All rights reserved.
//

#import "HSYViewController.h"
#import "HSYViewControllerModel.h"



@interface TestModel : NSObject

@property (nonatomic, strong) NSString *test_1;
@property (nonatomic, strong) NSNumber *test_2;
@property (nonatomic, strong) NSDictionary *test_3;
@property (nonatomic, strong) NSString *test_4;
@property (nonatomic, strong) NSString *yyyy;

@end

@implementation TestModel


@end

@interface HSYViewController ()

@property (nonatomic, strong) HSYViewControllerModel *viewModel;

@end

@implementation HSYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewModel = [[HSYViewControllerModel alloc] init];
    
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
    
    TestModel *test = [TestModel new];
    test.test_1 = @"hehehe";
    test.test_2 = @(100);
    test.test_3 = @{@"1" : @"1"};
    
    NSDictionary *iccc = @{
                           @"test_1" : @"66",
                           @"test_2" : @(111),
                           };
    
    id object = [NSObject objectRuntimeValues:iccc classes:[TestModel class]];
    NSMutableDictionary *dic = [test toRuntimeMutableDictionary];
    NSLog(@"dic = %@", dic);
    
    [RACSignal rac_startClockwiseTimer:1.0f subscribeNext:^BOOL(NSDate *date, CGFloat count) {
        NSLog(@"date = %@ \n count = %f", date, count);
        return (count >= 10.0f);
    }];
    
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
