//
//  HSYCustomWindows.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/20.
//

#import "HSYCustomWindows.h"
#import "UIApplication+Device.h"
#import "NSObject+UIKit.h"
#import "UIView+Frame.h"
#import "UIImage+Canvas.h"
#import "Masonry.h"

static NSTimeInterval kHSYCocoaKitDefaultDuration = 0.35f;

@implementation HSYCustomWindowsComponent

- (instancetype)initWithImage:(UIImage *)image
{
    CGFloat kHSYCocoaKitDefaultComponentWidth  = (IPHONE_WIDTH/3+IPHONE_WIDTH/4);
    CGFloat kHSYCocoaKitDefaultComponentHeight = (IPHONE_HEIGHT/3);
    if (self = [super initWithSize:CGSizeMake(kHSYCocoaKitDefaultComponentWidth, kHSYCocoaKitDefaultComponentHeight)]) {
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        self.backgroundColor = CLEAR_COLOR;
        UIImage *backgroundImage = image;
        if (!backgroundImage) {
            backgroundImage = [UIImage imageWithFillColor:WHITE_COLOR];
        }
        _hsy_backgroundImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : backgroundImage, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : backgroundImage, }];
        [self addSubview:self.hsy_backgroundImageView];
        [self.hsy_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end

//********************************************************************************************************

@interface HSYCustomWindows ()

@property (nonatomic, strong) UIView *hsy_blackMaskView;                    //渐变的黑色背景遮罩
@property (nonatomic, assign, readonly) CGPoint anchorPoint;                //主体小窗口的锚点

@end

@implementation HSYCustomWindows

- (instancetype)initWithDefaults:(void(^)(HSYCustomWindows *view))remove
{
    UIImage *backgroundImage = [UIImage imageWithFillColor:WHITE_COLOR];
    return [self initWithDefaults:HSYCOCOAKIT_ANCHOR_POINT_X05_Y05
                         position:CGPointZero
                  backgroundImage:backgroundImage
                           remove:remove];
}

- (instancetype)initWithUnimmediatelyDefaults:(void(^)(HSYCustomWindows *view))remove
{
    UIImage *backgroundImage = [UIImage imageWithFillColor:WHITE_COLOR];
    return [self initWithUnimmediatelyDefaults:HSYCOCOAKIT_ANCHOR_POINT_X05_Y05
                                      position:CGPointZero
                               backgroundImage:backgroundImage
                                        remove:remove];
}

- (instancetype)initWithDefaults:(CGPoint)anchorPoint
                        position:(CGPoint)position
                 backgroundImage:(UIImage *)backgroundImage
                          remove:(void(^)(HSYCustomWindows *view))remove
{
    return [self initWithDefaults:anchorPoint
                         position:position
       immediatelyCompletedSignal:YES
                  backgroundImage:backgroundImage
                           remove:remove];
}

- (instancetype)initWithUnimmediatelyDefaults:(CGPoint)anchorPoint
                                     position:(CGPoint)position
                              backgroundImage:(UIImage *)backgroundImage
                                       remove:(void(^)(HSYCustomWindows *view))remove
{
    return [self initWithDefaults:anchorPoint
                         position:position
       immediatelyCompletedSignal:NO
                  backgroundImage:backgroundImage
                           remove:remove];
}

- (instancetype)initWithDefaults:(CGPoint)anchorPoint
                        position:(CGPoint)position
      immediatelyCompletedSignal:(BOOL)immediately
                 backgroundImage:(UIImage *)backgroundImage
                          remove:(void(^)(HSYCustomWindows *view))remove
{
    UIWindow *window = [UIApplication keyWindows];
    if (self = [super initWithFrame:window.bounds]) {
        self.backgroundColor = CLEAR_COLOR;
        _anchorPoint = anchorPoint;
        //黑色遮罩
        self.hsy_blackMaskView = [[UIView alloc] initWithFrame:self.bounds];
        self.hsy_blackMaskView.backgroundColor = BLACK_COLOR;
        self.hsy_blackMaskView.alpha = kHSYCocoaKitMinScale;
        [self addSubview:self.hsy_blackMaskView];
        
        //主体小窗口
        _hsy_wicketView = [[HSYCustomWindowsComponent alloc] initWithImage:backgroundImage];
        if (!CGPointEqualToPoint(anchorPoint, HSYCOCOAKIT_ANCHOR_POINT_X05_Y05)) {
            self.hsy_wicketView.layer.anchorPoint = anchorPoint;
            self.hsy_wicketView.layer.position = position;
        } else {
            if (!CGRectEqualToRect(self.hsy_wicketCGRect, CGRectZero)) {
                self.hsy_wicketView.frame = self.hsy_wicketCGRect;
            } else {
                self.hsy_wicketView.origin = CGPointMake((self.width - self.hsy_wicketView.width)/2, (self.height - self.hsy_wicketView.height)/2);
            }
        }
        self.hsy_wicketView.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMinScale);
        [self addSubview:self.hsy_wicketView];
        
        //添加单指移除交互
        @weakify(self);
        [[[self hsy_addSingleGesture:immediately] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            @strongify(self);
            if (remove) {
                remove(self);
            }
        }];
        
        //添加键盘监听
        [[[self hsy_keyboardObserver:immediately] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
            @strongify(self);
            CGFloat y = (self.height - self.hsy_wicketView.height)/2;
            if (![tuple.third boolValue]) {
                y = [tuple.second CGRectValue].origin.y - self.hsy_wicketView.height;
            }
            self.hsy_wicketView.y = y;
        }];
        
        //添加默认的不响应类
        self.hsy_unResponseClases = [self.class hsy_defaultUnReponseClasses];
        
        //黑色遮罩最大透明度默认值
        self.hsy_blackMaskMaxAlpha = kHSYCocoaKitMaxScale/2;
        
        //添加至windows层
        [window addSubview:self];
    }
    return self;
}

