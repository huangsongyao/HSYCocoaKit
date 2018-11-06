//
//  HSYBaseSegmentedPageControl.h
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import <UIKit/UIKit.h>
#import "HSYBaseCustomButton.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitCustomSegmentedType) {
    
    kHSYCocoaKitCustomSegmentedTypeTitleFont            = 7888,         //正常的字体--UIFont
    kHSYCocoaKitCustomSegmentedTypeSelectedTitleFont,                   //选中后的字体--UIFont
    kHSYCocoaKitCustomSegmentedTypeNorTitleColor,                       //未选中的字体颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeSelTitleColor,                       //选中后的字体颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeLineColor,                           //选中的下划线颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeLineSize,                            //选中的下划线size--NSValue--CGSize
    kHSYCocoaKitCustomSegmentedTypeLineRoundedCorners,                  //选中的是否使用圆角--NSNumber
    kHSYCocoaKitCustomSegmentedTypeButtonSize,                          //按钮点击区域--NSValue--CGSize
    kHSYCocoaKitCustomSegmentedTypeButtonSpacing,                       //按钮间距--NSNumber--CGFloat
    kHSYCocoaKitCustomSegmentedTypeBackgroundImage,                     //背景图片--UIImage
    kHSYCocoaKitCustomSegmentedTypeSelectedIndex,                       //选中位置--NSNumber
    kHSYCocoaKitCustomSegmentedTypeAnimationDuration,                   //动画时间--NSNumber
    kHSYCocoaKitCustomSegmentedTypeShowBottomLine,                      //是否底部的横线--NSNumber
    kHSYCocoaKitCustomSegmentedTypeBottomLineSize,                      //底部横线的size--NSValue--CGSize
    kHSYCocoaKitCustomSegmentedTypeBottomLineColor,                     //底部横线的颜色--UIColor
    
};

@interface HSYBaseSegmentedPageControl : UIView

@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseCustomButton *> *segmentedButton;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, setter=setCurrentSelectedItem:) NSInteger selectedIndex;

/**
 外部设置横线的比例进度

 @param scale [0, 1]闭区间，为当前手势交互的滚动范围的映射
 */
- (void)hsy_setContentOffsetFromScale:(CGFloat)scale;

/**
 外部设置button的点击方法
 
 @param button button
 @param animation 是否開啟動畫
 */
- (void)hsy_scrollToSelected:(HSYBaseCustomButton *)button animation:(BOOL)animation;

@end

@interface HSYBaseSegmentedPageControl (Show)

/**
 初始化

 @param frame frame
 @param paramters 属性参数
 @param controls title的集合
 @param block 点击的回调事件
 @return HSYBaseSegmentedPageControl
 */
+ (HSYBaseSegmentedPageControl *)hsy_showSegmentedPageControlFrame:(CGRect)frame
                                                         paramters:(NSDictionary<NSNumber *, id> *)paramters
                                                      pageControls:(NSArray<NSString *> *)controls
                                                     selectedBlock:(void(^)(HSYBaseCustomButton *button, NSInteger index))block;


@end
