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
//上拉或下拉加载完成功后的回调内容
@property (nonatomic, copy) RACSignal *(^hsy_refreshRequestSuccess)(BOOL isPullDown, HSYCocoaKitRACSubscribeNotification *signal);

/**
 根据UIScrollView类族是否签订了上拉刷新功能，在网络请求成功后，提供接口允许子类动态更新上拉功能是否继续启用
 注意：某些特殊情况，例如控制器中执行了“- reloadData”方法后，发现contentSize的高度仍然存在问题，请在“- reloadData”方法后再执行“- (void)hsy_resetRefresh:(UIScrollView *)scrollView;”尝试重新更新真实的contentSize
 
 @param scrollView UIScrollView
 */
- (void)hsy_resetRefresh:(UIScrollView *)scrollView;

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
