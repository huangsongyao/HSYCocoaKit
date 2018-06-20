//
//  HSYCustomWindows.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/20.
//

#import "HSYCustomWindows.h"
#import "UIApplication+Device.h"
#import "NSObject+UIKit.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"
#import "UIImage+Canvas.h"

static NSTimeInterval kHSYCocoaKitDefaultDuration = 0.35f;

@implementation HSYCustomWindowsComponent

- (instancetype)initWithImage:(NSString *)image
{
    CGFloat kHSYCocoaKitDefaultComponentWidth  = (IPHONE_WIDTH/3);
    CGFloat kHSYCocoaKitDefaultComponentHeight = (IPHONE_HEIGHT/3);
    if (self = [super initWithSize:CGSizeMake(kHSYCocoaKitDefaultComponentWidth, kHSYCocoaKitDefaultComponentHeight)]) {
        self.backgroundColor = CLEAR_COLOR;
        UIImage *backgroundImage = [UIImage imageNamed:image];
        if (!backgroundImage) {
            backgroundImage = [UIImage imageWithFillColor:WHITE_COLOR];
        }
        _hsy_backgroundImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : backgroundImage, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : backgroundImage, }];
        self.hsy_backgroundImageView.frame = self.bounds;
        [self addSubview:self.hsy_backgroundImageView];
    }
    return self;
}

@end

//********************************************************************************************************

@interface HSYCustomWindows ()

@property (nonatomic, strong) UIView *hsy_blackMaskView;                    //渐变的黑色背景遮罩

@end

@implementation HSYCustomWindows

- (instancetype)initWithDefaults:(void(^)(HSYCustomWindows *view))remove
{
    UIWindow *window = [UIApplication keyWindows];
    if (self = [super initWithFrame:window.bounds]) {
        self.backgroundColor = CLEAR_COLOR;
        //黑色遮罩
        self.hsy_blackMaskView = [[UIView alloc] initWithFrame:self.bounds];
        self.hsy_blackMaskView.backgroundColor = BLACK_COLOR;
        self.hsy_blackMaskView.alpha = kHSYCocoaKitMinScale;
        [self addSubview:self.hsy_blackMaskView];
        
        //主体小窗口
        [self hsy_addWicketByAnchorPoint:HSYCOCOAKIT_ANCHOR_POINT_X05_Y05 position:CGPointZero];
        
        //添加单指移除交互
        @weakify(self);
        [[[self hsy_addSingleGesture] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            @strongify(self);
            if (remove) {
                remove(self);
            }
        }];
        
        //添加至windows层
        [window addSubview:self];
    }
    return self;
}

- (void)hsy_addWicketByAnchorPoint:(CGPoint)anchorPoint position:(CGPoint)position
{
    _hsy_wicketView = [[HSYCustomWindowsComponent alloc] initWithImage:nil];
    self.hsy_wicketView.clipsToBounds = YES;
    if (!CGPointEqualToPoint(anchorPoint, HSYCOCOAKIT_ANCHOR_POINT_X05_Y05)) {
        self.hsy_wicketView.layer.anchorPoint = anchorPoint;
        self.hsy_wicketView.layer.position = position;
    } else {
        self.hsy_wicketView.origin = CGPointMake((self.width - self.hsy_wicketView.width)/2, (self.height - self.hsy_wicketView.height)/2);
    }
    self.hsy_wicketView.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMinScale);
    [self addSubview:self.hsy_wicketView];
}

- (RACSignal *)hsy_rac_showAlert
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [UIView animateWithDuration:self.hsy_durations animations:^{
            @strongify(self);
            self.hsy_blackMaskView.alpha = kHSYCocoaKitMaxScale/2;
            [subscriber sendNext:self.hsy_wicketView];
        } completion:^(BOOL finished) {
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods“- hsy_showAlert”");
        }];
    }];
}

- (RACSignal *)hsy_rac_removeAlert:(BOOL)isAtOnceRemove
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [UIView animateWithDuration:self.hsy_durations animations:^{
            @strongify(self);
            self.hsy_blackMaskView.alpha = kHSYCocoaKitMinScale;
            [subscriber sendNext:self.hsy_wicketView];
        } completion:^(BOOL finished) {
            @strongify(self);
            [subscriber sendCompleted];
            if (isAtOnceRemove) {
                [self removeFromSuperview];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods“- hsy_showAlert”");
        }];
    }];
}

- (NSTimeInterval)hsy_durations
{
    return kHSYCocoaKitDefaultDuration;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
