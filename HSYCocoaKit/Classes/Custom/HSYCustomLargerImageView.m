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

static CGFloat kHSYCustomEffectDefaultAlpha     = 0.5f;
static CGFloat kHSYCustomAnimatedDuration       = 0.35f;

@interface HSYCustomLargerImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *effectImageView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HSYCustomLargerImageView

//@{选中的图片的CGRect : 选中图片的UIImage}
//@[@{图片1的CGRect : 图片1的UIImage}, @{图片2的CGRect : 图片2的UIImage}, ..]
- (instancetype)initWithStyle:(UIBlurEffectStyle)style
                  effectAlpha:(CGFloat)alpha
              backgroundImage:(UIImage *)backgroundImage    //毛玻璃效果的背景图片
        selectedImageParamter:(NSDictionary<NSValue *, UIImage *> *)selectedParamter
               imagesParamter:(NSDictionary<NSNumber *, NSArray *> *)paramter
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT)]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0f;
        //毛玻璃效果的背景图
        self.effectImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : backgroundImage, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : backgroundImage}];
        self.effectImageView.frame = self.bounds;
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = self.effectImageView.bounds;
        [self addSubview:self.effectImageView];
        self.effectImageView.alpha = 0.0f;
        [self.effectImageView addSubview:visualEffectView];
        
        //当前显示到翻页页面上的图片
        self.currentImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : selectedParamter.allValues.firstObject, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : selectedParamter.allValues.firstObject}];
        self.currentImageView.frame = [selectedParamter.allKeys.firstObject CGRectValue];
        [self addSubview:self.currentImageView];
        
        //用于图片组翻页显示的ScrollView
        self.scrollView = [NSObject createScrollViewByParam:@{@(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : [NSValue valueWithCGRect:self.bounds], @(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self, @(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(YES)}];
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
            x = imageView.right;
        }
        [self.scrollView setContentSize:CGSizeMake(x, 0)];
        [self addSubview:self.scrollView];
        
        //添加至window层
        [self removeFromSuperview];
        [[UIApplication keyWindows] addSubview:self];
    }
    return self;
}

#pragma mark - Animation

- (void)show
{
    @weakify(self);
    [UIView animateWithDuration:kHSYCustomAnimatedDuration animations:^{
        @strongify(self);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)remove
{
    @weakify(self);
    [UIView animateWithDuration:kHSYCustomAnimatedDuration animations:^{
        @strongify(self);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Rect

+ (NSValue *)valueForSelectedImage:(UIView *)view
{
    CGRect rect = [[UIApplication keyWindows] convertRect:view.frame fromWindow:[UIApplication keyWindows]];
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
