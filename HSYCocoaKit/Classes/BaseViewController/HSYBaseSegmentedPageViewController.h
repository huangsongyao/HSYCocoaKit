//
//  HSYBaseSegmentedPageViewController.h
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseViewController.h"
#import "HSYBaseSegmentedPageControlModel.h"
#import "HSYBaseSegmentedPageControl.h"
#import "HSYBaseSegmentedPageConfig.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitBaseSegmentedPageControl) {
    
    kHSYCocoaKitBaseSegmentedPageControlInNavigationItem            = 644,              //位于导航栏头部
    kHSYCocoaKitBaseSegmentedPageControlInScrollViewHeaderView,                         //位于(0, 0)的头部
    kHSYCocoaKitBaseSegmentedPageControlInScrollViewFooterView,                         //位于底部
};

@interface HSYBaseSegmentedPageViewController : HSYBaseViewController

#pragma mark -- 以下属性请在执行[super viewDidLoad]前设置

@property (nonatomic, strong) UIFont *normalFont;               //segmentedPageControl的nor状态的字号
@property (nonatomic, strong) UIFont *selectedFont;             //segmentedPageControl的sel状态的字号
@property (nonatomic, strong) UIColor *normalColor;             //segmentedPageControl的nor状态的字体颜色
@property (nonatomic, strong) UIColor *selectedColor;           //segmentedPageControl的sel的状态的字体颜色
@property (nonatomic, strong) UIColor *lineColor;               //segmentedPageControl的下划线颜色
@property (nonatomic, strong) NSValue *lineSizeValue;           //segmentedPageControl的下滑线的size
@property (nonatomic, strong) NSValue *buttonSizeValue;         //segmentedPageControl的item的size
@property (nonatomic, strong) UIImage *segmentBackgroundImage;  //segmentedPageControl的背景图
@property (nonatomic, strong) NSNumber *currentSelectedIndex;   //segmentedPageControl的当前选中的项
@property (nonatomic, strong) NSNumber *segmentedControlHeight; //segmentedPageControl的高度
@property (nonatomic, assign) BOOL openScroll;                  //是否允许滚动，默认为YES
//判断标识位，默认为navigationBar的头部
@property (nonatomic, assign) kHSYCocoaKitBaseSegmentedPageControl segmentedControlInView;

#pragma mark -- 以下属性不需要特定设置

//分页栏
@property (nonatomic, strong, readonly) HSYBaseSegmentedPageControl *segmentedPageControl;
//滚动结束后的监听事件，HSYBaseSegmentedPageViewController子类可以实现本属性，监听滚动状态，用于处理model中vc
@property (nonatomic, copy) void(^scrollEndFinished)(const NSInteger index, const UIViewController *viewController);

- (instancetype)initWithConfigs:(NSArray<HSYBaseSegmentedPageConfig *> *)configs;

@end
