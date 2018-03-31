//
//  AFHTTPRequestOperationManager+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSUInteger, kUpdateProfileType) {
    
    kUpdateProfileTypeParam     = 0 ,   //默认为param字段
    kUpdateProfileTypeImage     = 1 ,   //图片类型
    kUpdateProfileTypeAudio     = 2 ,   //音频类型
    kUpdateProfileTypeVideo     = 3 ,   //视频类型
    
};

static NSString *const kHttpErrorHeadKey    = @"x-hsy-ret";             //请求头字段
static NSString *const kHttpHeaderFieldKey  = @"X-Access-Token";        //请求头字段

@interface AFHTTPRequestOperationManager (RACSignal)

/**
 *  post请求
 *
 *  @param path      请求路径段
 *  @param paramters post body
 *
 *  @return post请求返回的数据信号
 */
- (RACSignal *)rac_POSTWithPath:(NSString *)path paramters:(NSDictionary *)paramters;

/**
 *  get请求
 *
 *  @param path      请求路径段
 *  @param paramters 拼接字段
 *
 *  @return get请求返回的数据信号
 */
- (RACSignal *)rac_GETWithPath:(NSString *)path paramters:(NSDictionary *)paramters;


@end
