//
//  UIViewController+Shadow.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "UIViewController+Shadow.h"

@implementation UIViewController (Shadow)

- (void)setShadowForColorRef:(CGColorRef)ref shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius
{
    self.view.layer.shadowColor = ref;
    self.view.layer.shadowOpacity = opacity;
    self.view.layer.shadowRadius = radius;
}


@end
