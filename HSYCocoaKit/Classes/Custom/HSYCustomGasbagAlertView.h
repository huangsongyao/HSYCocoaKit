//
//  HSYCustomGasbagAlertView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/19.
//

#import "HSYCustomWindows.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitGasbagAlertType) {
    
    kHSYCocoaKitGasbagAlertTypeTop              = 2722, //从顶部向底部的气囊动画
    kHSYCocoaKitGasbagAlertTypeBottom,                  //从底部想顶部的气囊动画
    kHSYCocoaKitGasbagAlertTypeLeft,                    //从左上角向右下角的气囊动画
    kHSYCocoaKitGasbagAlertTypeRight,                   //从右上角向左下角的气囊动画
    
};

@interface HSYCustomGasbagObject : NSObject

@property (nonatomic, copy) NSString *hsy_title;
@property (nonatomic, strong) NSDictionary *hsy_dictionary;
@property (nonatomic, strong) id hsy_object;
@property (nonatomic, strong) NSArray *hsy_array;

@end


@interface HSYCustomGasbagAlertView : HSYCustomWindows

@property (nonatomic, copy) void(^hsy_didSelectedRow)(HSYCustomGasbagObject *x);

/**
 初始化，默认为kHSYCocoaKitGasbagAlertTypeBottom格式

 @param backgroundImage 主体小窗口背景图
 @param position 锚点下的位置
 @return HSYCustomGasbagAlertView
 */
- (instancetype)initWithDefaultBackgroundImage:(UIImage *)backgroundImage position:(CGPoint)position;

/**
 初始化

 @param backgroundImage 主体小窗口背景图
 @param position 锚点下的位置
 @param type 气囊的方向枚举
 @return HSYCustomGasbagAlertView
 */
- (instancetype)initWithBackgroundImage:(UIImage *)backgroundImage position:(CGPoint)position anchorType:(kHSYCocoaKitGasbagAlertType)type;

/**
 show方法
 */
- (void)hsy_showGasbag;

/**
 remove方法
 */
- (void)hsy_removeGasbag;

/**
 通过枚举类型返回对应锚点

 @param type 枚举类型
 @return 锚点位置
 */
+ (CGPoint)hsy_anchorPoint:(kHSYCocoaKitGasbagAlertType)type;

@end

@interface HSYCustomGasbagAlertView (HSYCocoaKit)

/**
 快速方法

 @param dataSources 数据源
 @param backgroundImage 主体小窗口背景图
 @param position 锚点下的位置
 @param type 气囊动画类型
 @param block 点击回调事件
 @return HSYCustomGasbagAlertView
 */
+ (HSYCustomGasbagAlertView *)hsy_showGasbagAlert:(NSArray *)dataSources backgroundImage:(UIImage *)backgroundImage position:(CGPoint)position anchorType:(kHSYCocoaKitGasbagAlertType)type didSelectedRowBlock:(void(^)(HSYCustomGasbagObject *x))block;

@end



