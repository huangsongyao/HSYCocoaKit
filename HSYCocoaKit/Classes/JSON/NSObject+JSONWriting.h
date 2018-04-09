//
//  NSObject+JSONWriting.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONWriting)

/**
 json对象转json字符串

 @return json字符串
 */
- (NSString *)JSONRepresentation;

@end
