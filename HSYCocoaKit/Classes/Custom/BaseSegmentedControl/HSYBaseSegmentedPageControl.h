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
    kHSYCocoaKitCustomSegmentedTypeSelectedTitleFont    = 7889,         //选中后的字体--UIFont
    kHSYCocoaKitCustomSegmentedTypeNorTitleColor        = 7890,         //未选中的字体颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeSelTitleColor        = 7891,         //选中后的字体颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeLineColor            = 7892,         //选中的下划线颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeLineSize             = 7893,         //选中的下划线size--NSValue--CGSize
    kHSYCocoaKitCustomSegmentedTypeLineRoundedCorners   = 7894,         //选中的是否使用圆角--NSNumber
    kHSYCocoaKitCustomSegmentedTypeButtonSize           = 7895,         //按钮点击区域--NSValue--CGSize
    kHSYCocoaKitCustomSegmentedTypeButtonSpacing        = 7896,         //按钮间距--NSNumber--CGFloat
    kHSYCocoaKitCustomSegmentedTypeBackgroundImage      = 7897,         //背景图片--UIImage
    kHSYCocoaKitCustomSegmentedTypeSelectedIndex        = 7898,         //选中位置--NSNumber
    kHSYCocoaKitCustomSegmentedTypeAnimationDuration    = 7899,         //动画时间--NSNumber
    kHSYCocoaKitCustomSegmentedTypeShowBottomLine       = 7900,         //是否底部的横线--NSNumber
    kHSYCocoaKitCustomSegmentedTypeBottomLineSize       = 7901,         //底部横线的size--NSValue--CGSize
    kHSYCocoaKitCustomSegmentedTypeBottomLineColor      = 7902,         //底部横线的颜色--UIColor
    
};

@interface HSYBaseSegmentedPageControl : UIView

//数据源
@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseCustomButton *> *segmentedButton;
//横向滚动容器
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
//选中的位置
@property (nonatomic, assign, setter=setCurrentSelectedItem:) NSInteger selectedIndex;
//背景图片
@property (nonatomic, setter=setSegmentedPageControlBackgroundImage:) UIImage *segmentedBackgroundImage;
//选中的item项的底部的下划线的颜色
@property (nonatomic, setter=setSelectedItemLineColor:) UIColor *selectedLineColor;
//选中的item项的颜色
@property (nonatomic, setter=setSelectedItemTitleColor:) UIColor *selectedTitleColor;
//未选中的item项的颜色
@property (nonatomic, setter=setNormalItemTitleColor:) UIColor *normalTitleColor;
//底部的横线的颜色
@property (nonatomic, setter=setBottomLineColor:) UIColor *lineInBottomColor;

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
