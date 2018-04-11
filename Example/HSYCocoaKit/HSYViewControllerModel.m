//
//  HSYViewControllerModel.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/4/2.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYViewControllerModel.h"
#import "HSYCocoaKitSocketManager.h"

@implementation TestJ_SubModel


@end

@implementation TestJ_Model


@end

@interface HSYNetWorkingManager (test)

@end

@implementation HSYNetWorkingManager (test)

- (RACSignal *)test:(NSString *)path
{
    return [self.httpSessionManager hsy_rac_getRequest:path parameters:nil];
}

@end


@implementation HSYViewControllerModel

- (instancetype)init
{
    if (self = [super init]) {
        
//        @weakify(self);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            @strongify(self);
//            NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
//            [self requestNetwork:^RACSignal *{
//                return [[HSYNetWorkingManager shareInstance] test:urlStr];
//            } toMap:^id(RACTuple *tuple) {
//                id json = tuple.second;
//                return [NSObject resultObjectToJSONModelWithClasses:[TestJ_Model class] json:json];
//            } subscriberNext:^BOOL(id x) {
//                NSLog(@"x = %@", x);
//                _j_model = x;
//                return YES;
//            }];
//        });
        
        
//        NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
//        [self updateNext:^RACSignal *{
//            return [[HSYNetWorkingManager shareInstance] test:urlStr];
//        } toMap:^NSMutableArray *(RACTuple *tuple) {
//            NSMutableArray *array = [[NSMutableArray alloc] init];
//            id json = tuple.second;
//            [array addObject:[NSObject resultObjectToJSONModelWithClasses:[TestJ_Model class] json:json]];
//            return array;
//        } pullDown:kHSYReflesStatusTypePullDown];
        
        
//        [self.subject subscribeNext:^(id x) {
//            NSLog(@"");
//        }];
//        [self.subject subscribeNext:^(id x) {
//            NSLog(@"");
//        }];
//        
//        [self.subject sendNext:@"1"];
        
        
        [self test];
    }
    return self;
}

- (void)test
{
    [[[[HSYCocoaKitSocketManager shareInstance] hsy_connectServer:@"https://www.baidu.com"] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        NSLog(@"tuple.first = %@, tuple.second = %@", tuple.first, tuple.second);
    }];
}

@end
