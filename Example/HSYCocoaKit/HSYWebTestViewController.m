
//
//  HSYWebTestViewController.m
//  HSYCocoaKit_Example
//
//  Created by huangsongyao on 2018/8/21.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYWebTestViewController.h"
#import "HSYBaseWebModel.h"
#import "NSFileManager+Finder.h"
#import "HSYBaseViewController+CustomNavigationItem.h"
#import "HSYAppDelegate.h"
#import "UIViewController+Alert.h"

@interface HSYWebTestViewController ()

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat pix;
@property (nonatomic, assign) CGFloat piy;

@end

@implementation HSYWebTestViewController

- (void)viewDidLoad {
    
//    NSString *path = [NSFileManager finderFileFromName:@"index" fileType:@"html"];
    self.hsy_viewModel = [[HSYBaseWebModel alloc] initWithContent:@"http://192.168.20.24:3000" loadType:kHSYCocoaKitWKWebViewLoadTypeRequest runNativeNames:@[]];
    [super viewDidLoad];
    
    self.webView.hidden = YES;
//    @weakify(self);
//    [self.hsy_viewModel.subject subscribeNext:^(HSYCocoaKitRACSubscribeNotification *notification) {
//        @strongify(self);
//        if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypeDidFinished) {
//            [self hsy_rightItemsImages:@[@{@(kHSYCocoaKitDefaultCustomBarItemTag) : @"nav_back@2x"}] subscribeNext:^(UIButton *button, NSInteger tag) {
//                NSString *jsStr = [NSString stringWithFormat:@"store.fullScreen('%@')", @"测试一下native调用JavaScript"];
//                [[[self hsy_nativeRunJavaScriptFunction:jsStr] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//                    NSLog(@"\n result = %@", x);
//                }];
//                HSYAppDelegate *appDelegate = (HSYAppDelegate *)[UIApplication appDelegate];
//                button.selected = !button.selected;
//                [appDelegate landscapeDirection:button.selected];
//                self.customNavigationBar.width = IPHONE_WIDTH;
//                CGRect rect = CGRectMake(0, self.customNavigationBar.bottom, IPHONE_WIDTH, IPHONE_HEIGHT - self.customNavigationBar.bottom);
//                self.webView.frame = rect;
//            }];
//
//        } else if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNativeForAlert) {
//            [[[UIViewController hsy_rac_showAlertViewController:self title:@"测试" message:notification.subscribeContents.firstObject alertActionTitles:@[@"确定"]] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//            }];
//        }
//    }];
    
    [(HSYBaseCustomNavigationController *)self.navigationController setBanTransition:YES];
    
    CATransform3D c1t = CATransform3DIdentity;
    CALayer *cube1 = [self cubeWithTransform:c1t];
    self.layer = cube1;
    [self.view.layer addSublayer:cube1];
    
    // Do any additional setup after loading the view.
}

- (CALayer *)faceWithTransform:(CATransform3D)transform color:(UIColor*)color
{
    CALayer *face = [CALayer layer];
//    face.frame = CGRectMake(100, 100, 100, 100);
    face.frame = CGRectMake(-50, -50, 100, 100);
    face.backgroundColor = color.CGColor;
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    //容器
    CATransformLayer *cube = [CATransformLayer layer];
    
    CGFloat location = 50;
    //前
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, location);
//    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor redColor]]];
    
    //右
    ct = CATransform3DMakeTranslation(location, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor yellowColor]]];
    
    //上
    ct = CATransform3DMakeTranslation(0, -location, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor blueColor]]];
    
    //下
    ct = CATransform3DMakeTranslation(0, location, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor brownColor]]];
    
    //左
    ct = CATransform3DMakeTranslation(-location, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor greenColor]]];
    
    //后
    ct = CATransform3DMakeTranslation(0, 0, -location);
//    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor orangeColor]]];
    
    //
    CGSize containerSize = self.view.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0,
                                containerSize.height / 2.0);
    
    cube.transform = transform;
    return cube;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.startPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    CGFloat deltaX = self.startPoint.x - currentPosition.x;
    CGFloat deltaY = self.startPoint.y - currentPosition.y;
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DRotate(c1t, self.pix + M_PI_2 * deltaY / 100, 1, 0, 0);
    c1t = CATransform3DRotate(c1t, self.piy - M_PI_2 * deltaX / 100, 0, 1, 0);
    self.layer.transform = c1t;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    CGFloat deltaX = self.startPoint.x - currentPosition.x;
    CGFloat deltaY = self.startPoint.y - currentPosition.y;
    self.pix = M_PI_2 * deltaY / 100;
    self.piy = -M_PI_2 * deltaX / 100;
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
