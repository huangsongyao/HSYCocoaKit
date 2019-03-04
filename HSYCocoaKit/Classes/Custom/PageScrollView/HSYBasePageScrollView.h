//
//  HSYBasePageScrollView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2019/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HSYBasePageTableDelegate <NSObject>

@required

/**
 由外部的分页子控制器返回它所持有的UIScrollview类族对象[UITableView、UICollectionView]
 
 @return UIScrollView
 */
- (UIScrollView *)hsy_listScrollView;

/**
 由外部的分页子控制器持有scroll来监听它的UIScrollview类族对象的滚动
 
 @param scroll scroll block
 */
- (void)hsy_listScrollViewDidScroll:(void(^)(UIScrollView *scrollView))scroll;

@end

@class HSYBasePageScrollView;
@protocol HSYBasePageScrollDelegate <NSObject>

@required

/**
 通过委托，由外部返回一个作为mainScrollView的headerView的视图
 
 @param scrollView self
 @return mainScrollView的headerView的视图
 */
- (UIView *)hsy_tableHeaderViewInPageScrollView:(HSYBasePageScrollView *)scrollView;

/**
 通过委托，由外部返回一个作为mainScrollView的body的视图，这个视图主要是作为segmentPageController分页控制器的容器视图
 
 @param scrollView self
 @return mainScrollView的body的视图
 */
- (UIView *)hsy_pageViewInPageScrollView:(HSYBasePageScrollView *)scrollView;

/**
 通过委托，由外部返回一个作为mainScrollView的body的视图的高度
 
 @param scrollView self
 @return mainScrollView的body的视图的高度
 */
- (CGFloat)hsy_listViewHeightInPageScrollView:(HSYBasePageScrollView *)scrollView;

- (NSArray<id<HSYBasePageTableDelegate>> *)hsy_listViewsInPageScrollView:(HSYBasePageScrollView *)scrollView;

@optional

/**
 用于额外做动态头部变化的委托回调
 
 @param scrollView scrollView
 */
- (void)hsy_mainTableViewDidScroll:(UIScrollView *)scrollView;

@end

//************************************************************************************************

@interface HSYBasePageTableView : UITableView <UIGestureRecognizerDelegate>

- (instancetype)initWithTableHeaderView:(UIView *)tableHeaderView;

@end

//************************************************************************************************

@interface HSYBasePageScrollView : UIView

@property (nonatomic, weak) id<HSYBasePageScrollDelegate>hsy_delegate;              //委托
@property (nonatomic, strong, readonly) HSYBasePageTableView *hsy_mainTableView;    //主界面底部的tableView
@property (nonatomic, assign) CGFloat criticalScrollValue;                          //临界值
@property (nonatomic, assign, setter=startHorizonScroll:) BOOL userHorizonScroll;   //设置左右滑动及上下滑动冲突时的禁止横向滚动的行为

- (instancetype)initWithDelegate:(id<HSYBasePageScrollDelegate>)delegate;


@end

NS_ASSUME_NONNULL_END
