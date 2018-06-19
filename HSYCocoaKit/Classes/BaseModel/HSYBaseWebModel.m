//
//  HSYBaseWebModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseWebModel.h"

@implementation HSYBaseWebModel

- (instancetype)initWithUrlString:(NSString *)urlString runNativeName:(NSString *)name
{
    if (self = [super init]) {
        BOOL canOpen = [urlString hasPrefix:@"http"];
        NSAssert(canOpen != NO, @"warning！！通常链接必须含有http协议");
        _hsy_url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        _hsy_runNativeName = name;
    }
    return self;
}

- (instancetype)initWithHtmlString:(NSString *)htmlString runNativeName:(NSString *)name
{
    if (self = [super init]) {
        _hsy_htmlString = htmlString;
        _hsy_runNativeName = name;
    }
    return self;
}

@end
