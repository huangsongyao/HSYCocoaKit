//
//  UIView+Frame.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - Init

- (instancetype)initWithSize:(CGSize)size
{
    CGRect rect = (CGRect){CGPointZero, size};
    return [self initWithFrame:rect];
}

#pragma mark - Get Property

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)x
{
    return self.origin.x;
}

- (CGFloat)y
{
    return self.origin.y;
}

- (CGFloat)right
{
    return self.x + self.width;
}

- (CGFloat)bottom
{
    return self.y + self.height;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)height
{
    return self.size.height;
}

- (CGFloat)width
{
    return self.size.width;
}

- (CGFloat)mid_x
{
    return (self.x + (self.width / 2));
}

- (CGFloat)mid_y
{
    return (self.y + (self.height / 2));
}

#pragma mark - Set Origin

- (void)setOrigin:(CGPoint)origin
{
    self.frame = (CGRect){origin, self.size};
}

- (void)setX:(CGFloat)x
{
    [self setOrigin:CGPointMake(x, self.y)];
}

- (void)setY:(CGFloat)y
{
    [self setOrigin:CGPointMake(self.x, y)];
}

#pragma mark - Set Size

- (void)setSize:(CGSize)size
{
    self.frame = (CGRect){self.origin, size};
}

- (void)setWidth:(CGFloat)width
{
    [self setSize:CGSizeMake(width, self.height)];
}

- (void)setHeight:(CGFloat)height
{
    [self setSize:CGSizeMake(self.width, height)];
}


@end
