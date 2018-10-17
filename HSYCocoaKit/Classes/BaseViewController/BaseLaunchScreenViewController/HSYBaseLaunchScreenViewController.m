//
//  HSYBaseLaunchScreenViewController.m
//  Pods
//
//  Created by huangsongyao on 2018/4/13.
//
//

#import "HSYBaseLaunchScreenViewController.h"
#import "NSObject+UIKit.h"
#import "PublicMacroFile.h"
#import "UIApplication+Device.h"
#import "UIImageView+UrlString.h"

@interface HSYBaseLaunchScreenViewController ()

@property (nonatomic, strong) UIImageView *launchScreenImageView;
@property (nonatomic, strong, readonly) NSDictionary<NSNumber *,NSString *> *launchScreens;
@property (nonatomic, copy) NSString *urlString;

@end

@implementation HSYBaseLaunchScreenViewController

+ (instancetype)initWithLaunchScreens:(NSDictionary<NSNumber *,NSString *> *)launchScreens
                        networkSiganl:(RACSignal *)network
                       subscriberNext:(void(^)(id sendNext, id<UIApplicationDelegate> appDelegate, NSError *sendError))next
{
    HSYBaseLaunchScreenViewController *launchScreenViewController = [[HSYBaseLaunchScreenViewController alloc] initWithLaunchScreens:launchScreens];
    [network subscribeNext:^(id x) {
        if (next) {
            next(x, [UIApplication appDelegate], nil);
        }
    } error:^(NSError *error) {
        if (next) {
            next(nil, [UIApplication appDelegate], error);
        }
    }];
    return launchScreenViewController;
}

+ (instancetype)initWithRequestLaunchScreens:(NSString *)urlString
                               networkSiganl:(RACSignal *)network
                              subscriberNext:(void(^)(id sendNext, id<UIApplicationDelegate> appDelegate, NSError *sendError))next
{
    HSYBaseLaunchScreenViewController *launchScreenViewController = [[HSYBaseLaunchScreenViewController alloc] initWithLaunchScreens:@{}];
    launchScreenViewController.urlString = urlString;
    [network subscribeNext:^(id x) {
        if (next) {
            next(x, [UIApplication appDelegate], nil);
        }
    } error:^(NSError *error) {
        if (next) {
            next(nil, [UIApplication appDelegate], error);
        }
    }];
    return launchScreenViewController;
}

- (instancetype)initWithLaunchScreens:(NSDictionary<NSNumber *,NSString *> *)launchScreens
{
    if (self = [super init]) {
        _launchScreens = launchScreens;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUInteger launchScreenSize = (NSUInteger)[HSYBaseLaunchScreenViewController iPhoneDeviceScreen];
    UIImage *image = CREATE_IMG(self.launchScreens[@(launchScreenSize)]);
    self.launchScreenImageView = [[UIImageView alloc] initWithImage:image highlightedImage:image];
    self.launchScreenImageView.frame = self.view.bounds;
    if (!image) {
        [self.launchScreenImageView setImageWithUrlString:self.urlString placeholderImage:self.placeholderImage];
    }
    [self.view addSubview:self.launchScreenImageView];
    
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    return (![self.class iPhoneXDevice]);
}

+ (BOOL)iPhoneXDevice
{
    NSArray *launchScreens = @[@(kHSYCocoaKitLaunchScreenSize_5_8_Inch), @(kHSYCocoaKitLaunchScreenSize_6_1_Inch), @(kHSYCocoaKitLaunchScreenSize_6_5_Inch), ];
    kHSYCocoaKitLaunchScreenSize launchScreenSize = (kHSYCocoaKitLaunchScreenSize)IPHONE_HEIGHT_RESOLUTION_RATIO;
    BOOL iPhoneXSeries = [launchScreens containsObject:@(launchScreenSize)];
    return iPhoneXSeries;
}

+ (kHSYCocoaKitLaunchScreenSize)iPhoneDeviceScreen
{
    kHSYCocoaKitLaunchScreenSize launchScreenSize = (kHSYCocoaKitLaunchScreenSize)IPHONE_HEIGHT_RESOLUTION_RATIO;
    return launchScreenSize;
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
