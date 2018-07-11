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

- (void)hsy_leftItemsImages:(NSArray<NSDictionary *> *)images
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsImages:images left:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_leftItemsImages:(NSArray<NSDictionary *> *)images
                       left:(CGFloat)left
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsImages:images edgeInsetsLeft:left subscribeNext:next];
}

- (void)hsy_leftItemsImages:(NSArray<NSDictionary *> *)images
                 highImages:(NSArray<NSDictionary *> *)highImages
                       left:(CGFloat)left
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsImages:images highImages:highImages edgeInsetsLeft:left subscribeNext:next];
}

- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles
                titleColors:(NSArray<UIColor *> *)titleColors
                 titleFonts:(NSArray<UIFont *> *)titleFonts
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsTitles:titles titleColors:titleColors titleFonts:titleFonts left:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles
                titleColors:(NSArray<UIColor *> *)titleColors
                 titleFonts:(NSArray<UIFont *> *)titleFonts
                       left:(CGFloat)left
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsTitles:titles titleColors:titleColors titleFonts:titleFonts edgeInsetsLeft:left subscribeNext:next];
}

- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsTitles:titles left:-DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles
                       left:(CGFloat)left
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.leftBarButtonItems = [self.class hsy_barButtonItemsTitles:titles edgeInsetsLeft:left subscribeNext:next];
}

#pragma mark - Right Double BarButton

- (void)hsy_rightItemsImages:(NSArray<NSDictionary *> *)images
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsImages:images left:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_rightItemsImages:(NSArray<NSDictionary *> *)images
                        left:(CGFloat)left
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsImages:images edgeInsetsLeft:left subscribeNext:next];
}

- (void)hsy_rightItemsImages:(NSArray<NSDictionary *> *)images
                  highImages:(NSArray<NSDictionary *> *)highImages
                        left:(CGFloat)left
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsImages:images highImages:highImages edgeInsetsLeft:left subscribeNext:next];
}

- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsTitles:titles left:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles
                        left:(CGFloat)left
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsTitles:titles edgeInsetsLeft:left subscribeNext:next];
}

- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles
                 titleColors:(NSArray<UIColor *> *)titleColors
                  titleFonts:(NSArray<UIFont *> *)titleFonts
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsTitles:titles titleColors:titleColors titleFonts:titleFonts left:DEFAULT_BUTTOM_EDGE_INSETS_LEFT subscribeNext:next];
}

- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles
                 titleColors:(NSArray<UIColor *> *)titleColors
                  titleFonts:(NSArray<UIFont *> *)titleFonts
                        left:(CGFloat)left
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    self.hsy_customNavigationBarNavigationItem.rightBarButtonItems = [self.class hsy_barButtonItemsTitles:titles titleColors:titleColors titleFonts:titleFonts edgeInsetsLeft:left subscribeNext:next];
}

#pragma mark - Left Single BarButton

- (void)hsy_leftItemTitleParamter:(NSDictionary *)titleParamter
                       titleColor:(UIColor *)titleColor
                        titleFont:(UIFont *)titleFont
                    subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsTitles:@[titleParamter] titleColors:@[titleColor] titleFonts:@[titleFont] subscribeNext:next];
}

- (void)hsy_leftItemTitleParamter:(NSDictionary *)titleParamter
                       titleColor:(UIColor *)titleColor
                        titleFont:(UIFont *)titleFont
                             left:(CGFloat)left
                    subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsTitles:@[titleParamter] titleColors:@[titleColor] titleFonts:@[titleFont] left:left subscribeNext:next];
}

- (void)hsy_leftItemImageParamter:(NSDictionary *)imageParamter
                    subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsImages:@[imageParamter] subscribeNext:next];
}

- (void)hsy_leftItemImageParamter:(NSDictionary *)imageParamter
                             left:(CGFloat)left
                    subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsImages:@[imageParamter] left:left subscribeNext:next];
}

- (void)hsy_leftItemImageParamter:(NSDictionary *)imageParamter
                highImageParamter:(NSDictionary *)highImageParamter
                             left:(CGFloat)left
                    subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_leftItemsImages:@[imageParamter] highImages:@[highImageParamter] left:left subscribeNext:next];
}

#pragma mark - Right Single BarButton

- (void)hsy_rightItemTitleParamter:(NSDictionary *)titleParamter
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                     subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsTitles:@[titleParamter] titleColors:@[titleColor] titleFonts:@[titleFont] subscribeNext:next];
}

- (void)hsy_rightItemTitleParamter:(NSDictionary *)titleParamter
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                              left:(CGFloat)left
                     subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsTitles:@[titleParamter] titleColors:@[titleColor] titleFonts:@[titleFont] left:left subscribeNext:next];
}

- (void)hsy_rightItemImageParamter:(NSDictionary *)imageParamter
                     subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsImages:@[imageParamter] subscribeNext:next];
}

- (void)hsy_rightItemImageParamter:(NSDictionary *)imageParamter
                              left:(CGFloat)left
                     subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsImages:@[imageParamter] left:left subscribeNext:next];
}

- (void)hsy_rightItemImageParamter:(NSDictionary *)imageParamter
                 highImageParamter:(NSDictionary *)highImageParamter
                              left:(CGFloat)left
                     subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    [self hsy_rightItemsImages:@[imageParamter] highImages:@[highImageParamter] left:left subscribeNext:next];
}


@end
