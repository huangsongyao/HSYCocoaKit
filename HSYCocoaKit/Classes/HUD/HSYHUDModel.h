//
//  HSYHUDModel.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "HSYHUDHelper.h"

typedef NS_ENUM(NSUInteger, kHSYHUDModelCodeType) {
    
    kHSYHUDModelCodeTypeDefault                     = 0,        //默认类型
    
    kHSYHUDModelCodeTypeRequestSuccess              = 1,        //http请求成功
    kHSYHUDModelCodeTypeRequestFailure              = 2,        //http请求失败
    kHSYHUDModelCodeTypeUpdateLoading               = 3,        //http请求中。。。
    
    kHSYHUDModelCodeTypeSaveFileFailure             = 4,        //上传文件失败
    kHSYHUDModelCodeTypeSaveFileSuccess             = 5,        //上传文件成功
    kHSYHUDModelCodeTypeSaveFileLoading             = 6,        //上传文件中。。。
    
    kHSYHUDModelCodeTypeRequestPullUpSuccess        = 7,        //http请求上拉加载更多成功
    kHSYHUDModelCodeTypeRequestPullDownSuccess      = 8,        //http请求下拉更新成功
    
};

@interface HSYHUDModel : NSObject

@property (nonatomic, assign) kShowHUDViewType showType;                //hudView的model类型
@property (nonatomic, copy) NSString *hudString;                        //hudView的文字
@property (nonatomic, assign) CGFloat animationTime;                    //动画时长
@property (nonatomic, assign) kHSYHUDModelCodeType codeType;            //编码类型
@property (nonatomic, assign) BOOL showPromptContent;                   //是否提示内容，默认为提示

/**
 *  初始化一个HUD
 *
 *  @param codeType HUD类型
 *
 *  @return 返回一个HUD
 */
+ (instancetype)initWithCodeType:(kHSYHUDModelCodeType)codeType;

/**
 *  初始化一个HUDModel对象
 *
 *  @param showType      HUD展示类型，枚举
 *  @param codeType      HUD请求类型，枚举
 *  @param text          HUD展示文字
 *  @param animationTime HUD展示动画时间
 *
 *  @return HUDModel对象
 */
+ (instancetype)initWithShowHUDType:(kShowHUDViewType)showType codeType:(kHSYHUDModelCodeType)codeType text:(NSString *)text animationTime:(CGFloat)animationTime;

@end
