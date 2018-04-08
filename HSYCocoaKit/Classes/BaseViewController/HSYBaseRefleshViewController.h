//
//  HSYBaseRefleshViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "HSYBaseViewController.h"

@interface HSYBaseRefleshViewController : HSYBaseViewController

@property (nonatomic, assign) BOOL showPullDown;            //是否添加下拉刷新，默认不添加
@property (nonatomic, assign) BOOL showPullUp;              //是否添加上拉加载更多，默认不添加
@property (nonatomic, assign) BOOL showAllReflesh;          //是否添加上拉加载更多和下拉刷新，默认不添加

//下拉刷新的头部视图定制，默认为nil，如果添加了下拉，此视图必须设置
@property (nonatomic, strong, setter=addPullDownView:) UIView *pullDownView;
//上拉加载更多的尾部视图定制，默认为nil，如果添加了上拉，此视图必须设置
@property (nonatomic, strong, setter=addPullUpView:) UIView *pullUpView;

@end
