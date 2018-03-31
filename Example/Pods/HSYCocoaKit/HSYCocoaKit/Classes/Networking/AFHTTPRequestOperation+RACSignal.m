//
//  AFHTTPRequestOperation+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "AFHTTPRequestOperation+RACSignal.h"

@implementation AFHTTPRequestOperation (RACSignal)

- (RACSignal *)rac_overrideHTTPCompletionBlock {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
#ifdef RAFN_MAINTAIN_COMPLETION_BLOCKS
        void(^oldCompBlock)() = self.completionBlock;
#endif
        //AFHTTPRequestOperation请求
        [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [subscriber sendNext:responseObject];//发送rac 的hot signal
            [subscriber sendCompleted];//发送完毕
#ifdef RAFN_MAINTAIN_COMPLETION_BLOCKS
            if (oldCompBlock) {
                oldCompBlock();
            }
#endif
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [subscriber sendError:error]; //发送请求失败的error
        }];
        
        //发送取消
        return [RACDisposable disposableWithBlock:^{
            [self cancel];
        }];
    }];
}


@end
