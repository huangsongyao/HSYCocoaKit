//
//  HSYCustomGuideView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import "HSYCustomGuideView.h"
#import "NSObject+UIKit.h"
#import "UIView+Frame.h"
#import "UIApplication+Device.h"
#import "PublicMacroFile.h"
#import "UIScrollView+Page.h"

@interface HSYCustomGuideView () <UIScrollViewDelegate>

@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *hsy_guides;
@property (nonatomic, assign) BOOL hsy_immediately;

@end

@implementation HSYCustomGuideView

- (instancetype)initWithGuides:(NSArray<UIImage *> *)guides rootViewController:(UIViewController *)rootViewController
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIApplication keyWindows].bounds];
    window.windowLevel = 1000;
    window.rootViewController = rootViewController;
    [window makeKeyAndVisible];
    if (self = [super initWithFrame:window.bounds]) {
        _hsy_guides = [NSMutableArray arrayWithArray:guides];
        _hsy_window = window;
        _hsy_scrollView = [NSObject createScrollViewByParam:@{@(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(YES), @(kHSYCocoaKitOfScrollViewPropretyTypeScrollEnabled) : @(YES), @(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self, @(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : [NSValue valueWithCGRect:self.bounds], @(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator) : @(YES), @(kHSYCocoaKitOfScrollViewPropretyTypeBounces) : @(NO), }];
        [self addSubview:self.hsy_scrollView];
        self.backgroundColor = WHITE_COLOR;
        
        CGFloat x = 0.0f;
        for (UIImage *image in guides) {
            UIImageView *imageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image, }];
            imageView.frame = CGRectMake(x, 0.0f, self.hsy_scrollView.width, self.hsy_scrollView.height);
            [self.hsy_scrollView addSubview:imageView];
            x = imageView.right;
        }
        [self.hsy_scrollView setContentSize:CGSizeMake(x, self.hsy_scrollView.height)];
    }
    return self;
}

#pragma mark - Animation

- (void)hsy_guideFaceOut
{
    //渐变淡出动画
    CGFloat duration = 1.0;
    [UIView beginAnimations:@"HideWindow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:duration];
    self.hsy_window.alpha = 0.0;
    self.hsy_window.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [UIView commitAnimations];
    
    //移除window
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.hsy_window removeFromSuperview];
        self.hsy_window.rootViewController = nil;
        if (self.hsy_guideScrollCompleted) {
            self.hsy_guideScrollCompleted(self, YES);
        }
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat lastPageLeft = (self.hsy_guides.count - 1) * IPHONE_WIDTH;
    BOOL canScroll = (self.hsy_immediately && (scrollView.contentOffset.x > (lastPageLeft + 5.0f)));
    scrollView.bounces = (scrollView.scrollHorizontalDirection == kHSYCocoaKitScrollDirectionToRight);
    if (canScroll) {
        scrollView.contentOffset = CGPointMake(lastPageLeft, 0);
        [self hsy_guideFaceOut];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.hsy_scrollPage) {
        self.hsy_scrollPage(self, self.hsy_scrollView.currentPage);
    }
}

@end

@implementation HSYCustomGuideView (Show)

+ (HSYCustomGuideView *)hsy_appGuides:(NSArray<UIImage *> *)guides
                   rootViewController:(UIViewController *)rootViewController
                           scrollPage:(void(^)(HSYCustomGuideView *guide, NSInteger currentPage))page
                            completed:(void(^)(HSYCustomGuideView *guide, BOOL finished))completed
{
    return [HSYCustomGuideView hsy_appGuides:guides
                          rootViewController:rootViewController
                        immediatelyCompleted:YES
                                  scrollPage:page
                                   completed:completed];
}

+ (HSYCustomGuideView *)hsy_appGuides:(NSArray<UIImage *> *)guides
                   rootViewController:(UIViewController *)rootViewController
                 immediatelyCompleted:(BOOL)immediately
                           scrollPage:(void (^)(HSYCustomGuideView *, NSInteger))page
                            completed:(void (^)(HSYCustomGuideView *, BOOL))completed
{
    HSYCustomGuideView *guideView = [[HSYCustomGuideView alloc] initWithGuides:guides rootViewController:rootViewController];
    guideView.hsy_immediately = immediately;
    guideView.hsy_scrollPage = page;
    guideView.hsy_guideScrollCompleted = completed;
    
    return guideView;
}

@end

