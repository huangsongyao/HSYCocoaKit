//
//  AFHTTPRequestOperation+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface AFHTTPRequestOperation (RACSignal)

/**
 *  覆盖http请求完成后的回调信号
 *
 *  @return 请求返回的数据信号
 */
- (RACSignal *)rac_overrideHTTPCompletionBlock;

@end
