//
//  HSYNavigationController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <UIKit/UIKit.h>

@interface HSYNavigationController : UINavigationController <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) BOOL fullScreenPop;

@end
