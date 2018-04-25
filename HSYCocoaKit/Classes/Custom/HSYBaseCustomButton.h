//
//  HSYBaseCustomButton.h
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitCustomButtonPropertyType) {
    
    kHSYCocoaKitCustomButtonPropertyTypeImage = 2315,               //UIImage
    kHSYCocoaKitCustomButtonPropertyTypeHighImage,                  //UIImage
    kHSYCocoaKitCustomButtonPropertyTypeTitle,                      //NSString
    kHSYCocoaKitCustomButtonPropertyTypeFont,                       //UIFont
    kHSYCocoaKitCustomButtonPropertyTypeTextColor,                  //UIColor
    kHSYCocoaKitCustomButtonPropertyTypeHighTextColor,              //UIColor
    
};

@interface HSYBaseCustomButton : UIButton

@end

@interface HSYBaseCustomButton (Show)

/**
 创建方法

 @param frame button的frame
 @param imageRect button上的image的frame
 @param titleRect button上的title的frame
 @param propertyEnum button的属性设置
 @param block 点击回调事件
 @return HSYBaseCustomButton
 */
+ (HSYBaseCustomButton *)showCustomButtonForFrame:(CGRect)frame
                                        imageRect:(CGRect)imageRect
                                        titleRect:(CGRect)titleRect
                                     propertyEnum:(NSDictionary<NSNumber *, id> *)propertyEnum
                                 didSelectedBlock:(void(^)(HSYBaseCustomButton *btn))block;

@end


