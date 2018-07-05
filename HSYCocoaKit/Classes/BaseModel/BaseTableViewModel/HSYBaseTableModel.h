//
//  HSYBaseTableModel.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseRefleshModel.h"

@interface HSYBaseTableModel : HSYBaseRefleshModel

/**
 下拉刷新

 @param network 网络请求的方法
 @param map 结果映射，由于方法内部已经对self.datas这个数据源数组进行了整理，所以映射时必须映射成结果数组
 @param next 请求成功或者失败后的回调
 */
- (void)hsy_refreshToPullDown:(RACSignal *(^)(void))network
                        toMap:(NSMutableArray *(^)(RACTuple *tuple))map
               subscriberNext:(void(^)(id x))next;

/**
 上拉加载更多

 @param network 网络请求的方法
 @param map 结果映射，由于方法内部已经对self.datas这个数据源数组进行了整理，所以映射时必须映射成结果数组
 @param next 请求成功或者失败后的回调
 */
- (void)hsy_refreshToPullUp:(RACSignal *(^)(void))network
                      toMap:(NSMutableArray *(^)(RACTuple *tuple))map
             subscriberNext:(void(^)(id x))next;


@end
