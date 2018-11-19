//
//  HSYAppDelegate.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 08/28/2017.
//  Copyright (c) 2017 huangsongyao. All rights reserved.
//

#import "HSYAppDelegate.h"
#import "HSYViewController.h"
#import "HSYViewControllerModel.h"
#import "HSYNetWorkingManager.h"
#import "JSONModel.h"
#import "NSObject+JSONModelForRuntime.h"
#import "HSYFMDBMacro.h"
#import "NSData+Encrypt.h"
#import "NSString+Regular.h"
#import "NSDecimalNumber+Computer.h"
#import "NSBundle+CFBundle.h"
#import "HSYCocoaKitWebSocketManager.h"
#import "HSYCustomScript.h"
#import "NSMapTable+KeyValue.h"

@interface dddMidel : JSONModel

@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *number;

@end

@implementation dddMidel

@end

@protocol dddMidel;
@interface tttttttMidel : JSONModel

@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSNumber<Optional> *sex;
@property (nonatomic, strong) NSArray<Optional> *array;
@property (nonatomic, strong) NSMutableArray<Optional, dddMidel> *dddMidels;
@property (nonatomic, strong) dddMidel<Optional> *dddMid;
@property (nonatomic, strong) NSDictionary<Optional> *dicdd;

@end

@implementation tttttttMidel

- (instancetype)init
{
    if (self = [super init]) {
        dddMidel *a = [[dddMidel alloc] init];
        a.title = @"dddddddddddddoooooo";
        _dddMidels = [@[a] mutableCopy];
    }
    return self;
}

@end

@interface HSYFMDBOperationManager (test)


@end

@implementation HSYFMDBOperationManager (test)

+ (NSMutableArray<NSDictionary *> *)hsy_testTableByFields
{
    NSMutableArray *params = [@[
                                @{
                                    @"User"      : FIELE_TYPE,
                                    },
                                @{
                                    @"UserId"    : FIELE_TYPE,
                                    },
                                ] mutableCopy];
    return params;
}

@end


@implementation HSYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    NSLog(@"%@", [HSYCustomScript customScript]);
    
    [[HSYNetWorkingManager shareInstance] hsy_setNetworkBaseUrl:@"http://192.168.1.12:8087/zbd-app"];
    @weakify(self);
    NSDictionary *dic = @{
                          @(kHSYCocoaKitLaunchScreenSize_3_5_Inch) : @"dobi_language_3_5",
                          @(kHSYCocoaKitLaunchScreenSize_4_0_Inch) : @"dobi_language_4_0",
                          @(kHSYCocoaKitLaunchScreenSize_4_7_Inch) : @"dobi_language_4_7",
                          @(kHSYCocoaKitLaunchScreenSize_5_5_Inch) : @"dobi_language_5_5",
                          @(kHSYCocoaKitLaunchScreenSize_5_8_Inch) : @"dobi_language_x",
                          @(kHSYCocoaKitLaunchScreenSize_6_1_Inch) : @"dobi_language_xr",
                          @(kHSYCocoaKitLaunchScreenSize_6_5_Inch) : @"dobi_language_xs_max",
                          };
    NSString *urlStr = @"http://mobile.zhubaodai.com/zbd-app/News/newsList?PAGENO=1&PRT_BLNTYP=04&RECNUM=15";
    HSYBaseLaunchScreenViewController *launchScreenViewController = [HSYBaseLaunchScreenViewController initWithLaunchScreens:dic networkSiganl:[[HSYNetWorkingManager shareInstance] test:urlStr] subscriberNext:^(id sendNext, id<UIApplicationDelegate> appDelegate, NSError *sendError) {
        @strongify(self);
        HSYViewController *vc = [[HSYViewController alloc] init];
        HSYBaseCustomNavigationController *nav = [[HSYBaseCustomNavigationController alloc] initWithRootViewController:vc params:@{@(kHSYCustomNavigationControllerParamsKeyOpenTransitionAnimation) : @(YES)}];
        self.window.rootViewController = nav;
    }];
    self.window.rootViewController = launchScreenViewController;
    [self.window makeKeyAndVisible];
    
    //test Database
    
    NSMutableArray *fields = [[HSYFMDBOperationManager hsy_createDatabaseOpeartionFieldInfoForFieldParams:[HSYFMDBOperationManager hsy_testTableByFields]] mutableCopy];
    HSYFMDBOperationFieldInfo *testTable = [HSYFMDBOperationFieldInfo hsy_createDataBaseTableForName:@"testDatabaseTable" fields:fields];
    NSMutableArray *infos = [@[
                               testTable
                               ] mutableCopy];
    [[HSYFMDBOperationManager shareInstance] createDatabase:@"databases" tableFieldInfos:infos];
    
    NSString *left = @"0.2222";
    NSString *right = @"0.0000001";
    
    NSLog(@"\n add = %@, \n subtract = %@, \n multiply = %@, \n divid = %@", [NSDecimalNumber addingDecimalNumber:@{left : right}].stringValue, [NSDecimalNumber subtractingDecimalNumber:@{left : right}], [NSDecimalNumber multiplyingDecimalNumber:@{left : right}], [NSDecimalNumber dividingDecimalNumber:@{left : right}]);
    NSLog(@"\n power = %@, powerOf10 = %@", [NSDecimalNumber powerDecimalNumber:@{@"3" : @"3"}], [NSDecimalNumber powerOf10DecimalNumber:@{@"2" : @"3"}]);
    
    
    NSString *ttttt = @"043";
    BOOL isttt = [ttttt isPointNumber:@"5"];
    NSLog(@"isttt = %d", isttt);
    
    NSDictionary *bundleDictionary = [NSBundle hsy_appBundle];
    NSLog(@"\n bundleDictionary = %@", bundleDictionary);
    
    [[[[HSYCocoaKitWebSocketManager shareInstance] hsy_webSocketConnect:@"http://dev.dobitrade.com:8001"] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitSocketRACSignal *notification) {
        [[[[HSYCocoaKitWebSocketManager shareInstance] hsy_webSocketSendPing:[HSYCocoaKitSocketRACSignal toJSONData:@{@"token" : @"fk0soekf0aw3kfwofasfma", @"channel" : @"mcc_dob", }]] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitSocketRACSignal *signalObject) {
            NSLog(@"");
        }];
    }];
    
    NSLog(@"%@", @([@"wo我" isChineseCharacters]));
    
    NSMapTable *map = [NSMapTable hsy_mapTableWithOptions:@{@(NSMapTableWeakMemory) : @(NSMapTableStrongMemory)} keyAndValues:@[@{@"key" : @"value"}]];
    NSLog(@"map = %@", map);
