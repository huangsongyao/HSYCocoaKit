//
//  UIViewController+SystemShare.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2019/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RACSignal;
@interface UIViewController (SystemShare)

/**
 iOS系统分享调起

 @param shareItems 数组内的对象代表的是我们想要操作的数据的一些属性，而且这个数组至少需要一个值
 @param result 回调分享结果
 */
- (void)hsy_systemShare:(NSArray *)shareItems shareResult:(RACSignal *(^)(BOOL shared, UIActivityType activityType, NSError *activityError))result;

/**
 iOS系统分享调起

 @param shareItems 数组内的对象代表的是我们想要操作的数据的一些属性，而且这个数组至少需要一个值
 @param activitis 数组指定了泛型，数组内的对象必须是UIActivity类型的对象
 @param result 回调分享结果
 */
- (void)hsy_systemShare:(NSArray *)shareItems applicationActivities:(NSArray<UIActivity *> *)activitis shareResult:(RACSignal *(^)(BOOL shared, UIActivityType activityType, NSError *activityError))result;

@end

NS_ASSUME_NONNULL_END
