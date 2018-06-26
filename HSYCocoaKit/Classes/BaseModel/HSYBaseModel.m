//
//  HSYBaseModel.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/9.
//

#import "HSYBaseModel.h"
#import "RACSignal+Timer.h"

@interface HSYBaseModel ()

@property (nonatomic, strong, readonly) RACDisposable *disposable;      //计时器

@end

@implementation HSYBaseModel

- (instancetype)init
{
    if (self = [super init]) {
        self.hsy_datas = [[NSMutableArray alloc] init];
        _subject = [RACSubject subject];
        @weakify(self);
        [[self.subject rac_willDeallocSignal] subscribeCompleted:^{
            @strongify(self);
            NSLog(@"hot signal---subject release: class is %@", NSStringFromClass(self.class));
        }];
    }
    return self;
}

#pragma mark - Timer

- (void)hsy_timerSubscribeNext:(void(^)(NSDate *date))next
{
    [self hsy_stop];
    _disposable = [[[RACSignal hsy_rac_timerSignalOneMinute] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate *date) {
        if (next) {
            next(date);
        }
    }];
}

- (void)hsy_stop
{
    if (self.disposable) {
        [self.disposable dispose];
    }
}

#pragma mark - Button RACCommand For RACSignal

- (RACCommand *)hsy_createCommandWithSignal:(RACSignal *)signal
{
    RACCommand *command = [[RACCommand alloc] initWithEnabled:signal signalBlock:^RACSignal *(id input) {
        return [RACSignal empty];
    }];
    
    return command;
}

- (RACSignal *)hsy_createRACSignals:(id<NSFastEnumeration>)signals
                             reduce:(id(^)(void))reduceBlock
{
    return [RACSignal combineLatest:signals reduce:reduceBlock];
}

- (RACCommand *)hsy_commandWithSignals:(id<NSFastEnumeration>)signals reduce:(id(^)(void))next
{
    RACCommand *command = [self hsy_createCommandWithSignal:[self hsy_createRACSignals:signals reduce:^id{
        if (next) {
            return next();
        }
        return @(NO);
    }]];
    return command;
}

#pragma mark - Datas Operation

- (void)hsy_rac_datasTraverseSubscribeNext:(void(^)(id result, NSNumber *index))next
                                 completed:(void(^)(void))completed
{
    [[[self.hsy_datas rac_traverseArray] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *value) {
        if (next) {
            next(value.allValues.firstObject, value.allKeys.firstObject);
        }
    } completed:^{
        if (completed) {
            completed();
        }
    }];
}

- (void)hsy_rac_filterUntilCondition:(BOOL(^)(id predicate))condition
                       subscribeNext:(void(^)(id x))next
                           completed:(void(^)(void))completed
{
    [[[self.hsy_datas rac_filterUntilCompleted:^BOOL(id predicate) {
        if (condition) {
            return condition(predicate);
        }
        return NO;
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        if (next) {
            next(x);
        }
    } completed:completed];
}

#pragma mark - Request Network

- (void)hsy_resultStatusCode:(id)code
{
    if (!code) {
        return;
    }
    self.hsy_errorStatusCode = code;
}

- (void)hsy_requestNetwork:(RACSignal *(^)(void))network
                     toMap:(id(^)(RACTuple *tuple))map
            subscriberNext:(BOOL(^)(id x))next
                     error:(void(^)(NSError *error))error
{
    if (network) {
        RACSignal *signal = network();
        [[signal map:map] subscribeNext:^(id jsonModel) {
            if (next) {
                BOOL requestSuccessCode = next(jsonModel);
                if (requestSuccessCode) {
                    self.hsy_successStatusCode = jsonModel;
                }
            }
        } error:error];
    }
}

- (void)hsy_requestNetwork:(RACSignal *(^)(void))network
                     toMap:(id(^)(RACTuple *tuple))map
            subscriberNext:(BOOL(^)(id x))next
{
    @weakify(self);
    [self hsy_requestNetwork:network toMap:map subscriberNext:next error:^(NSError *error) {
        //统一处理失败事件
        @strongify(self);
        [self hsy_resultStatusCode:error];
    }];
}

- (void)hsy_requestNetwork:(RACSignal *(^)(void))network
            subscriberNext:(BOOL(^)(id x))next
{
    @weakify(self);
    [self hsy_requestNetwork:network toMap:^id(id value) {
        return value;
    } subscriberNext:next error:^(NSError *error) {
        //统一处理失败事件
        @strongify(self);
        [self hsy_resultStatusCode:error];
    }];
}

#pragma mark - dealloc

- (void)dealloc
{
    [self hsy_stop];
    [self.subject sendCompleted];
}

@end

