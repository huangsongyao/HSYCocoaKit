//
//  HSYCustomLargerImageView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import "HSYCustomLargerImageView.h"
#import "UIView+Frame.h"
#import "PublicMacroFile.h"
#import "NSObject+UIKit.h"
#import "NSArray+Finder.h"
#import "UIImageView+UrlString.h"
#import "UIImageView+Scale.h"
#import "UIView+Frame.h"
#import "UIApplication+Device.h"
#import "ReactiveCocoa.h"
#import "UIScrollView+Page.h"
#import "UIImage+Canvas.h"

static CGFloat kHSYCustomAnimatedDuration       = 0.35f;

@interface HSYCustomLargerImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *effectImageView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) NSArray<NSValue *> *imageCGRects;
@property (nonatomic, strong, readonly) UIView *removeSuperView;

@end

@implementation HSYCustomLargerImageView

- (instancetype)initWithDefaultSelectedImage:(UIImage *)selectedImage
                              imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
                                imageCGRects:(NSArray<NSValue *> *)imageCGRects
                            callMapSuperView:(UIView *)superView
{
    return [self initWithStyle:UIBlurEffectStyleLight
                 selectedImage:selectedImage
                imagesParamter:paramter
                  imageCGRects:imageCGRects
              callMapSuperView:superView];
}

- (instancetype)initWithStyle:(UIBlurEffectStyle)style
                selectedImage:(UIImage *)selectedImage
               imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
                 imageCGRects:(NSArray<NSValue *> *)imageCGRects
             callMapSuperView:(UIView *)superView
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT)]) {
        
        self.backgroundColor = [UIColor clearColor];
        _imageCGRects = imageCGRects;
        _removeSuperView = superView;
        //毛玻璃效果的背景图
        UIImage *backgroundImage = [UIImage imageWithFillColor:[UIColor clearColor]];
        self.effectImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : backgroundImage, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : backgroundImage}];
        self.effectImageView.frame = self.bounds;
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = self.effectImageView.bounds;
        [self.effectImageView addSubview:visualEffectView];
        [self addSubview:self.effectImageView];
        self.effectImageView.alpha = 0.0f;
        
        //当前显示到翻页页面上的图片
        self.currentImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : selectedImage, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : selectedImage}];
        NSNumber *indexCGRect = paramter.allKeys.firstObject;
        NSValue *indexValue = self.imageCGRects[indexCGRect.integerValue];
        self.currentImageView.frame = [self hsy_moveForRect:indexValue.CGRectValue];
        [self addSubview:self.currentImageView];
        
        //用于图片组翻页显示的ScrollView
        self.scrollView = [NSObject createScrollViewByParam:@{@(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : [NSValue valueWithCGRect:self.bounds], @(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self, @(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(YES), @(kHSYCocoaKitOfScrollViewPropretyTypeBounces) : @(NO)}];
        self.scrollView.hidden = YES;
        CGFloat x = 0.0f;
        NSInteger selectedIndex = [paramter.allKeys.firstObject integerValue];
        NSArray *urls = paramter.allValues.firstObject;
        for (id obj in urls) {
            UIImageView *imageView = [NSObject createImageViewByParam:@{}];
            if ([obj isKindOfClass:[UIImage class]]) {
                imageView.image = obj;
                imageView.highlightedImage = obj;
                [imageView scaleCentryCGRect];
            } else {
                [imageView setImageWithUrlString:obj];
            }
            
            imageView.x = x;
            [self.scrollView addSubview:imageView];
            x = imageView.right;
        }
        [self.scrollView setContentSize:CGSizeMake(x, 0)];
        [self.scrollView setXPage:selectedIndex];
        [self addSubview:self.scrollView];
        
        @weakify(self);
        [[[self hsy_addSingleGesture] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UITapGestureRecognizer *x) {
            @strongify(self);
            [self hsy_remove];
        }];
    }
    return self;
}

#pragma mark - Animation

- (void)hsy_show
{
    //添加至window层
    [self removeFromSuperview];
    UIWindow *window = [UIApplication keyWindows];
    [window addSubview:self];
    @weakify(self);
    [UIView animateWithDuration:kHSYCustomAnimatedDuration animations:^{
        @strongify(self);
        self.effectImageView.alpha = 1.0f;
        [self.currentImageView scaleCentryCGRect];
    } completion:^(BOOL finished) {
        @strongify(self);
        self.currentImageView.hidden = YES;
        self.scrollView.hidden = NO;
    }];
}

- (void)hsy_remove
{
    self.currentImageView.image = [(UIImageView *)self.scrollView.subviews[self.scrollView.currentPage] image];
    self.currentImageView.highlightedImage = [(UIImageView *)self.scrollView.subviews[self.scrollView.currentPage] highlightedImage];
    self.currentImageView.frame = [(UIImageView *)self.scrollView.subviews[self.scrollView.currentPage] frame];
    self.currentImageView.x = 0.0f;
    self.currentImageView.hidden = NO;
    self.scrollView.hidden = YES;
    @weakify(self);
    [UIView animateWithDuration:kHSYCustomAnimatedDuration animations:^{
        @strongify(self);
        CGRect rect = [self.imageCGRects[self.scrollView.currentPage] CGRectValue];
        self.currentImageView.frame = [self hsy_removeForRect:rect];
        self.effectImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        @strongify(self);
        self.currentImageView.hidden = YES;
        [self removeFromSuperview];
    }];
}

#pragma mark - Rect Map

- (CGRect)hsy_moveForRect:(CGRect)rect
{
    UIWindow *window = [UIApplication keyWindows];
    CGRect realRect = [self.removeSuperView convertRect:rect toView:window];
    return realRect;
    
}

- (CGRect)hsy_removeForRect:(CGRect)rect
{
    CGRect realRect = [self convertRect:rect fromView:self.removeSuperView];
    return realRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation HSYCustomLargerImageView (HSYCocoaKit)

+ (HSYCustomLargerImageView *)showLargerImageViewSelectedImage:(UIImage *)selectedImage imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter imageCGRects:(NSArray<NSValue *> *)imageCGRects callMapSuperView:(UIView *)superView
{
    HSYCustomLargerImageView *larger = [[HSYCustomLargerImageView alloc] initWithDefaultSelectedImage:selectedImage imagesParamter:paramter imageCGRects:imageCGRects callMapSuperView:superView];
    [larger hsy_show];
    return larger;
}

@end
