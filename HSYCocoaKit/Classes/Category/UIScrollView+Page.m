//
//  UIScrollView+Page.m
//  高仿暴走斗图
//
//  Created by huangsongyao on 16/3/7.
//  Copyright © 2016年 huangsongyao. All rights reserved.
//

#import "UIScrollView+Page.h"
#import "UIView+Frame.h"

@implementation UIScrollView (Page)

- (NSInteger)pages
{
    NSInteger pages = self.contentSize.width/self.width;
    return pages;
}

- (NSInteger)currentPage
{
    NSInteger pages = self.contentSize.width/self.width;
    CGFloat scrollPercent = [self scrollPercent];
    NSInteger currentPage = (NSInteger)roundf((pages-1) * scrollPercent);
    return currentPage;
}

- (CGFloat)scrollPercent
{
    CGFloat width = self.contentSize.width - self.width;
    CGFloat scrollPercent = self.contentOffset.x/width;
    return scrollPercent;
}

- (CGFloat)pagesY
{
    CGFloat pageHeight = self.height;
    CGFloat contentHeight = self.contentSize.height;
    return contentHeight/pageHeight;
}

- (CGFloat)pagesX
{
    CGFloat pageWidth = self.width;
    CGFloat contentWidth = self.contentSize.width;
    return contentWidth/pageWidth;
}

- (CGFloat)currentPageY
{
    CGFloat pageHeight = self.height;
    CGFloat offsetY = self.contentOffset.y;
    return offsetY / pageHeight;
}

- (CGFloat)currentPageX
{
    CGFloat pageWidth = self.width;
    CGFloat offsetX = self.contentOffset.x;
    return offsetX / pageWidth;
}

- (CGFloat)contentSizeWidth
{
    return self.contentSize.width;
}

- (CGFloat)contentSizeHeight
{
    return self.contentSize.height;
}

- (void)setPageY:(CGFloat)page
{
    [self setPageY:page animated:NO];
}

- (void)setPageX:(CGFloat)page
{
    [self setPageX:page animated:NO];
}

- (void)setPageY:(CGFloat)page animated:(BOOL)animated
{
    CGFloat pageHeight = self.height;
    CGFloat offsetY = page * pageHeight;
    CGFloat offsetX = self.contentOffset.x;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self setContentOffset:offset animated:animated];
}

- (void)setPageX:(CGFloat)page animated:(BOOL)animated
{
    CGFloat pageWidth = self.width;
    CGFloat offsetY = self.contentOffset.y;
    CGFloat offsetX = page * pageWidth;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self setContentOffset:offset animated:animated];
}


@end
