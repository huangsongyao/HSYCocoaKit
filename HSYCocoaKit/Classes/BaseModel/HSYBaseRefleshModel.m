//
//  HSYBaseRefleshModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "HSYBaseRefleshModel.h"

@implementation HSYBaseRefleshModel

- (instancetype)init
{
    if (self = [super init]) {
        [self hsy_updateSize:100];
        [self hsy_firstPage];
    }
    return self;
}

- (void)hsy_nextPage
{
    _page ++;
}

- (void)hsy_firstPage
{
    _page = 1;
}

- (void)hsy_updateSize:(NSInteger)size
{
    if (size <= 0) {
        return;
    }
    _size = size;
}

- (void)hsy_pullRefresh:(kHSYReflesStatusType)status
             updateNext:(RACSignal *(^)(void))network
                  toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self hsy_pullRefresh:status updateNext:network toMap:map subscriberNext:^{}];
}

- (void)hsy_pullRefresh:(kHSYReflesStatusType)status
             updateNext:(RACSignal *(^)(void))network
                  toMap:(NSMutableArray *(^)(RACTuple *tuple))map
         subscriberNext:(void(^)(void))next
{
    switch (status) {
        case kHSYReflesStatusTypePullDown:
            [self hsy_firstPage];
            break;
        case kHSYReflesStatusTypePullUp:
            [self hsy_nextPage];
            break;
        default:
            break;
    }
    @weakify(self);
    [self hsy_requestNetwork:network toMap:map subscriberNext:^BOOL(NSMutableArray *result) {
        if (result.count == 0) {
            return NO;
        }
        @strongify(self);
        //加载成功后动态更新数据源信息，并设置当前的statusCode状态
        if (status == kHSYReflesStatusTypePullDown) {
            [self.hsy_datas removeAllObjects];
            self.hsy_datas = [result mutableCopy];
            self.hsy_pullDownStateCode = [HSYHUDModel initWithCodeType:kHSYHUDModelCodeTypeRequestPullDownSuccess];
        } else {
            for (id obj in result) {
                [self.hsy_datas addObject:obj];
            }
            self.hsy_pullUpStateCode = [HSYHUDModel initWithCodeType:kHSYHUDModelCodeTypeRequestPullUpSuccess];
        }
        
        if (next) {
            next();
        }
        return NO;
    } error:^(NSError *error) {
        if (next) {
            next();
        }
    }];
}

- (RACSignal *)hsy_rac_pullDownMethod
{
    //范例
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
//        [[[HSYNetWorkingManager shareInstance] test:urlStr] subscribeNext:^(id x) {
//            [self.hsy_datas addObject:[NSString stringWithFormat:@"%d", arc4random()%100]];
//            [subscriber sendNext:x];
//            [subscriber sendCompleted];
//        } error:^(NSError *error) {
//            [subscriber sendError:error];
//        }];
//        return [RACDisposable disposableWithBlock:^{}];
//    }];
    return [RACSignal empty];
}

- (RACSignal *)hsy_rac_pullUpMethod
{
    //范例
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
//        [[[HSYNetWorkingManager shareInstance] test:urlStr] subscribeNext:^(id x) {
//            [self.hsy_datas addObject:[NSString stringWithFormat:@"%d", arc4random()%100]];
//            [subscriber sendNext:x];
//            [subscriber sendCompleted];
//        } error:^(NSError *error) {
//            [subscriber sendError:error];
//        }];
//        return [RACDisposable disposableWithBlock:^{}];
//    }];
    return [RACSignal empty];
}

@end
