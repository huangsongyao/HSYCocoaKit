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
#import "HSYCSegmentedViewController.h"
#import "NSMutableArray+BasicAlgorithm.h"
#import "CXAMCPersonalViewController.h"
#import "UIViewController+Alert.h"
#import "CIDetector+QRCode.h"
#import "UIApplication+Device.h"
#import "HSYCocoaKitAttributedLabelManager.h"
#import "TYAttributedLabel.h"
#import "HSYWebTestViewController.h"
#import "UIApplication+OpenURL.h"
#import "HSYCocoaKitCoreGraphicsManager.h"
#import "NSString+Replace.h"

HSYCocoaKitPropertyKey const HSYCocoaKitPropertyKeyNorBackgroundImage = @"3333";

@interface HSYView : UIView

@end

@implementation HSYView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [HSYCocoaKitCoreGraphicsManager hsy_contextRefGraphicsCircular:[UIColor greenColor] circularCGRect:self.bounds];
}

@end

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
//    NSString *tstring = HSYCocoaKitButtonNorBackgroundImage;
    NSLog(@"%@", HSYCocoaKitPropertyKeyNorBackgroundImage);
//    [UIViewController hsy_rac_showAlertViewController:self title:@"tttt" message:@"77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777" alertActionTitles:@[]]
    
//    NSMutableArray *array = [@[@10, @2, @13, @48, @5] mutableCopy];
//    
//    NSMutableArray *art = [@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"] mutableCopy];
//    NSLog(@"%@", [art elementClassify:5]);
//    
//    [array bubbleAscendingOrderSort];
//    NSLog(@"\n %@", array);
//    
//    [array bubbleDescendingOrderSort];
//    NSLog(@"\n %@", array);
    
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
        HSYCSegmentedViewController *vc = [[HSYCSegmentedViewController alloc] init];
