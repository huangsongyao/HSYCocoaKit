//
//  UIAlertController+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
#import "PublicMacroFile.h"

@interface UIAlertAction (Tag)

/**
 给UIAlertAction添加一个RACTuple属性成员，用于优化RAC格式下的一体式回调，developer可以直接根据“hsy_alertActionTuple”的first对象，获取到该UIAlertAction在list中的位置
 */
@property (nonatomic, strong) RACTuple *hsy_alertActionTuple;

@end

@interface UIAlertController (RACSignal)

/**
 alert show
 
 @param viewController 所展示的视图控制器
 @param title title
 @param message message
 @param alertActionTitles alertAction的title的list
 @return RACSignal点击事件的信号
 */
+ (RACSignal *)hsy_rac_showAlertController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)alertActionTitles NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);


/**
 sheet show
 
 @param viewController 所展示的视图控制器
 @param title title
 @param message message
 @param sheetActionTitles alertAction的title的list
 @return RACSignal点击事件的信号
 */
+ (RACSignal *)hsy_rac_showSheetController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)sheetActionTitles NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);


@end
