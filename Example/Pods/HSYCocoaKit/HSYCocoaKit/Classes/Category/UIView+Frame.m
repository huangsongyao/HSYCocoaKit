//
//  UIView+Frame.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

@dynamic x;
@dynamic y;
@dynamic point;
@dynamic width;
@dynamic height;
@dynamic size;
@dynamic center_x;
@dynamic center_y;

- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (void)setViewX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect = CGRectMake(x, CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
    self.frame = rect;
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (void)setViewY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect = CGRectMake(CGRectGetMinX(rect), y, CGRectGetWidth(rect), CGRectGetHeight(rect));
    self.frame = rect;
}

- (CGPoint)point
{
    return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
}

- (void)setViewPoint:(CGPoint)point
{
    self.x = point.x;
    self.y = point.y;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setViewWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), width, CGRectGetHeight(rect));
    self.frame = rect;
}

- (CGFloat)height
{    
    return CGRectGetHeight(self.frame);
}

- (void)setViewHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), height);
    self.frame = rect;
}

- (CGSize)size
{
    return CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setViewSize:(CGSize)size
{
    self.width = size.width;
    self.height = size.height;
}

- (CGFloat)center_x
{
    return self.center.x;
}

- (void)setViewCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)center_y
{
    return self.center.y;
}

- (void)setViewCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark -
#pragma mark - Azimuthal Coordinates

- (CGFloat)mid_x
{    
    return CGRectGetMidX(self.frame);
}

- (CGFloat)mid_y
{
    return CGRectGetMidY(self.frame);
}

- (CGFloat)max_x
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)max_y
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)min_x
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)min_y
{
    return CGRectGetMinY(self.frame);
}



@end