//        HSYBViewController *vc = [[HSYBViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//        [[self hsy_rac_openEditingSystemVideos] subscribeNext:^(id x) {
//            NSLog(@"33333");
//        } completed:^{
//            NSLog(@"00000");
//        }];
    }];
    button.backgroundColor = RANDOM_RGB;
    button.frame = CGRectMake(100, 300, 60, 56);
    [self.view addSubview:button];
    
    UIButton *button1 = [NSObject createButtonByParam:@{} clickedOnSubscribeNext:^(UIButton *button) {
        @strongify(self);
//        HSYBViewController *vc = [[HSYBViewController alloc] init];
        UIColor *color = HexColorString(@"6F6F6F");
        UIColor *highColor = HexColorString(@"CA4526");
        HSYBaseTabBarControllerConfig *config1 = [HSYBaseTabBarControllerConfig initWithViewControllerClassName:@"HSYDViewController" viewControllerTitle:@"首页" paramters:@{} titleColorParamter:@{color : highColor} imageParamter:@{@"tab_icon_home_default" : @"tab_icon_home_new_selected"} fontParamter:@{UI_SYSTEM_FONT_11 : UI_SYSTEM_FONT_11}];
        config1.showNavigationBar = NO;
        
        HSYBaseTabBarControllerConfig *config2 = [HSYBaseTabBarControllerConfig initWithViewControllerClassName:@"HSYCViewController" viewControllerTitle:@"投资" paramters:@{} titleColorParamter:@{color : highColor} imageParamter:@{@"tab_icon_invest_default" : @"tab_icon_invest_new_selected"} fontParamter:@{UI_SYSTEM_FONT_11 : UI_SYSTEM_FONT_11}];
        config2.showNavigationBar = NO;
        
        HSYBaseTabBarControllerConfig *config3 = [HSYBaseTabBarControllerConfig initWithViewControllerClassName:@"CXAMCPersonalViewController" viewControllerTitle:@"我的" paramters:@{} titleColorParamter:@{color : highColor} imageParamter:@{@"tab_icon_mine_default" : @"tab_icon_mine_new_selected"} fontParamter:@{UI_SYSTEM_FONT_11 : UI_SYSTEM_FONT_11}];
        config3.showNavigationBar = NO;
        
        HSYBaseTabBarControllerConfig *config4 = [HSYBaseTabBarControllerConfig initWithViewControllerClassName:@"HSYTestsViewController" viewControllerTitle:@"更多" paramters:@{} titleColorParamter:@{color : highColor} imageParamter:@{@"tab_icon_search_default" : @"tab_icon_search_new_selected"} fontParamter:@{UI_SYSTEM_FONT_11 : UI_SYSTEM_FONT_11}];
        NSMutableArray *configs = [@[config1, config2, config3, config4] mutableCopy];
        HSYTabBarController *vc = [[HSYTabBarController alloc] initWithConfigs:configs];
        
        [vc hsy_setRedPointInPage:0 redPointNumbers:@(1)];          //显示1
        [vc hsy_setRedPointInPage:1 redPointNumbers:@(78)];         //显示79
        [vc hsy_setRedPointInPage:2 redPointNumbers:@(12222)];      //显示+99
        [vc hsy_setRedPointInPage:3 redPointNumbers:@(-1)];         //只显示红点不显示数字
//        [vc hsy_setRedPointInPage:1 redPointNumbers:@(0)];          //不显示红点
        [self.navigationController pushViewController:vc animated:YES];
        //        [[self hsy_rac_openEditingSystemVideos] subscribeNext:^(id x) {
        //            NSLog(@"33333");
        //        } completed:^{
        //            NSLog(@"00000");
        //        }];
    }];
    button1.backgroundColor = RANDOM_RGB;
    button1.frame = CGRectMake(button.right + 50, 300, 60, 56);
    [self.view addSubview:button1];
    
    UIButton *button2 = [NSObject createButtonByParam:@{} clickedOnSubscribeNext:^(UIButton *button) {
//        @strongify(self);
        
//        HSYBViewController *vc = [[HSYBViewController alloc] init];
        HSYWebTestViewController *vc = [[HSYWebTestViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//        [UIApplication openSafariServer:@"https://www.baidu.com/"];
//        [UIApplication openSafari:@"https://www.baidu.com/"];
    }];
    button2.backgroundColor = RANDOM_RGB;
    button2.frame = CGRectMake(button.right, button.bottom + 50, 60, 56);
    [self.view addSubview:button2];
    
    HSYBaseSegmentedPageControl *control = [HSYBaseSegmentedPageControl hsy_showSegmentedPageControlFrame:CGRectMake(0, button.bottom + 100, IPHONE_WIDTH, 64) paramters:@{@(kHSYCocoaKitCustomSegmentedTypeButtonSize) : [NSValue valueWithCGSize:CGSizeMake(75, 64)], @(kHSYCocoaKitCustomSegmentedTypeButtonSpacing) : @(15.0f)} pageControls:@[@"123", @"456", @"789", @"101112", @"444", @"5555", @"66666", @"7777777"] selectedBlock:^(HSYBaseCustomButton *button, NSInteger index) {
    }];
    [self.view addSubview:control];
    
    UIImage *image = [CIDetector filterHighQrCodeImage:@"8iiiifff" withImageSize:100];
    NSLog(@"image = %@", image);
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
    
    NSMutableArray *arrays = [[NSMutableArray alloc] init];
    NSArray *imgs = @[@"user_logo", @"mine_icon_safe", @"mine_icon_personal", @"tab_icon_invest_new_selected", ];
    for (NSInteger i = 0; i < imgs.count; i ++) {
        UIImage *img = CREATE_IMG(imgs[i]);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
        imageView.size = img.size;
        [arrays addObject:imageView];
    }
    TYAttributedLabel *testLabel = [HSYCocoaKitAttributedLabelManager hsy_baseAttributedLabel:@{@"text" : @"哦【222】啊额IE附近偶【222】尔设计费我偶尔接佛奥【222】杰佛我激将法，奇偶飞机饿哦附近解耦我奇偶诶积分，奇偶覅杰【222】佛金额，，空间丰富", @"linesSpacing" : @(1), @"font" : UI_SYSTEM_FONT_16, } locationSymbolParamter:@{@"【222】" : [arrays mutableCopy]} displayWidth:IPHONE_WIDTH];
    testLabel.origin = CGPointMake(0.0f, self.customNavigationBar.bottom + 20);
    [self.view addSubview:testLabel];
    
    @weakify(testLabel);
    [[RACScheduler mainThreadScheduler] afterDelay:1.0f schedule:^{
        @strongify(testLabel);
        [testLabel reloadEmojisAttributed:@"呵呵呵法尔范后IEof[微笑]就，奇偶覅额外金佛文件而非，奇偶纪委负欧文，肥胖纹佛而非。叫哦我IE金佛我几分，佛[调皮]文件佛寺杰尔夫，解耦[抓狂]我降温哦附件为。"];
    }];
    
//    HSYView *hsyView = [[HSYView alloc] initWithFrame:CGRectMake(100, 500, 100, 100)];
//    hsyView.backgroundColor = CLEAR_COLOR;
//    [self.view addSubview:hsyView];
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
