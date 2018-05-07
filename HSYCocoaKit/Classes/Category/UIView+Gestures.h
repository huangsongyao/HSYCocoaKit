//
//  UIView+Gestures.h
//  Pods
//
//  Created by huangsongyao on 2018/5/7.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Gestures)

- (void)hsy_addTapGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UITapGestureRecognizer *gesture))next;

@end
