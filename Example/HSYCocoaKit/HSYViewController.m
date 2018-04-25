//
//  HSYViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 08/28/2017.
//  Copyright (c) 2017 huangsongyao. All rights reserved.
//

#import "HSYViewController.h"
#import "HSYViewControllerModel.h"
#import "HSYBViewController.h"
#import "NSObject+UIKit.h"
#import "UIViewController+Device.h"
#import "UIViewController+Alert.h"
#import "HSYBaseSegmentedPageControl.h"

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

@end

@implementation HSYViewController

- (void)viewDidLoad
{
    self.hsy_viewModel = [[HSYViewControllerModel alloc] init];
    [super viewDidLoad];
    @weakify(self);
//    [self.viewModel.subject subscribeNext:^(HSYCocoaKitRACSubscribeNotification *notification) {
//        @strongify(self);
//        NSLog(@"j_model = %@", [(HSYViewControllerModel *)self.viewModel j_model]);
//        NSLog(@"%lu", (unsigned long)notification.subscribeType);
//    }];
//    
//    NSLog(@"%@", [NSDate nextDay]);//stringyyyyMMddHHmmssFromDateByTimestamp
//    NSLog(@"%@", [NSDate stringyyyyMMddHHmmssFromDateByTimestamp:@(1503975304000)]);
//    [self observerToKeyboardDidChange:nil subscribeNext:^(CGRect bounds, CGPoint begin, CGPoint end, CGRect frameBegin, CGRect frameEnd, NSNumber *curve, NSNumber *duration, NSNumber *local) {
//        
//    }];
    
    
    UIButton *button = [NSObject createButtonByParam:@{} clickedOnSubscribeNext:^(UIButton *button) {
        @strongify(self);
        HSYBViewController *bvc = [[HSYBViewController alloc] init];
        [self.navigationController pushViewController:bvc animated:YES];
//        [[self hsy_rac_openEditingSystemVideos] subscribeNext:^(id x) {
//            NSLog(@"33333");
//        } completed:^{
//            NSLog(@"00000");
//        }];
    }];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 300, 60, 56);
    [self.view addSubview:button];
    
    HSYBaseSegmentedPageControl *control = [HSYBaseSegmentedPageControl hsy_showSegmentedPageControlFrame:CGRectMake(0, button.bottom + 100, IPHONE_WIDTH, 64) paramters:@{@(kHSYCocoaKitCustomSegmentedTypeButtonSize) : [NSValue valueWithCGSize:CGSizeMake(75, 64)]} pageControls:@[@"123", @"456", @"789", @"101112", @"444", @"5555", @"66666", @"7777777"] selectedBlock:^(HSYBaseCustomButton *button, NSInteger index) {
        
    }];
    [self.view addSubview:control];
//    UITextField *textField = [NSObject createTextFiledByParam:@{
//                                                                @(kHSYCocoaKitOfTextFiledPropretyTypeBorderWidth) : @(1),
//                                                                @(kHSYCocoaKitOfTextFiledPropretyTypeBorderColor) : [UIColor blackColor],
//                                                                }
//                                       didChangeSubscribeNext:^(NSString *text) {
//                                           
//                                       }];
//    textField.frame = CGRectMake(100, 100, 200, 60);
//    [self.view addSubview:textField];
//    
//    TestModel *test = [TestModel new];
//    test.test_1 = @"hehehe";
//    test.test_2 = @(100);
//    test.test_3 = @{@"1" : @"1"};
//    
//    NSDictionary *iccc = @{
//                           @"test_1" : @"66",
//                           @"test_2" : @(111),
//                           };
//    
//    id object = [NSObject objectRuntimeValues:iccc classes:[TestModel class]];
//    NSLog(@"id - object = %@", object);
//    NSMutableDictionary *dic = [test toRuntimeMutableDictionary];
//    NSLog(@"dic = %@", dic);
//    
//    [RACSignal rac_startClockwiseTimer:1.0f subscribeNext:^BOOL(NSDate *date, CGFloat count) {
//        NSLog(@"date = %@ \n count = %f", date, count);
//        return (count >= 10.0f);
//    }];
    
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
