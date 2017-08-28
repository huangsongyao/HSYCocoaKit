//
//  UIScrollView+Page.h
//  高仿暴走斗图
//
//  Created by huangsongyao on 16/3/7.
//  Copyright © 2016年 huangsongyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Page)

- (NSInteger)pages;                                         //获取scrollView的总页面数
- (NSInteger)currentPage;                                   //获取scrollView的当前的页码
- (CGFloat)scrollPercent;                                   //获取scrollView的百分比

- (CGFloat)pagesY;                                          //获取scrollView的页面的y点坐标
- (CGFloat)pagesX;                                          //获取scrollView的页面的x点坐标

- (CGFloat)currentPageY;                                    //获取scrollView的当前页面的y点坐标
- (CGFloat)currentPageX;                                    //获取scrollView的当前页面的x点坐标


/**
 *  上下方向翻页，无动画
 *
 *  @return 设置翻页的页码
 */
- (void)setPageY:(CGFloat)page;

/**
 *  左右方向翻页，无动画
 *
 *  @return 设置翻页的页码
 */
- (void)setPageX:(CGFloat)page;

/**
 *  上下方向翻页
 *
 *  @param animated  是否有动画
 */
- (void)setPageY:(CGFloat)page animated:(BOOL)animated;

/**
 *  左右方向翻页
 *
 *  @param animated  是否有动画
 */
- (void)setPageX:(CGFloat)page animated:(BOOL)animated;

@end
