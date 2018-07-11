//
//  HSYCustomNavigationBar.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYCustomNavigationBar.h"
#import "HSYBaseViewController+CustomNavigationItem.h"
#import "UIView+Frame.h"
#import "UIImage+Canvas.h"
#import "NSObject+UIKit.h"
#import "NSBundle+PrivateFileResource.h"
#import "PublicMacroFile.h"
#import "UINavigationBar+Background.h"

static NSInteger const kHSYCustomNavigationBarBottomLineTag = 2334;

#pragma mark - Navigation Bar

@interface HSYCustomNavigationBar ()

@end

@implementation HSYCustomNavigationBar

- (instancetype)initWithObject:(id)object
{
    CGFloat height = IPHONE_BAR_HEIGHT;
    CGFloat width = IPHONE_WIDTH;
    if (@available(iOS 11.0, *)) {
        height = IPHONE_NAVIGATION_BAR_HEIGHT;
    }
    if (self = [super initWithFrame:CGRectMake(0, 0, width, height)]) {
        UIImage *image = [UIImage imageWithFillColor:NAV_DEFAULT_COLOR];
        [self setCustomNavigationBarBackgroundImage:image];
        if ([object isKindOfClass:[NSString class]] || !object) {
            _customNavigationItem = [[UINavigationItem alloc] initWithTitle:object];
        } else {
            _customNavigationItem = [[UINavigationItem alloc] initWithTitle:@""];
            self.customNavigationItem.titleView = (UIView *)object;
        }
        [self pushNavigationItem:self.customNavigationItem animated:YES];
        [self hsy_clearNavigationBarBottomLine];
        self.backItem.hidesBackButton = YES;
    }
    return self;
}

#pragma mark - Set BackgroundImage

- (void)setCustomNavigationBarBackgroundImage:(UIImage *)backgroundImage
{
    [self setNavigationBarBackgroundImage:backgroundImage];
}

#pragma mark - Line

- (void)hsy_clearNavigationBarBottomLine
{
    [self hsy_customBarBottomLineOfColor:CLEAR_COLOR];
}

- (void)hsy_customBarBottomLineOfColor:(UIColor *)color
{
    [self setBarBottomLineOfColor:color tag:kHSYCustomNavigationBarBottomLineTag];
}

#pragma mark - BackBarButton Item

+ (UIBarButtonItem *)hsy_defalutBackButtonItemForImage:(NSString *)normal
                                             highImage:(NSString *)press
                                                 title:(NSString *)title
                                         subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    UIBarButtonItem *backItem = [self.class hsy_defalutBackButtonItemForImage:normal highImage:press title:title left:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
    return backItem;
}

+ (UIBarButtonItem *)hsy_defalutBackButtonItemForImage:(NSString *)normal
                                             highImage:(NSString *)press
                                                 title:(NSString *)title
                                                  left:(CGFloat)left
                                         subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    NSArray<UIBarButtonItem *> *barButtonItems = [UIViewController hsy_barButtonItemsImages:@[@{@(kHSYCocoaKitDefaultCustomBarItemTag) : normal, }] highImages:@[@{@(kHSYCocoaKitDefaultCustomBarItemTag) : normal, }] edgeInsetsLeft:left subscribeNext:next];
    UIBarButtonItem *backItem = barButtonItems.firstObject;
    return backItem;
}

+ (UIBarButtonItem *)hsy_backButtonItemForTitle:(NSString *)title
                                           left:(CGFloat)left
                                  subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    UIBarButtonItem *backItem = [self.class hsy_defalutBackButtonItemForImage:nil highImage:nil title:title left:left subscribeNext:next];
    return backItem;
}

+ (UIBarButtonItem *)hsy_backButtonItemForTitle:(NSString *)title
                                  subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    UIBarButtonItem *backItem = [self.class hsy_backButtonItemForTitle:title left:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
    return backItem;
}

+ (UIBarButtonItem *)hsy_backButtonItemForImage:(NSString *)normal
                                      highImage:(NSString *)press
                                           left:(CGFloat)left
                                  subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    UIBarButtonItem *backItem = [self.class hsy_defalutBackButtonItemForImage:normal highImage:press title:nil left:left subscribeNext:next];
    return backItem;
}

+ (UIBarButtonItem *)hsy_backButtonItemForImage:(NSString *)normal
                                      highImage:(NSString *)press
                                  subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    UIBarButtonItem *backItem = [self.class hsy_backButtonItemForImage:normal highImage:press left:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
    return backItem;
}

@end

#pragma mark - Custom Bar

@interface HSYCustomNavigationContentViewBar ()

@property (nonatomic, strong) UIImageView *backgroundImage;

@end

@implementation HSYCustomNavigationContentViewBar

- (instancetype)initWithObject:(id)object
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, IPHONE_BAR_HEIGHT)]) {
        self.backgroundColor = NAV_DEFAULT_COLOR;
        self.backgroundImage = [NSObject createImageViewByParam:@{}];
        self.backgroundImage.frame = self.bounds;
        [self addSubview:self.backgroundImage];
        
        _navigationBar = [[HSYCustomNavigationBar alloc] initWithObject:object];
        self.navigationBar.y = 0.0f;
        if (@available(iOS 11.0, *)) {
            self.navigationBar.y = IPHONE_STATE_BAR_HEIGHT;
        }
        [self addSubview:self.navigationBar];
    }
    return self;
}

- (void)setCustomNavigationContentBarBackgroundImage:(UIImage *)backgroundImage
{
    UIImage *image = [UIImage imageWithFillColor:CLEAR_COLOR];
    [self.navigationBar setCustomNavigationBarBackgroundImage:image];
    self.backgroundImage.image = backgroundImage;
    self.backgroundImage.highlightedImage = backgroundImage;
}

@end


