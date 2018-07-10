//
//  HSYBaseViewController+CustomNavigationItem.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYBaseViewController+CustomNavigationItem.h"

@implementation HSYBaseViewController (CustomNavigationItem)

#pragma mark - Left Double BarButton

- (void)hsy_leftItemsImages:(NSArray<NSDictionary *> *)images subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsImages:images edgeInsetsLeft:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles titleColors:(NSArray<UIColor *> *)titleColors titleFonts:(NSArray<UIFont *> *)titleFonts subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsTitles:titles titleColors:titleColors titleFonts:titleFonts edgeInsetsLeft:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsTitles:titles edgeInsetsLeft:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

#pragma mark - Right Double BarButton

- (void)hsy_rightItemsImages:(NSArray<NSDictionary *> *)images subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsImages:images edgeInsetsLeft:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsTitles:titles edgeInsetsLeft:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles titleColors:(NSArray<UIColor *> *)titleColors titleFonts:(NSArray<UIFont *> *)titleFonts subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsTitles:titles titleColors:titleColors titleFonts:titleFonts edgeInsetsLeft:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

#pragma mark - Left Single BarButton

- (void)hsy_leftItemTitleParamter:(NSDictionary *)titleParamter titleColorParamter:(UIColor *)titleColorParamter titleFontParamter:(UIFont *)titleFontParamter subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsTitles:@[titleParamter] titleColors:@[titleColorParamter] titleFonts:@[titleFontParamter] subscribeNext:next];
}

- (void)hsy_leftItemImageParamter:(NSDictionary *)imageParamter subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsImages:@[imageParamter] subscribeNext:next];
}

#pragma mark - Right Single BarButton

- (void)hsy_rightItemTitleParamter:(NSDictionary *)titleParamter titleColorParamter:(UIColor *)titleColorParamter titleFontParamter:(UIFont *)titleFontParamter subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsTitles:@[titleParamter] titleColors:@[titleColorParamter] titleFonts:@[titleFontParamter] subscribeNext:next];
}

- (void)hsy_rightItemImageParamter:(NSDictionary *)imageParamter subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsImages:@[imageParamter] subscribeNext:next];
}

@end
