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

#pragma mark - Pages

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

#pragma mark - Request

- (void)hsy_pullRefresh:(kHSYReflesStatusType)status
             updateNext:(RACSignal *(^)(void))network
                  toMap:(NSMutableArray *(^)(RACTuple *tuple))map
         subscriberNext:(void(^)(id x))next
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
        @strongify(self);
        //加载成功后动态更新数据源信息，并设置当前的statusCode状态
        kHSYHUDModelCodeType codeType = (kHSYHUDModelCodeType)[@{@(kHSYReflesStatusTypePullDown) : @(kHSYHUDModelCodeTypeRequestPullDownSuccess), @(kHSYReflesStatusTypePullUp) : @(kHSYHUDModelCodeTypeRequestPullUpSuccess), }[@(status)] integerValue];
        if (status == kHSYReflesStatusTypePullDown) {
            [self.hsy_datas removeAllObjects];
            self.hsy_datas = [result mutableCopy];
        } else {
            for (id obj in result) {
                [self.hsy_datas addObject:obj];
            }
        }
        self.hsy_refreshStateCode = [self hsy_defaultHUDModel:result.count type:codeType];
        if (next) {
            next(result);
        }
        return NO;
    } error:^(NSError *error) {
        @strongify(self);
        [self hsy_resultStatusCode:error];
        if (next) {
            next(error);
        }
    }];
}

- (HSYHUDModel *)hsy_defaultHUDModel:(NSInteger)count type:(kHSYHUDModelCodeType)type
{
    HSYHUDModel *hudModel = [HSYHUDModel initWithCodeType:type];
    if (!self.hsy_showPromptContent) {
        hudModel.hsy_showPromptContent = self.hsy_showPromptContent;
    }
    if (count > 0) {
        hudModel.pullUpSize = count;
    }
    return hudModel;
}

#pragma mark - Load

//范例
//- (RACSignal *)test:(NSString *)path
//{
//    return [self.httpSessionManager hsy_rac_getRequest:path parameters:nil];
//}
- (RACSignal *)hsy_rac_pullDownMethod
{
    //范例
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
//        [self hsy_pullRefresh:kHSYReflesStatusTypePullDown updateNext:^RACSignal *{
//            return [[HSYNetWorkingManager shareInstance] test:urlStr];
//        } toMap:^NSMutableArray *(RACTuple *tuple) {
//            NSMutableArray *array = [[NSMutableArray alloc] init];
//            [array addObject:[NSString stringWithFormat:@"jfiowejfowijfoweijfweoif%d", arc4random()%100000]];
//            return array;
//        } subscriberNext:^(id x) {
//            [subscriber sendCompleted];
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
//        [self hsy_pullRefresh:kHSYReflesStatusTypePullUp updateNext:^RACSignal *{
//            return [[HSYNetWorkingManager shareInstance] test:urlStr];
//        } toMap:^NSMutableArray *(RACTuple *tuple) {
//            NSMutableArray *array = [[NSMutableArray alloc] init];
//            for (NSInteger i = 0; i < 100; i ++) {
//                [array addObject:[NSString stringWithFormat:@"%d", arc4random()%100]];
//            }
//            return array;
//        } subscriberNext:^(id x) {
//            [subscriber sendCompleted];
//        }];
//        return [RACDisposable disposableWithBlock:^{}];
//    }];
    return [RACSignal empty];
}

#pragma mark - Send Message

- (void)hsy_sendNext:(kHSYCocoaKitRACSubjectOfNextType)type subscribeContents:(NSArray<id> *)contents
{
    HSYCocoaKitRACSubscribeNotification *object = [self hsy_defaultSubscribeNotification:type subscribeContents:contents];
    [self.subject sendNext:object];
}

- (HSYCocoaKitRACSubscribeNotification *)hsy_defaultSubscribeNotification:(kHSYCocoaKitRACSubjectOfNextType)type subscribeContents:(NSArray<id> *)contents
{
    HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:type subscribeContents:contents];
    object.hsy_isFirstRequest = self.hsy_isFirstTimes;
    return object;
}

@end
