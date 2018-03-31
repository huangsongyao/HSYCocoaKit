//
//  NSObject+JSONWriting.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NSObject+JSONWriting.h"

@implementation NSObject (JSONWriting)

- (NSString *)JSONRepresentation
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
#if __has_feature(objc_arc)
        return result;
#else
        return [result autorelease];
#endif
    } else {
        return [self description];
    }
}

@end
