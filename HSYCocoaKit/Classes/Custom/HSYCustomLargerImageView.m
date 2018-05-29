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

static CGFloat kHSYCustomEffectDefaultAlpha = 0.5f;

@interface HSYCustomLargerImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *hsy_imageView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HSYCustomLargerImageView

- (instancetype)initWithExtraLightStyle:(UIImage *)image
                            effectAlpha:(CGFloat)alpha
                        backgroundImage:(UIImage *)backgroundImage
                       imageCoordinates:(NSArray<NSValue *> *)coordinates
{
    return [self initWithStyle:UIBlurEffectStyleExtraLight
                   effectAlpha:alpha
                         image:image
               backgroundImage:backgroundImage
              imageCoordinates:coordinates];
}

- (instancetype)initWithExtraLightStyle:(UIImage *)image
                        backgroundImage:(UIImage *)backgroundImage
                       imageCoordinates:(NSArray<NSValue *> *)coordinates
{
    return [self initWithExtraLightStyle:image
                             effectAlpha:kHSYCustomEffectDefaultAlpha
                         backgroundImage:backgroundImage
                        imageCoordinates:coordinates];
}

- (instancetype)initWithLightStyle:(UIImage *)image
                       effectAlpha:(CGFloat)alpha
                   backgroundImage:(UIImage *)backgroundImage
                  imageCoordinates:(NSArray<NSValue *> *)coordinates
{
    return [self initWithStyle:UIBlurEffectStyleLight
                   effectAlpha:alpha
                         image:image
               backgroundImage:backgroundImage
              imageCoordinates:coordinates];
}

- (instancetype)initWithLightStyle:(UIImage *)image
                   backgroundImage:(UIImage *)backgroundImage
                  imageCoordinates:(NSArray<NSValue *> *)coordinates
{
    return [self initWithLightStyle:image
                        effectAlpha:kHSYCustomEffectDefaultAlpha
                    backgroundImage:backgroundImage
                   imageCoordinates:coordinates];
}

- (instancetype)initWithDarkStyle:(UIImage *)image
                      effectAlpha:(CGFloat)alpha
                  backgroundImage:(UIImage *)backgroundImage
                 imageCoordinates:(NSArray<NSValue *> *)coordinates
{
    return [self initWithStyle:UIBlurEffectStyleDark
                   effectAlpha:alpha
                         image:image
               backgroundImage:backgroundImage
              imageCoordinates:coordinates];
}

- (instancetype)initWithDarkStyle:(UIImage *)image
                  backgroundImage:(UIImage *)backgroundImage
                 imageCoordinates:(NSArray<NSValue *> *)coordinates
{
    return [self initWithDarkStyle:image
                       effectAlpha:kHSYCustomEffectDefaultAlpha
                   backgroundImage:backgroundImage
                  imageCoordinates:coordinates];
}

//- (instancetype)initWithStyle:(UIBlurEffectStyle)style
//                  effectAlpha:(CGFloat)alpha
//                        image:(UIImage *)image
//              backgroundImage:(UIImage *)backgroundImage
//             imageCoordinates:(NSArray<NSValue *> *)coordinates
//                       images:(NSArray<UIImage *> *)images

//@{@"选中的UIImageView对象的url地址" : @"这组UIImageView对象所有的url地址"}
- (instancetype)initWithStyle:(UIBlurEffectStyle)style
                  effectAlpha:(CGFloat)alpha
              backgroundImage:(UIImage *)backgroundImage
             imageViews:(NSDictionary<NSString *, NSArray<NSString *> *> *)imageViews
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT)]) {
        self.hsy_imageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image}];
        self.hsy_imageView.frame = self.bounds;
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = self.hsy_imageView.bounds;
        [self addSubview:self.hsy_imageView];
        [self.hsy_imageView addSubview:visualEffectView];
        
        self.scrollView = [NSObject createScrollViewByParam:@{@(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : [NSValue valueWithCGRect:self.bounds], @(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self, @(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(YES)}];
        [self addSubview:self.scrollView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
