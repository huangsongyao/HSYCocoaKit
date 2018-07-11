//
//  UIViewController+NavigationItem.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "UIViewController+NavigationItem.h"
#import "UIView+Frame.h"
#import "NSObject+UIKit.h"
#import "PublicMacroFile.h"
#import "NSString+Size.h"
#import "NSBundle+PrivateFileResource.h"

NSInteger const kHSYCocoaKitDefaultCustomBarItemTag     = 10923;

@implementation UIViewController (NavigationItem)

+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsImages:(NSArray<NSDictionary *> *)images
                                          edgeInsetsLeft:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    return [UIViewController hsy_barButtonItemsImages:images
                                           highImages:images
                                       edgeInsetsLeft:left
                                        subscribeNext:next];
}

+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsImages:(NSArray<NSDictionary *> *)images
                                              highImages:(NSArray<NSDictionary *> *)highImages
                                          edgeInsetsLeft:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:images.count];
    for (NSDictionary *dic in images) {
        NSString *normal = dic.allValues.firstObject;
        NSString *press = [highImages[[images indexOfObject:dic]] allValues].firstObject;
        UIImage *image = [UIImage imageNamed:normal];
        UIImage *highImage = [UIImage imageNamed:press];
        if (!image) {
            image = [NSBundle imageForBundle:normal];
        }
        if (!highImage) {
            highImage = [NSBundle imageForBundle:press];
        }
        NSDictionary *paramter = @{
                                   @(kHSYCocoaKitOfButtonPropretyTypeNorImageViewName) : image,
                                   @(kHSYCocoaKitOfButtonPropretyTypePreImageViewName) : highImage,
                                   };
        UIButton *button = [NSObject createButtonByParam:paramter clickedOnSubscribeNext:^(UIButton *button) {
            if (next) {
                next(button, (button.tag));
            }
        }];
        button.size = CGSizeMake(DEFAULT_BUTTOM_SIZE, DEFAULT_BUTTOM_SIZE);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
        button.tag = [dic.allKeys.firstObject integerValue];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [items addObject:buttonItem];
    }
    return items;
}

+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsTitles:(NSArray<NSDictionary *> *)titles
                                             titleColors:(NSArray<UIColor *> *)titleColors
                                              titleFonts:(NSArray<UIFont *> *)titleFonts
                                          edgeInsetsLeft:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSDictionary *dic in titles) {
        NSInteger i = [titles indexOfObject:dic];
        NSString *title = dic.allValues.firstObject;
        UIColor *titleColor = titleColors[i];
        UIFont *font = titleFonts[i];
        NSDictionary *paramter = @{
                                   @(kHSYCocoaKitOfButtonPropretyTypeNorTitle) : title,
                                   @(kHSYCocoaKitOfButtonPropretyTypeHighTitle) : title,
                                   @(kHSYCocoaKitOfButtonPropretyTypeTitleColor) : titleColor,
                                   @(kHSYCocoaKitOfButtonPropretyTypeTitleFont) : font,
                                   };
        UIButton *button = [NSObject createButtonByParam:paramter clickedOnSubscribeNext:^(UIButton *button) {
            if (next) {
                next(button, (button.tag));
            }
        }];
        CGSize size = [button.titleLabel.text contentOfSize:button.titleLabel.font maxHeight:button.titleLabel.font.pointSize];
        button.size = CGSizeMake((size.width + left), DEFAULT_BUTTOM_SIZE);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
        button.tag = [dic.allKeys.firstObject integerValue];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [items addObject:buttonItem];
    }
    return items;
}

+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsTitles:(NSArray<NSDictionary *> *)titles
                                          edgeInsetsLeft:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    NSMutableArray *titleColors = [NSMutableArray arrayWithCapacity:titles.count];
    NSMutableArray *titleFonts = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSInteger i = 0; i < titles.count; i ++) {
        [titleColors addObject:BLACK_COLOR];
        [titleFonts addObject:UI_SYSTEM_FONT_15];
    }
    return [self.class hsy_barButtonItemsTitles:titles titleColors:titleColors titleFonts:titleFonts edgeInsetsLeft:left subscribeNext:next];
}

@end
