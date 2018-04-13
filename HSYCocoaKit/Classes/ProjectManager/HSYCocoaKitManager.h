//
//  HSYCocoaKitManager.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import <Foundation/Foundation.h>

@interface HSYCocoaKitManager : NSObject

+ (instancetype)hsy_shareInstance;
+ (void)setObject:(id)object forKey:(NSString *)key;


@end
