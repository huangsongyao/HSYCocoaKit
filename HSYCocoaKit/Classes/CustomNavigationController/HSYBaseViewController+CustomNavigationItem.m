//
//  HSYBaseViewController+CustomNavigationItem.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYBaseViewController+CustomNavigationItem.h"
#import "UIView+Frame.h"
#import "NSObject+UIKit.h"

@implementation HSYBaseViewController (CustomNavigationItem)

- (void)leftItemsImages:(NSArray<NSDictionary *> *)images subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next
{
    self.customNavigationBar.customNavigationItem.leftBarButtonItems = [self.class barButtonItemsImages:images edgeInsetsLeft:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)rightItemsImages:(NSArray<NSDictionary *> *)images subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next
{
    self.customNavigationBar.customNavigationItem.rightBarButtonItems = [self.class barButtonItemsImages:images edgeInsetsLeft:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

+ (NSArray <UIBarButtonItem *>*)barButtonItemsImages:(NSArray<NSDictionary *> *)images edgeInsetsLeft:(CGFloat)left subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:images.count];
    for (NSDictionary *dic in images) {
        NSString *name = dic.allValues.firstObject;
        UIImage *image = [UIImage imageNamed:name];
        NSDictionary *dic = @{
                              @(kHSYCocoaKitOfButtonPropretyTypeNorImageViewName) : image,
                              @(kHSYCocoaKitOfButtonPropretyTypePreImageViewName) : image,
                              };
        UIButton *button = [NSObject createButtonByParam:dic clickedOnSubscribeNext:^(UIButton *button) {
            if (next) {
                next(button, ((kHSYCustomBarButtonItemTag)button.tag));
            }
        }];
        button.size = CGSizeMake(DEFAULT_BUTTOM_SIZE, DEFAULT_BUTTOM_SIZE);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
        button.tag = (kHSYCustomBarButtonItemTag)[dic.allKeys.firstObject integerValue];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [items addObject:buttonItem];
    }
    return items;
}

- (void)leftItemsTitles:(NSArray<NSDictionary *> *)titles subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next
{
    self.customNavigationBar.customNavigationItem.leftBarButtonItems = [self.class barButtonItemsTitles:titles edgeInsetsLeft:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)rightItemsTitles:(NSArray<NSDictionary *> *)titles subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next
{
    self.customNavigationBar.customNavigationItem.rightBarButtonItems = [self.class barButtonItemsTitles:titles edgeInsetsLeft:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

+ (NSArray <UIBarButtonItem *>*)barButtonItemsTitles:(NSArray<NSDictionary *> *)titles edgeInsetsLeft:(CGFloat)left subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSDictionary *dic in titles) {
        NSString *title = dic.allValues.firstObject;
        NSDictionary *dic = @{
                              @(kHSYCocoaKitOfButtonPropretyTypeNorTitle) : title,
                              @(kHSYCocoaKitOfButtonPropretyTypeHighTitle) : title,
                              };
        UIButton *button = [NSObject createButtonByParam:dic clickedOnSubscribeNext:^(UIButton *button) {
            if (next) {
                next(button, ((kHSYCustomBarButtonItemTag)button.tag));
            }
        }];
        button.size = CGSizeMake(DEFAULT_BUTTOM_SIZE, DEFAULT_BUTTOM_SIZE);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
        button.tag = (kHSYCustomBarButtonItemTag)[dic.allKeys.firstObject integerValue];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [items addObject:buttonItem];
    }
    return items;
}

@end
