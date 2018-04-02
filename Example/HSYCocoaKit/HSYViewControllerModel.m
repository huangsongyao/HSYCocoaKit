//
//  HSYViewControllerModel.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/4/2.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYViewControllerModel.h"
#import <JSONModel/JSONModel.h>

@interface TestJ_SubModel : JSONModel

@property (nonatomic, strong) NSNumber <Optional>*hardware;
@property (nonatomic, strong) NSNumber <Optional>*createDate;
@property (nonatomic, strong) NSNumber <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*msg;
@property (nonatomic, strong) NSString <Optional>*sec;
@property (nonatomic, strong) NSNumber <Optional>*version;



@end

@implementation TestJ_SubModel


@end

@protocol TestJ_SubModel;
@interface TestJ_Model : JSONModel

@property (nonatomic, strong) NSString <Optional>*code;
@property (nonatomic, strong) NSString <Optional>*msg;
@property (nonatomic, strong) TestJ_SubModel <Optional>*data;

@end

@implementation TestJ_Model


@end

@interface HSYNetWorkingManager (test)

@end

@implementation HSYNetWorkingManager (test)

- (RACSignal *)test:(NSString *)path
{
    return [self.httpSessionManager rac_getRequest:path parameters:nil];
}

@end


@implementation HSYViewControllerModel

- (instancetype)init
{
    if (self = [super init]) {
        NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
        [self requestNetwork:^RACSignal *{
            return [[HSYNetWorkingManager shareInstance] test:urlStr];
        } toMap:^id(RACTuple *tuple) {
            id json = tuple.second;
            return [NSObject resultObjectToJSONModelWithClasses:[TestJ_Model class] json:json];
        } subscriberNext:^(id x) {
            NSLog(@"");
        }];
        
//        [[[[HSYNetWorkingManager shareInstance] test:urlStr] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
//            NSLog(@"tuple = %@", tuple);
//        } error:^(NSError *error) {
//            NSLog(@"error = %@", error);
//        }];
    }
    return self;
}

@end
