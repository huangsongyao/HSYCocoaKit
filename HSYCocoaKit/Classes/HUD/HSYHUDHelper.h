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

#define HUD_SUCCESS_TEXT                    @"加载成功"
#define HUD_FAILURE                         @"加载失败"

#define HUD_REQUEST_FAILURE                 @"请求失败！"
#define HUD_REQUEST_SUCCESS                 @"请求成功！"

#define HUD_SAVE_FAILURE                    @"保存失败！"
#define HUD_SAVE_SUCCESS                    @"保存成功！"

#define HUD_LOADING_DATA                    @"数据更新中..."
#define HUD_LOADING_FILE                    @"文件保存中..."

#define HUD_PULL_DOWN_SUCCESS_TEXT          @"已为您更新了信息！"
#define HUD_PULL_UP_SUCCESS_TEXT            @"加载下一页的数据成功！"         

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
 *  初始化文字[Text]类型HUD，并添加至window层显示，默认显示时间为：HUD_STRING_DISPLAY_TIME
 *
 *  @param message 提示信息
 *
 *  @return HUD
 */
+ (MBProgressHUD *)hsy_showHUDViewForMessage:(NSString *)message;

/**
 初始化文字[Text]类型HUD，并添加至window层显示
 
 @param message 提示信息
 @param time 显示时间
 @return HUD
 */
+ (MBProgressHUD *)hsy_showHUDViewForMessage:(NSString *)message hideAfter:(CGFloat)time;

/**
 初始化[Custom]视图类型的HUD，并添加至window层显示，默认显示时间为：HUD_STRING_DISPLAY_TIME

 @param view 定制的视图
 @return HUD
 */
+ (MBProgressHUD *)hsy_showHUDViewForCustomView:(UIView *)view;

/**
 初始化[Custom]视图类型的HUD，并添加至window层显示
 
 @param view 定制的视图
 @param time 显示时间
 @return HUD
 */
+ (MBProgressHUD *)hsy_showHUDViewForCustomView:(UIView *)view hideAfter:(CGFloat)time;

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
 loading格式的HUD

 @return MBProgressHUD对象
 */
+ (MBProgressHUD *)hsy_loadingHUDView;

/**
 *  取消HUD
 */
+ (void)hsy_hideHUDView;

/**
 使用kvc设置HUD属性，key值必须保持为和属性名称一致的NSString

 @param paramter HUD属性参数
 */
- (void)hsy_setParamter:(NSDictionary<NSString *, id> *)paramter;


@end
