//
//  UIView+Frame.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, readwrite) CGFloat x;             //view的x坐标
@property (nonatomic, readwrite) CGFloat y;             //view的y坐标
@property (nonatomic, readwrite) CGPoint point;         //view的(x,y)坐标点
@property (nonatomic, readwrite) CGFloat width;         //view的宽度
@property (nonatomic, readwrite) CGFloat height;        //view的高度
@property (nonatomic, readwrite) CGSize size;           //view的(width,height)尺寸
@property (nonatomic, readwrite) CGFloat center_x;      //view的中心点x点坐标
@property (nonatomic, readwrite) CGFloat center_y;      //view的中心点y点坐标

@property (nonatomic, readonly) CGFloat mid_x;          //view的x坐标+w的一半
@property (nonatomic, readonly) CGFloat mid_y;          //view的y坐标+h的一半
@property (nonatomic, readonly) CGFloat max_x;          //view的x坐标+w
@property (nonatomic, readonly) CGFloat max_y;          //view的y坐标+h
@property (nonatomic, readonly) CGFloat min_x;          //view的x坐标
@property (nonatomic, readonly) CGFloat min_y;          //view的y坐标

- (void)setViewX:(CGFloat)x;
- (void)setViewY:(CGFloat)y;
- (void)setViewPoint:(CGPoint)point;
- (void)setViewWidth:(CGFloat)width;
- (void)setViewHeight:(CGFloat)height;
- (void)setViewSize:(CGSize)size;
- (void)setViewCenterX:(CGFloat)centerX;
- (void)setViewCenterY:(CGFloat)centerY;

@end
