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


@implementation HSYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [[HSYNetWorkingManager shareInstance] hsy_setNetworkBaseUrl:@"http://192.168.1.12:8087/zbd-app"];
    @weakify(self);
    NSDictionary *dic = @{
                          @(kHSYCocoaKitLaunchScreenSize_3_5_Inch) : @"i4_sp",
                          @(kHSYCocoaKitLaunchScreenSize_4_0_Inch) : @"i5_sp",
                          @(kHSYCocoaKitLaunchScreenSize_4_7_Inch) : @"i6_sp",
                          @(kHSYCocoaKitLaunchScreenSize_5_5_Inch) : @"i6p_sp",
                          @(kHSYCocoaKitLaunchScreenSize_5_8_Inch) : @"iX_sp",
                          };
    NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
    HSYBaseLaunchScreenViewController *launchScreenViewController = [HSYBaseLaunchScreenViewController initWithLaunchScreens:dic networkSiganl:[[HSYNetWorkingManager shareInstance] test:urlStr] subscriberNext:^(id sendNext, id<UIApplicationDelegate> appDelegate, NSError *sendError) {
        @strongify(self);
        HSYViewController *vc = [[HSYViewController alloc] init];
        HSYBaseCustomNavigationController *nav = [[HSYBaseCustomNavigationController alloc] initWithRootViewController:vc params:@{@(kHSYCustomNavigationControllerParamsKeyOpenTransitionAnimation) : @(YES)}];
        self.window.rootViewController = nav;
    }];
    self.window.rootViewController = launchScreenViewController;
    [self.window makeKeyAndVisible];
    
    
    //test
    tttttttMidel *tes = [[tttttttMidel alloc] init];
    [tes setJSONModelRuntimeNullValue];
    NSLog(@"");
    
    // Override point for customization after application launch.
    return YES;
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
