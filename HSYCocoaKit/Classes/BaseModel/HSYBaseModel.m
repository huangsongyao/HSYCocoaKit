//
//  HSYBaseModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
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
        self.datas = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Timer

- (void)timerSubscribeNext:(void(^)(id x))next
{
    [self stop];
    _disposable = [[[RACSignal timerSignalOneMinute] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        if (next) {
            next(x);
        }
    }];
}

- (void)stop
{
    if (self.disposable) {
        [self.disposable dispose];
    }
}

#pragma mark - Button RACCommand For RACSignal

- (RACCommand *)createCommandWithSignal:(RACSignal *)signal
{
    RACCommand *command = [[RACCommand alloc] initWithEnabled:signal signalBlock:^RACSignal *(id input) {
        return [RACSignal empty];
    }];
    
    return command;
}

- (RACSignal *)createRACSignals:(id<NSFastEnumeration>)signals reduce:(id(^)())reduceBlock
{
    return [RACSignal combineLatest:signals reduce:reduceBlock];
}

- (RACCommand *)commandWithSignals:(id<NSFastEnumeration>)signals reduce:(id(^)())next
{
    RACCommand *command = [self createCommandWithSignal:[self createRACSignals:signals reduce:^id{
        if (next) {
            return next();
        }
        return @(NO);
    }]];
    return command;
}

#pragma mark - Datas Operation

- (void)rac_datasTraverseSubscribeNext:(void(^)(id result, NSNumber *index))next completed:(void(^)())completed
{
    [[[self.datas rac_traverseArray] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *value) {
        if (next) {
            next(value.allValues.firstObject, value.allKeys.firstObject);
        }
    } completed:^{
        if (completed) {
            completed();
        }
    }];
}

- (void)rac_filterUntilCondition:(BOOL(^)(id predicate))condition subscribeNext:(void(^)(id x))next completed:(void(^)())completed
{
    [[[self.datas rac_filterUntilCompleted:^BOOL(id predicate) {
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

- (void)resultStatusCode:(id)code
{
    if (!code) {
        return;
    }
    self.errorStatusCode = code;
}

- (void)requestNetwork:(RACSignal *(^)())network toMap:(id(^)(id value))map subscriberNext:(void(^)(id x))next error:(void(^)(NSError *error))error
{
    if (network) {
        RACSignal *signal = network();
        [[signal map:map] subscribeNext:^(id x) {
            if (next) {
                next(x);
            }
        } error:error];
    }
}

- (void)requestNetwork:(RACSignal *(^)())network toMap:(id(^)(id value))map subscriberNext:(void(^)(id x))next
{
    @weakify(self);
    [self requestNetwork:network toMap:map subscriberNext:next error:^(NSError *error) {
        //统一处理失败事件
        @strongify(self);
        [self resultStatusCode:error];
    }];
}

- (void)requestNetwork:(RACSignal *(^)())network subscriberNext:(void(^)(id x))next
{
    @weakify(self);
    [self requestNetwork:network toMap:^id(id value) {
        return value;
    } subscriberNext:next error:^(NSError *error) {
        //统一处理失败事件
        @strongify(self);
        [self resultStatusCode:error];
    }];
}

@end
