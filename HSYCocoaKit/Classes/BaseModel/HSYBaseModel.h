//
//  HSYBaseModel.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/9.
//

#import "RVMViewModel.h"
#import "NSArray+RACSignal.h"
#import "HSYHUDModel.h"
#import "HSYCocoaKitRACSubscribeNotification.h"

@interface HSYBaseModel : RVMViewModel

@property (nonatomic, strong) NSMutableArray *hsy_datas;                    //数据源
@property (nonatomic, strong) RACCommand *hsy_command;                      //响应信号，默认为nil
@property (nonatomic, strong) RACSignal *hsy_signal;                        //信号，默认为nil
@property (nonatomic, strong, readonly) RACSubject *subject;                //订阅信号，只有dealloc时才会调用“- sendCompleted”
@property (nonatomic, strong) id hsy_errorStatusCode;                       //请求失败的错误码
@property (nonatomic, strong) id hsy_successStatusCode;                     //请求成功的成功码

/**
 *  启动计时器
 *
 *  @param next 计时器回调
 */
- (void)hsy_timerSubscribeNext:(void(^)(NSDate *date))next;

/**
 *  停止计时器
 */
- (void)hsy_stop;

/**
 请求失败允许外部设置statusCode
 
 @param code code
 */
- (void)hsy_resultStatusCode:(id)code;

/**
 *  创建button的command信号
 *
 *  @param signal RACCommand响应的RACSignal
 *
 *  @return RACCommand对象
 */
- (RACCommand *)hsy_createCommandWithSignal:(RACSignal *)signal;

/**
 *  创建button的command信号对应的RACSignal
 *
 *  @param signals     监听集合: @[RACObserve(self, tream)]
 *  @param reduceBlock 结果回调
 *
 *  @return RACSignal
 */
- (RACSignal *)hsy_createRACSignals:(id<NSFastEnumeration>)signals reduce:(id(^)(void))reduceBlock;

/**
 *  创建button的command信号
 *
 *  @param signals 监听集合: @[RACObserve(self, tream)]
 *  @param next    结果回调
 *
 *  @return RACCommand对象
 */
- (RACCommand *)hsy_commandWithSignals:(id<NSFastEnumeration>)signals reduce:(id(^)(void))next;

/**
 *  遍历self.datas数组
 *
 *  @param next      遍历回调，每次遍历都会被触发
 *  @param completed 遍历结束后的回调
 */
- (void)hsy_rac_datasTraverseSubscribeNext:(void(^)(id result, NSNumber *index))next completed:(void(^)(void))completed;

/**
 *  遍历self.datas数组，同时，当不满足condition条件时，next将不被触发
 *
 *  @param condition 信号触发条件
 *  @param next      信号触发后的回调
 *  @param completed 遍历结束后的回调
 */
- (void)hsy_rac_filterUntilCondition:(BOOL(^)(id predicate))condition subscribeNext:(void(^)(id x))next completed:(void(^)(void))completed;

/**
 *  网络请求实现
 *
 *  @param network 网络请求的方法
 *  @param map     结果映射, map返回一个json数据的映射对象
 *  @param next    请求成功的回调, BOOL值返回一个是否设置请求成功的statusCode
 *  @param error   请求失败的回调
 */
- (void)hsy_requestNetwork:(RACSignal *(^)(void))network toMap:(id(^)(RACTuple *tuple))map subscriberNext:(BOOL(^)(id x))next error:(void(^)(NSError *error))error;

/**
 *  网络请求实现，请求失败集中处理
 *
 *  @param network 网络请求的方法
 *  @param map     结果映射, map返回一个json数据的映射对象
 *  @param next    请求成功的回调, BOOL值返回一个是否设置请求成功的statusCode
 */
- (void)hsy_requestNetwork:(RACSignal *(^)(void))network toMap:(id(^)(RACTuple *tuple))map subscriberNext:(BOOL(^)(id x))next;

/**
 *  网络请求实现，请求失败集中处理，不需要映射结果，
 *
 *  @param network 网络请求的方法
 *  @param next    请求成功的回调, BOOL值返回一个是否设置请求成功的statusCode，并且返回一个json
 
 */
- (void)hsy_requestNetwork:(RACSignal *(^)(void))network subscriberNext:(BOOL(^)(id x))next;

@end

