//
//  UIView+DrawPictures.h
//  Pods
//
//  Created by huangsongyao on 2018/4/17.
//
//

#import <UIKit/UIKit.h>

@interface UIView (DrawPictures)

/**
 把视图绘制成一张图片
 
 @return 根据视图绘制出的图片，此图片已经addSubview到一个新的视图上，返回的是该super的视图
 */
- (UIView *)snapshot;

@end
