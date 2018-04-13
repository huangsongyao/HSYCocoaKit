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

static NSInteger const kHSYCustomNavigationBarBottomLineTag = 2334;

@interface HSYCustomNavigationBar () <UINavigationBarDelegate>

@end

@implementation HSYCustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [UIImage createImgWithColor:[UIColor greenColor]];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        _customNavigationItem = [[UINavigationItem alloc] initWithTitle:@""];
        [self pushNavigationItem:self.customNavigationItem animated:YES];
        [self hsy_clearNavigationBarBottomLine];
    }
    return self;
}

#pragma mark - Line

- (void)hsy_clearNavigationBarBottomLine
{
    [self hsy_customBarBottomLineOfColor:[UIColor clearColor]];
}

- (void)hsy_customBarBottomLineOfColor:(UIColor *)color
{
    [self setShadowImage:[UIImage createImgWithColor:[UIColor clearColor]]];
    CGFloat height = 1.0f;
    UIView *lineView = [self viewWithTag:kHSYCustomNavigationBarBottomLineTag];
    if (!lineView) {
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - height, self.width, height)];
        lineView.tag = kHSYCustomNavigationBarBottomLineTag;
    }
    lineView.backgroundColor = color;
    [self addSubview:lineView];
}

#pragma mark - BarButton Item

+ (UIBarButtonItem *)hsy_backButtonItemForImage:(NSString *)name subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next
{
    UIImage *image = [self.class hsy_imageForBundle:name];
    NSDictionary *dic = @{
                          @(kHSYCocoaKitOfButtonPropretyTypeNorImageViewName) : image,
                          @(kHSYCocoaKitOfButtonPropretyTypePreImageViewName) : image,
                          };
    UIButton *button = [NSObject createButtonByParam:dic clickedOnSubscribeNext:^(UIButton *button) {
        if (next) {
            next(button, kHSYCustomBarButtonItemTagBack);
        }
    }];
    button.size = CGSizeMake(DEFAULT_BUTTOM_SIZE, DEFAULT_BUTTOM_SIZE);                         //默认点击区域为40x40dx
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -DEFAULT_BUTTOM_EDGE_INSETS_LEFT, 0, 0);     //默认返回按钮的箭头图片向左编译10dx
    button.tag = kHSYCustomBarButtonItemTagBack;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return backItem;
}

+ (UIBarButtonItem *)hsy_backButtonItem:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next
{
    return [self.class hsy_backButtonItemForImage:@"nav_icon_back" subscribeNext:next];
}

+ (UIImage *)hsy_imageForBundle:(NSString *)imageName
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *bundleName = bundle.infoDictionary[@"CFBundleName"];
    NSURL *bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    UIImage *image = [UIImage imageNamed:imageName
                                inBundle:resourceBundle
           compatibleWithTraitCollection:nil];
    
    return image;
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