#pragma mark - Animation

- (void)hsy_rac_showAlert:(void(^)(UIView *view))show completed:(void(^)(BOOL finished, UIView *view))completed
{
    @weakify(self);
    [UIView animateWithDuration:self.hsy_durations animations:^{
        @strongify(self);
        self.hsy_blackMaskView.alpha = self.hsy_blackMaskMaxAlpha;
        if (show) {
            show(self.hsy_wicketView);
        }
    } completion:^(BOOL finished) {
        if (completed) {
            completed(finished, self.hsy_wicketView);
        }
    }];
}

- (void)hsy_rac_removeAlert:(void(^)(UIView *view))remove completed:(RACSignal *(^)(BOOL finished, UIView *view))completed
{
    @weakify(self);
    [UIView animateWithDuration:self.hsy_durations animations:^{
        @strongify(self);
        self.hsy_blackMaskView.alpha = kHSYCocoaKitMinScale;
        if (remove) {
            remove(self.hsy_wicketView);
        }
    } completion:^(BOOL finished) {
        @strongify(self);
        if (completed) {
            RACSignal *signal = completed(finished, self.hsy_wicketView);
            [[signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^{
                @strongify(self);
                [self removeFromSuperview];
            }];
        }
    }];
}

- (NSTimeInterval)hsy_durations
{
    return kHSYCocoaKitDefaultDuration;
}

#pragma mark - Setter

- (void)wicketViewCGRect:(CGRect)hsy_wicketCGRect
{
    _hsy_wicketCGRect = hsy_wicketCGRect;
    if (CGPointEqualToPoint(self.anchorPoint, HSYCOCOAKIT_ANCHOR_POINT_X05_Y05)) {
        self.hsy_wicketView.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMaxScale);
        self.hsy_wicketView.frame = hsy_wicketCGRect;
        self.hsy_wicketView.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMinScale);
    }
}

- (void)wicketViewCornerRadius:(CGFloat)hsy_wicketRadius
{
    _hsy_wicketRadius = hsy_wicketRadius;
    if (CGPointEqualToPoint(self.anchorPoint, HSYCOCOAKIT_ANCHOR_POINT_X05_Y05)) {
        self.hsy_wicketView.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMaxScale);
        self.hsy_wicketView.layer.cornerRadius = hsy_wicketRadius;
        self.hsy_wicketView.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMinScale);
    }
}

@end
