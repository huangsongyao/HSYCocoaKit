//
//  UIScrollView+Page.h
//  高仿暴走斗图
//
//  Created by huangsongyao on 16/3/7.
//  Copyright © 2016年 huangsongyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitScrollDirection) {

    kHSYCocoaKitScrollDirectionToUp             = 47,   //向上滑动
    kHSYCocoaKitScrollDirectionToDown,                  //向下滑动
    kHSYCocoaKitScrollDirectionToLeft,                  //向左滑动
    kHSYCocoaKitScrollDirectionToRight,                 //向右滑动
};

@interface UIScrollView (Page)

- (NSInteger)pages;                                         //获取scrollView的总页面数
- (NSInteger)currentPage;                                   //获取scrollView的当前的页码
- (CGFloat)scrollPercent;                                   //获取scrollView的百分比

- (CGFloat)pagesY;                                          //获取scrollView的页面的y点坐标
- (CGFloat)pagesX;                                          //获取scrollView的页面的x点坐标

- (CGFloat)currentPageY;                                    //获取scrollView的当前页面的y点坐标
- (CGFloat)currentPageX;                                    //获取scrollView的当前页面的x点坐标

- (CGFloat)contentSizeWidth;                                //获取scrollView的滚动宽度
- (CGFloat)contentSizeHeight;                               //获取scrollView的滚动高度

/**
 上下方向翻页，无动画

 @param page 设置翻页的页码
 */
- (void)setYPage:(NSInteger)page;;

/**
 左右方向翻页，无动画

 @param page 设置翻页的页码
 */
- (void)setXPage:(NSInteger)page;

/**
 上下方向翻页

 @param page 设置翻页的页码
 @param animated 是否执行动画
 */
- (void)setYPage:(NSInteger)page animated:(BOOL)animated;

/**
 左右方向翻页
 
 @param page 设置翻页的页码
 @param animated 是否执行动画
 */
- (void)setXPage:(NSInteger)page animated:(BOOL)animated;

- (kHSYCocoaKitScrollDirection)scrollHorizontalDirection;
- (kHSYCocoaKitScrollDirection)scrollVerticalDirection;

@end
