//
//  HSYCustomGuideView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//  

/*
 用法如下
 + (void)test
 {
 UIViewController *vc = [[UIViewController alloc] init];
 HSYCustomGuideView *view = [HSYCustomGuideView hsy_appGuides:@[@"i4_sp", @"i5_sp", @"i6_sp", @"iX_sp", ] rootViewController:vc scrollPage:^(HSYCustomGuideView *guide, NSInteger currentPage) {
 NSLog(@"page = %@", @(currentPage));
 } completed:^(HSYCustomGuideView *guide, BOOL finished) {
 
 }];
 [vc.view addSubview:view];
 }

 */

#import <UIKit/UIKit.h>

@interface HSYCustomGuideView : UIView

@property (nonatomic, strong, readonly) UIScrollView *hsy_scrollView;
@property (nonatomic, strong, readonly) UIWindow *hsy_window;
@property (nonatomic, copy) void(^hsy_guideScrollCompleted)(HSYCustomGuideView *guide, BOOL finished);
@property (nonatomic, copy) void(^hsy_scrollPage)(HSYCustomGuideView *guide, NSInteger currentPage);
- (void)hsy_guideFaceOut;

@end

@interface HSYCustomGuideView (Show)

/**
 快速方法1，默认滚动后自动执行“- hsy_guideFaceOut”方法

 @param guides 翻页图片的图片名称集合
 @param rootViewController 根视图控制器
 @param page 每次翻页结束后，通过page返回事件
 @param completed 滚动结束后移除时的监听回调
 @return HSYCustomGuideView
 */
+ (HSYCustomGuideView *)hsy_appGuides:(NSArray<UIImage *> *)guides
                   rootViewController:(UIViewController *)rootViewController
                           scrollPage:(void(^)(HSYCustomGuideView *guide, NSInteger currentPage))page
                            completed:(void(^)(HSYCustomGuideView *guide, BOOL finished))completed;

/**
 快速方法2
 
 @param guides 翻页图片的图片名称集合
 @param rootViewController 根视图控制器
 @param immediately 滚动结束后是否立即清除Guide视图
 @param page 每次翻页结束后，通过page返回事件
 @param completed 滚动结束后移除时的监听回调
 @return HSYCustomGuideView
 */
+ (HSYCustomGuideView *)hsy_appGuides:(NSArray<UIImage *> *)guides
                   rootViewController:(UIViewController *)rootViewController
                 immediatelyCompleted:(BOOL)immediately
                           scrollPage:(void(^)(HSYCustomGuideView *guide, NSInteger currentPage))page
                            completed:(void(^)(HSYCustomGuideView *guide, BOOL finished))completed;
@end
