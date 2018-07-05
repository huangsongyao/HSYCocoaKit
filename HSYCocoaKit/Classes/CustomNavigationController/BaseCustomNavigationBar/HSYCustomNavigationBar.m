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

@interface HSYCustomNavigationBar () <UINavigationBarDelegate>

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

+ (UIBarButtonItem *)hsy_backButtonItemForImage:(NSString *)name title:(NSString *)title subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (title.length > 0) {
        dic[@(kHSYCocoaKitOfButtonPropretyTypeNorTitle)] = title;
        dic[@(kHSYCocoaKitOfButtonPropretyTypeHighTitle)] = title;
    }
    if (name.length > 0) {
        UIImage *image = [UIImage imageNamed:name];
        if (!image) {
            image = [NSBundle imageForBundle:name];
        }
        dic[@(kHSYCocoaKitOfButtonPropretyTypeNorImageViewName)] = image;
        dic[@(kHSYCocoaKitOfButtonPropretyTypePreImageViewName)] = image;
    }
    UIButton *button = [NSObject createButtonByParam:dic clickedOnSubscribeNext:^(UIButton *button) {
        if (next) {
            next(button, kHSYCocoaKitDefaultCustomBarItemTag);
        }
    }];
    //默认点击区域为40x40dx
    button.size = CGSizeMake(DEFAULT_BUTTOM_SIZE, DEFAULT_BUTTOM_SIZE);
    //默认返回按钮的箭头图片向左便宜10dx
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -DEFAULT_BUTTOM_EDGE_INSETS_LEFT, 0, 0);
    button.tag = kHSYCocoaKitDefaultCustomBarItemTag;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return backItem;
}

+ (UIBarButtonItem *)hsy_backButtonItemForTitle:(NSString *)title subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    return [self.class hsy_backButtonItemForImage:nil title:title subscribeNext:next];
}

+ (UIBarButtonItem *)hsy_backButtonItemForImage:(NSString *)name subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    return [self.class hsy_backButtonItemForImage:name title:nil subscribeNext:next];
}

#pragma mark - UINavigationBarDelegate


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

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


