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

@end

@implementation HSYCustomLargerImageView

- (instancetype)initWithDefaultSelectedImageParamter:(NSDictionary<NSValue *, UIImage *> *)selectedParamter
                      imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
{
    return [self initWithStyle:UIBlurEffectStyleLight
         selectedImageParamter:selectedParamter
                imagesParamter:paramter];
}

- (instancetype)initWithStyle:(UIBlurEffectStyle)style
        selectedImageParamter:(NSDictionary<NSValue *, UIImage *> *)selectedParamter
               imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT)]) {
        
        self.backgroundColor = [UIColor clearColor];
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
        self.currentImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : selectedParamter.allValues.firstObject, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : selectedParamter.allValues.firstObject}];
        self.currentImageView.frame = [selectedParamter.allKeys.firstObject CGRectValue];
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
    }
    return self;
}

#pragma mark - Animation

- (void)show
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

- (void)remove
{
    @weakify(self);
    [UIView animateWithDuration:kHSYCustomAnimatedDuration animations:^{
        
    } completion:^(BOOL finished) {
        @strongify(self);
        [self removeFromSuperview];
    }];
}

#pragma mark - Rect

+ (NSValue *)valueForSelectedImage:(UIView *)view superView:(UIView *)superView
{
    UIWindow *window = [UIApplication keyWindows];
    CGRect rect = [superView convertRect:view.frame toView:window];
    NSValue *value = [NSValue valueWithCGRect:rect];
    return value;
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

+ (HSYCustomLargerImageView *)showLargerImageViewSelectedImageParamter:(NSDictionary<NSValue *, UIImage *> *)selectedParamter imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
{
    HSYCustomLargerImageView *larger = [[HSYCustomLargerImageView alloc] initWithDefaultSelectedImageParamter:selectedParamter imagesParamter:paramter];
    [larger show];
    return larger;
}

@end
