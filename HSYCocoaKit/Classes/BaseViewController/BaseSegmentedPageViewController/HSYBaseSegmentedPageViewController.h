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

@interface UIViewController (SegmentdPage)

/**
 用于翻页控制器内设置好布局后，如果外部需要对布局做调整，可在子控制器的"- viewDidLoad"方法中内部订阅本信号，重新调整布局
 
 @return RACSignal，会返回一个NSValue--CGRect，为每个子控制器的view在翻页控制器中的scrollView的布局frame
 */
- (RACSignal *)hsy_layoutReset;

@end

//*****************************************************************************************************

@class UIViewControllerRuntimeDelegateObject;
@interface HSYBaseSegmentedPageViewController : HSYBaseViewController

#pragma mark -- 以下属性请在执行[super viewDidLoad]前设置

//分页器的属性参数总汇，默认segmentedControlParamter为空
@property (nonatomic, strong) NSDictionary *segmentedControlParamter;
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
@property (nonatomic, strong) NSNumber *scrollViewHeight;       //scrollView的高度，默认为0，当该值为0时会采用默认是设置高度，否则大于0，则采用该属性
@property (nonatomic, assign) BOOL openScroll;                  //是否允许滚动，默认为YES
//判断标识位，默认为navigationBar的头部
@property (nonatomic, assign) kHSYCocoaKitBaseSegmentedPageControl segmentedControlInView;

#pragma mark -- 以下属性不需要特定设置

//分页栏
@property (nonatomic, strong, readonly) HSYBaseSegmentedPageControl *segmentedPageControl;
//滚动结束后的监听事件，HSYBaseSegmentedPageViewController子类可以实现本属性，监听滚动状态，用于处理model中vc
@property (nonatomic, copy) void(^scrollEndFinished)(const NSInteger index, const UIViewController *viewController);
//监听子控制器的UIViewControllerRuntimeDelegate委托响应，子类可通过这个block处理子控制器回调给segmentedPageController的信号
@property (nonatomic, copy) RACSignal *(^hsy_responseRuntimeDelegate)(UIViewControllerRuntimeDelegateObject *object);
//监听HSYBaseTableViewController和HSYCollectionViewController两个类族的子类对象对于scrollDidScroll委托的状态
@property (nonatomic, copy) void(^hsy_observerChilsScrollControllerDidScroll)(UIScrollView *scrollView);
//滚动条
@property (nonatomic, strong, readonly) UIScrollView *scrollView;

- (instancetype)initWithConfigs:(NSArray<HSYBaseSegmentedPageConfig *> *)configs;

/**
 外部接口，设置翻页

 @param selectedIndex 翻页页码
 */
- (void)hsy_setCurrentSelectedIndex:(NSNumber *)selectedIndex;

/**
 静态方法设置自控制器
 
 @param hsy_viewControllers 控制器集合
 @param titles 控制器的title
 @param configs 数据格式集合
 @param height 内嵌控制器的高度
 @return 最后一个自控制器的right的值
 */
+ (NSMutableArray<UIViewController *> *)hsy_addSubViewController:(NSMutableArray *)hsy_viewControllers titles:(NSArray *)titles configs:(NSMutableArray *)configs height:(CGFloat)height;

@end
