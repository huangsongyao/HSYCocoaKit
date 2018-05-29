//
//  NSArray+Finder.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSInteger const kDefaultFindFailureIndex;

@interface NSArray (Finder)

/**
 如果Object属于数组的元素，则返回该元素在数组中的位置，否则返回特定值kDefaultFindFailureIndex

 @param object Object
 @return 位置
 */
- (NSInteger)finderObject:(id)object;

/**
 判断Object是否为数组的元素

 @param object Object
 @return 是否为数组的成员元素
 */
- (BOOL)objectIsExist:(id)object;

/**
 如果Object属于数组的元素，则返回该元素在数组中的位置，否则返回0

 @param object Object
 @return 位置
 */
- (NSInteger)finderObjectIndex:(id)object;

@end
