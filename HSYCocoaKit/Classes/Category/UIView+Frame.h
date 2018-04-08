//
//  UIView+Frame.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (CGPoint)origin;                                      //[x, y]坐标
- (CGFloat)x;                                           //x坐标
- (CGFloat)y;                                           //y坐标
- (CGFloat)right;                                       //x + w
- (CGFloat)bottom;                                      //y + h
- (CGFloat)mid_x;                                       //x + w/2
- (CGFloat)mid_y;                                       //y + h/2

- (CGSize)size;                                         //视图size
- (CGFloat)height;                                      //高度
- (CGFloat)width;                                       //宽度

- (void)setSize:(CGSize)size;                           //设置size
- (void)setWidth:(CGFloat)width;                        //设置宽度
- (void)setHeight:(CGFloat)height;                      //设置高度

- (void)setOrigin:(CGPoint)origin;                      //设置[x, y]坐标
- (void)setX:(CGFloat)x;                                //设置x坐标
- (void)setY:(CGFloat)y;                                //设置y坐标

/**
 origin为CGRectZero的初始化

 @param size size
 @return self
 */
- (instancetype)initWithSize:(CGSize)size;

@end
