//
//  UINavigationBar+Background.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "UINavigationBar+Background.h"
#import "UIImage+Canvas.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"

static NSInteger const kHSYCocoaKitNavigationBarBottomLintDefaultTag = 19911;

@implementation UINavigationBar (Background)

- (void)setNavigationBarBackgroundImage:(UIImage *)backgroundImage
{
    UIImage *image = backgroundImage;
    if (!image) {
        image = [UIImage imageWithFillColor:WHITE_COLOR];
    }
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)clearNavigationBarBottomLine
{
    [self setBarBottomLineOfColor:CLEAR_COLOR tag:kHSYCocoaKitNavigationBarBottomLintDefaultTag];
}

- (void)setBarBottomLineOfColor:(UIColor *)color tag:(NSInteger)tag
{
    [self setShadowImage:[UIImage imageWithFillColor:[UIColor clearColor]]];
    CGFloat height = 1.0f;
    UIView *lineView = [self viewWithTag:tag];
    if (!lineView) {
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - height, self.width, height)];
        lineView.tag = tag;
    }
    lineView.backgroundColor = color;
    [self addSubview:lineView];
}

@end
