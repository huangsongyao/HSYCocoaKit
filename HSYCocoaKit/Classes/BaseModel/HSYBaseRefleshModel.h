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

@property (nonatomic, assign, readonly) NSInteger page;     //翻页页码
@property (nonatomic, assign, readonly) NSInteger size;     //每页的数据条数

@property (nonatomic, strong) id pullDownStateCode;         //下拉刷新的状态
@property (nonatomic, strong) id pullUpStateCode;           //上拉刷新的状态

/**
 *  设置每次记载的条数
 *
 *  @param size 翻页的条数
 */
- (void)updateSize:(NSInteger)size;

/**
 *  网络请求下一页，主要用于分页
 *
 *  @param network 网络请求的方法
 *  @param map     结果映射，由于方法内部已经对self.datas这个数据源数组进行了整理，所有映射时必须映射成结果数组
 *  @param status  上拉或者下拉的枚举
 */
- (void)updateNext:(RACSignal *(^)())network toMap:(NSMutableArray *(^)(id x))map pullDown:(kHSYReflesStatusType)status;

@end
