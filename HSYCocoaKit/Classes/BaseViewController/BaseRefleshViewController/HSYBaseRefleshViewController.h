//
//  HSYBaseRefleshViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "HSYBaseViewController.h"
#import "SVPullToRefresh.h"

FOUNDATION_EXPORT NSString *const kHSYCocoaKitRefreshPullDownStatusKey;
FOUNDATION_EXPORT NSString *const kHSYCocoaKitRefreshStatusPullUpKey;

typedef NS_ENUM(NSUInteger, kHSYCocoaKitRefreshForPullUpCompletedStatus) {
    
    kHSYCocoaKitRefreshForPullUpCompletedStatusClose        = 8999, //上拉无更多数据时，此类型表示关闭
    kHSYCocoaKitRefreshForPullUpCompletedStatusNorMore,             //上拉无更多数据时，此类型表示显示提示
    
};

@interface HSYBaseRefleshViewController : HSYBaseViewController

@property (nonatomic, assign) BOOL showPullDown;                    //是否添加下拉刷新，默认不添加
@property (nonatomic, assign) BOOL showPullUp;                      //是否添加上拉加载更多，默认不添加
@property (nonatomic, assign) BOOL showAllReflesh;                  //是否添加上拉加载更多和下拉刷新，默认不添加
@property (nonatomic, assign) BOOL hsy_sendNavigationBarToBack;     //是否把系统的navigationBar设置到navigationController所有子视图的最底层
@property (nonatomic, strong) HSYCustomRefreshView *pullDownView;   //下拉刷新的头部视图定制，默认为nil，如果添加了下拉，此视图必须设置
@property (nonatomic, strong) HSYCustomRefreshView *pullUpView;     //上拉加载更多的尾部视图定制，默认为nil，如果添加了上拉，此视图必须设置
//上拉获取到的数据条数小于既定的“self.hsy_viewModel.size”的个数，根据此枚举类型处理上拉功能，默认为kHSYCocoaKitRefreshForPullUpCompletedStatusClose
@property (nonatomic, assign) kHSYCocoaKitRefreshForPullUpCompletedStatus pullUpStatus;

/**
 同时添加上拉和下拉

 @param scrollView scrollView及其子类
 */
- (void)hsy_addRefresh:(UIScrollView *)scrollView;

/**
 添加下拉刷新

 @param scrollView scrollView及其子类
 */
- (void)hsy_addPullDownRefresh:(UIScrollView *)scrollView;

/**
 添加上拉加载更多

 @param scrollView scrollView及其子类
 */
- (void)hsy_addPullUpRefresh:(UIScrollView *)scrollView;

/**
 关闭上拉

 @param scrollView scrollView
 */
- (void)hsy_closePullUp:(UIScrollView *)scrollView;

/**
 提示无更多数据的上拉到底部了

 @param scrollView scrollView
 */
- (void)hsy_notMorePullUp:(UIScrollView *)scrollView;

/**
 重置有更多数据上拉状态

 @param scrollView scrollView
 */
- (void)hsy_hasMorePullUp:(UIScrollView *)scrollView;

/**
 打开上拉

 @param scrollView scrollView
 */
- (void)hsy_openPullUp:(UIScrollView *)scrollView;

@end
