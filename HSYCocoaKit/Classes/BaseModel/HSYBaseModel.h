//
//  HSYBaseModel.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import "NSArray+RACSignal.h"
#import "HSYHUDModel.h"

@interface HSYBaseModel : RVMViewModel

@property (nonatomic, strong) NSMutableArray *datas;                    //数据源
@property (nonatomic, strong) RACCommand *command;                      //响应信号
@property (nonatomic, strong) RACSignal *signal;                        //信号，备用
@property (nonatomic, strong) RACSubject *subject;                      //订阅信号，备用
@property (nonatomic, strong) id errorStatusCode;                       //请求失败的错误码

/**
 *  启动计时器
 *
 *  @param next 计时器回调
 */
- (void)timerSubscribeNext:(void(^)(NSDate *date))next;

/**
 *  停止计时器
 */
- (void)stop;

/**
 *  创建button的command信号
 *
 *  @param signal RACCommand响应的RACSignal
 *
 *  @return RACCommand对象
 */
- (RACCommand *)createCommandWithSignal:(RACSignal *)signal;

/**
 *  创建button的command信号对应的RACSignal
 *
 *  @param signals     监听集合: @[RACObserve(self, tream)]
 *  @param reduceBlock 结果回调
 *
 *  @return RACSignal
 */
- (RACSignal *)createRACSignals:(id<NSFastEnumeration>)signals reduce:(id(^)())reduceBlock;

/**
 *  创建button的command信号
 *
 *  @param signals 监听集合: @[RACObserve(self, tream)]
 *  @param next    结果回调
 *
 *  @return RACCommand对象
 */
- (RACCommand *)commandWithSignals:(id<NSFastEnumeration>)signals reduce:(id(^)())next;

/**
 *  遍历self.datas数组
 *
 *  @param next      遍历回调，每次遍历都会被触发
 *  @param completed 遍历结束后的回调
 */
- (void)rac_datasTraverseSubscribeNext:(void(^)(id result, NSNumber *index))next completed:(void(^)())completed;

/**
 *  遍历self.datas数组，同时，当不满足condition条件时，next将不被触发
 *
 *  @param condition 信号触发条件
 *  @param next      信号触发后的回调
 *  @param completed 遍历结束后的回调
 */
- (void)rac_filterUntilCondition:(BOOL(^)(id predicate))condition subscribeNext:(void(^)(id x))next completed:(void(^)())completed;

/**
 *  网络请求实现
 *
 *  @param network 网络请求的方法
 *  @param map     结果映射
 *  @param next    请求成功的回调
 *  @param error   请求失败的回调
 */
- (void)requestNetwork:(RACSignal *(^)())network toMap:(id(^)(id value))map subscriberNext:(void(^)(id x))next error:(void(^)(NSError *error))error;

/**
 *  网络请求实现，请求失败集中处理
 *
 *  @param network 网络请求的方法
 *  @param map     结果映射
 *  @param next    请求成功的回调
 */
- (void)requestNetwork:(RACSignal *(^)())network toMap:(id(^)(id value))map subscriberNext:(void(^)(id x))next;

/**
 *  网络请求实现，请求失败集中处理，不需要映射结果
 *
 *  @param network 网络请求的方法
 *  @param next    请求成功的回调
 */
- (void)requestNetwork:(RACSignal *(^)())network subscriberNext:(void(^)(id x))next;

@end
