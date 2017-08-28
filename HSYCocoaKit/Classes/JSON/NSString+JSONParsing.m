//
//  NSString+JSONParsing.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NSString+JSONParsing.h"

@implementation NSString (JSONParsing)

- (id)JSONValue
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) {
        return nil;
    }
    return result;
}

- (NSDictionary *)value
{
    return (NSDictionary *)self.JSONValue;
}

@end
