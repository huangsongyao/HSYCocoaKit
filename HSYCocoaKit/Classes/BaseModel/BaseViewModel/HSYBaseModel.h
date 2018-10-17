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
@property (nonatomic, strong) RACSignal *hsy_signal;                        //冷信号，默认为nil
@property (nonatomic, strong, readonly) RACSubject *subject;                //热信号，只有dealloc时才会调用“- sendCompleted”
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
 zip合并信号。当所有信号均返回sendNext，result回调会触发，并且result的messages是按照signals信号集合的顺序来排序的；当有一个信号返回sendError时，result回调也会触发，同时截断messages

 @param signals 信号集合，格式为：@[RACObserve(self, RACSignal_A), RACObserve(self, RACSignal_B), ...]或者@[RACSignal_A, RACSignal_B, ...]
 @param result 信号触发回调，messages表示根据signals的顺序返回的结果集合，error表示signals中某个信号的报错
 */
- (void)hsy_zipSignals:(id<NSFastEnumeration>)signals subcriberResult:(void(^)(NSArray *messages, NSError *error))result;

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