//    [[HSYFMDBOperationManager shareInstance] hsy_insertDataToTableName:@"testDatabaseTable" fieldParams:[HSYFMDBOperationManager hsy_testTableByFields] insertDatas:[@[@"user", @"userId"] mutableCopy] completed:^(BOOL result, HSYFMDBOperationFieldInfo *info) {
//        NSLog(@"tested success");
//    }];
    
    
//    HSYFMDBOperationFieldInfo *f1 = [HSYFMDBOperationFieldInfo hsy_createDataBaseTableForName:@"testDatabaseTable" fields:[HSYFMDBOperationFields hsy_toOperationFields:[HSYFMDBOperationManager hsy_testTableByFields]] insertDatas:[@[@"user1", @"userId1", ] mutableCopy]];
//    HSYFMDBOperationFieldInfo *f2 = [HSYFMDBOperationFieldInfo hsy_createDataBaseTableForName:@"testDatabaseTable" fields:[HSYFMDBOperationFields hsy_toOperationFields:[HSYFMDBOperationManager hsy_testTableByFields]] insertDatas:[@[@"user2", @"userId2", ] mutableCopy]];
//    [[HSYFMDBOperationManager shareInstance] hsy_beginTransactionInsertDataForOperationInfos:[@[f1, f2] mutableCopy] completed:^(BOOL result) {
//        NSLog(@"");
//    }];
    
//    [[HSYFMDBOperationManager shareInstance] hsy_deleteDataToTableName:@"testDatabaseTable" deleteValue:@"user1" whereField:@"User" completed:^(BOOL result) {
//        NSLog(@"");
//    }];
    
//    [[HSYFMDBOperationManager shareInstance] hsy_queryAllDataForTableName:@"testDatabaseTable" fieldParams:[HSYFMDBOperationManager hsy_testTableByFields] hsy_completed:^(NSMutableArray *result) {
//        NSLog(@"");
//    }];
//    
//    [[HSYFMDBOperationManager shareInstance] hsy_queryDataForTableName:@"testDatabaseTable" fieldParams:[HSYFMDBOperationManager hsy_testTableByFields] whereField:@"user" whereContent:@"user2" completed:^(NSMutableArray *result) {
//        NSLog(@"");
//    }];
    
//    [[HSYFMDBOperationManager shareInstance] hsy_modifyDataForTableName:@"testDatabaseTable" updateField:@"user" updateContent:@"测试一下" whereField:@"user" whereContent:@"user2" completed:^(BOOL result) {
//        NSLog(@"");
//    }];
    
//    [[HSYFMDBOperationManager shareInstance] hsy_cleanTableName:@"testDatabaseTable" completed:^(BOOL result) {
//        NSLog(@"");
//    }];
    
    
    NSString *jia = [NSData AES128EncryptString:@"zy1047539560" forKey:@"TESTPASSWORD" offsetIv:@"AES00IVPARAMETER"];
    NSString *jie = [NSData AES128DecryptString:jia forKey:@"TESTPASSWORD" offsetIv:@"AES00IVPARAMETER"];
    NSLog(@"jia = %@, jie = %@", jia, jie);
    
    //test JSONModel Rumtime
    tttttttMidel *tes = [[tttttttMidel alloc] init];
    [tes setJSONModelRuntimeNullValue];
    NSLog(@"");
    
    // Override point for customization after application launch.
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    UIInterfaceOrientationMask orientationMask = (UIInterfaceOrientationMask)[self.hsy_landscapeDirection integerValue];
    if (orientationMask == 0) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return orientationMask;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
