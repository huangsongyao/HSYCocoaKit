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

@interface HSYBaseLaunchScreenViewController ()

@property (nonatomic, strong) UIImageView *launchScreenImageView;
@property (nonatomic, strong, readonly) NSDictionary<NSNumber *,NSString *> *launchScreens;

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


- (instancetype)initWithLaunchScreens:(NSDictionary<NSNumber *,NSString *> *)launchScreens
{
    if (self = [super init]) {
        _launchScreens = launchScreens;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.launchScreens != nil, @"必须含有launchScreens的入参");
    kHSYCocoaKitLaunchScreenSize launchScreenSize = (kHSYCocoaKitLaunchScreenSize)IPHONE_HEIGHT;
    UIImage *image = [UIImage imageNamed:self.launchScreens[@(launchScreenSize)]];
    self.launchScreenImageView = [[UIImageView alloc] initWithImage:image highlightedImage:image];
    self.launchScreenImageView.frame = self.view.bounds;
    [self.view addSubview:self.launchScreenImageView];
    
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    kHSYCocoaKitLaunchScreenSize launchScreenSize = (kHSYCocoaKitLaunchScreenSize)IPHONE_HEIGHT;
    return (launchScreenSize != kHSYCocoaKitLaunchScreenSize_5_8_Inch);
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
