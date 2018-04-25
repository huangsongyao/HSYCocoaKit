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
    
    kHSYCocoaKitCustomSegmentedTypeTitleFont            = 7888,         //按钮字体--UIFont
    kHSYCocoaKitCustomSegmentedTypeNorTitleColor,                       //未选中的字体颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeSelTitleColor,                       //选中后的字体颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeLineColor,                           //横线颜色--UIColor
    kHSYCocoaKitCustomSegmentedTypeLineSize,                            //横线size--NSValue--CGSize
    kHSYCocoaKitCustomSegmentedTypeButtonSize,                          //按钮点击区域--NSValue--CGSize
    kHSYCocoaKitCustomSegmentedTypeBackgroundImage,                     //背景图片--UIImage
    kHSYCocoaKitCustomSegmentedTypeSelectedIndex,                       //选中位置--NSNumber
    kHSYCocoaKitCustomSegmentedTypeAnimationDuration,                   //动画时间--NSNumber
    
};

@interface HSYBaseSegmentedPageControl : UIView

@property (nonatomic, strong, readonly) NSMutableArray<HSYBaseCustomButton *> *segmentedButton;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, setter=setCurrentSelectedItem:) NSInteger selectedIndex;

/**
 <#Description#>

 @param scale <#scale description#>
 */
- (void)setContentOffsetFromScale:(CGFloat)scale;

@end

@interface HSYBaseSegmentedPageControl (Show)

/**
 <#Description#>

 @param view <#view description#>
 @param frame <#frame description#>
 @param paramters <#paramters description#>
 @param controls <#controls description#>
 @param block <#block description#>
 @return <#return value description#>
 */
+ (HSYBaseSegmentedPageControl *)showSegmentedPageControlInView:(UIView *)view
                                                          Frame:(CGRect)frame
                                                      paramters:(NSDictionary<NSNumber *, id> *)paramters
                                                   pageControls:(NSArray<NSString *> *)controls
                                                  selectedBlock:(void(^)(HSYBaseCustomButton *button, NSInteger index))block;

@end
