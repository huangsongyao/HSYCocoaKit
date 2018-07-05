//
//  HSYBaseViewController+CustomNavigationItem.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYBaseViewController+CustomNavigationItem.h"

@implementation HSYBaseViewController (CustomNavigationItem)

- (void)hsy_leftItemsImages:(NSArray<NSDictionary *> *)images subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsImages:images edgeInsetsLeft:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_rightItemsImages:(NSArray<NSDictionary *> *)images subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsImages:images edgeInsetsLeft:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsTitles:titles edgeInsetsLeft:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsTitles:titles edgeInsetsLeft:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles titleColors:(NSArray<UIColor *> *)titleColors titleFonts:(NSArray<UIFont *> *)titleFonts subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsTitles:titles titleColors:titleColors titleFonts:titleFonts edgeInsetsLeft:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles titleColors:(NSArray<UIColor *> *)titleColors titleFonts:(NSArray<UIFont *> *)titleFonts subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsTitles:titles titleColors:titleColors titleFonts:titleFonts edgeInsetsLeft:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

@end
