//
//  HSYCustomGestureView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/14.
//

#import <UIKit/UIKit.h>

@class RACSignal;
@interface HSYCustomGestureView : UIView <UIGestureRecognizerDelegate>

/**
 添加单指单击手势到self的视图层

 @return 响应事件
 */
- (RACSignal *)hsy_addSingleGesture;

/**
 添加单指双击手势到self的视图层

 @return 响应事件
 */
- (RACSignal *)hsy_addDoubleGesture;

@end
