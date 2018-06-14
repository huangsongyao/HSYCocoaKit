//
//  HSYHUDHelper.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define HUD_SUCCESS_TEXT                    @"成功"              //成功的文字提示
#define HUD_FAILURE                         @"失败"              //失败的文字提示
#define HUD_WAIT_TEXT                       @"加载中..."         //加载中的文字提示
#define HUD_PULL_DOWN_SUCCESS_TEXT          @""
#define HUD_PULL_UP_SUCCESS_TEXT            @""

#define HUD_SHOW_TIME                       0.5f                //展示时间
#define HUD_HIDE_TIME                       -1                  //加载时间
#define HUD_STRING_DISPLAY_TIME             3.0f                //提示时间

typedef NS_ENUM(NSUInteger, kShowHUDViewType) {
    
    kShowHUDViewTypeDefault         = 0,    //默认类型
    kShowHUDViewTypeWait            = 2,    //等待
    kShowHUDViewTypeText            = 4,    //文字
    kShowHUDViewTypeCustom          = 6,    //自定义
    
};

@interface HSYHUDHelper : NSObject

+ (instancetype)shareInstance;

/**
 *  HUD文字提示
 *
 *  @param message 提示信息
 *
 *  @return HUD
 */
+ (MBProgressHUD *)hsy_showHUDViewForMessage:(NSString *)message;

/**
 HUD定制视图

 @param view 定制的视图
 @return HUD
 */
+ (MBProgressHUD *)hsy_showHUDViewForCustomView:(UIView *)view;

/**
 *  初始化一个HUD，不允许触屏取消
 *
 *  @param showType 展示类型，枚举
 *  @param text     展示文字内容
 *  @param time     展示时间
 *
 *  @return MBProgressHUD对象
 */
+ (MBProgressHUD *)hsy_showHUDViewForShowType:(kShowHUDViewType)showType
                                         text:(NSString *)text
                                    hideAfter:(CGFloat)time;

/**
 *  取消HUD
 */
+ (void)hsy_hideHUDView;

/**
 *  设置HUD的动画类型
 *
 *  @param animationType 动画类型，枚举
 */
+ (void)hsy_setHUDAnimationType:(MBProgressHUDAnimation)animationType;


@end
