//
//  HSYBaseRefleshModel.h
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "HSYBaseModel.h"

typedef NS_ENUM(NSUInteger, kHSYReflesStatusType) {
    
    kHSYReflesStatusTypeNone,
    kHSYReflesStatusTypePullDown    = 299,              //下拉
    kHSYReflesStatusTypePullUp      = 300,              //上拉
};

@interface HSYBaseRefleshModel : HSYBaseModel

@property (nonatomic, assign, readonly) NSInteger page;                     //翻页页码，默认为1
@property (nonatomic, assign, readonly) NSInteger size;                     //每页的数据条数，默认为100

@property (nonatomic, strong) id hsy_pullDownStateCode;                     //下拉刷新的状态
@property (nonatomic, strong) id hsy_pullUpStateCode;                       //上拉刷新的状态

@property (nonatomic, assign) BOOL hsy_showPromptContent;                   //额外提供一个标识位，用于处理是否支持直接提示默认的提示语
@property (nonatomic, assign) BOOL hsy_isFirstTimes;                        //当调用“HSYBaseTableViewController”类或者“类”的“- firstRequest”方法时，会将本标志位设置为YES，用于区分某些情况下的firstRequest状态

/**
 *  设置每次记载的条数
 *
 *  @param size 翻页的条数
 */
- (void)hsy_updateSize:(NSInteger)size;

/**
 网络请求下一页，主要用于分页，并且重新定义了父类的“- requestNetwork:toMap:subscriberNext:”方法，返回了NO，用与区分普通请求成功后设置statusCode和上拉或者下拉成功后设置的statusCode

 @param status 上拉或者下拉的枚举
 @param network 网络请求的方法
 @param map 结果映射，由于方法内部需要对self.datas这个数据源数组进行了整理，所以映射时必须映射成结果数组
 @param next 数据整理成功后的回调，用于上下拉及时获取block状态
 */
- (void)hsy_pullRefresh:(kHSYReflesStatusType)status
             updateNext:(RACSignal *(^)(void))network
                  toMap:(NSMutableArray *(^)(RACTuple *tuple))map
         subscriberNext:(void(^)(id x))next;

/**
 下拉刷新方法，默认返回一个empty，子类中请重载本方法，并返回关于下拉刷新的网络请求，数据源默认由外部重载的子类中自己定义

 @return 下拉刷新的网络请求的RACSignal
 */
- (RACSignal *)hsy_rac_pullDownMethod;

/**
 上拉加载更多方法，默认返回一个empty，子类中请重载本方法，并返回关于上拉加载更多的网络请求，数据源默认由外部重载的子类中自己定义

 @return 上拉加载更多的网络请求的RACSignal
 */
- (RACSignal *)hsy_rac_pullUpMethod;

/**
 base类中调用热信号sendNext消息体
 
 @param type 消息体类型
 @param contents 内容
 */
- (void)hsy_sendNext:(kHSYCocoaKitRACSubjectOfNextType)type subscribeContents:(NSArray<id> *)contents;

@end
