//
//  UIView+DrawPictures.m
//  Pods
//
//  Created by huangsongyao on 2018/4/17.
//
//

#import "UIView+DrawPictures.h"
#import "UIView+Frame.h"

@implementation UIView (DrawPictures)

- (UIView *)snapshot
{
    return [UIView snapshotFromView:self];
}

+ (UIView *)snapshotFromView:(UIView *)view
{
    if (!view) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *snapshotImageView = [[UIImageView alloc] initWithImage:image];
    snapshotImageView.center = view.center;
    snapshotImageView.layer.masksToBounds = NO;
    snapshotImageView.layer.cornerRadius = view.layer.cornerRadius;
    snapshotImageView.layer.shadowOffset = view.layer.shadowOffset;
    snapshotImageView.layer.shadowRadius = view.layer.shadowRadius;
    snapshotImageView.layer.shadowOpacity = view.layer.shadowOpacity;
    
    UIView *snapshotView = [[UIView alloc] initWithFrame:snapshotImageView.frame];
    snapshotImageView.origin = CGPointZero;
    [snapshotView addSubview:snapshotImageView];
    
    return snapshotView;
}


@end
