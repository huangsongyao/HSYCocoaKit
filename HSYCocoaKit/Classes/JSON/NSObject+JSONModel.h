//
//  NSObject+JSONModel.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+JSONWriting.h"
#import "NSObject+JSONObjc.h"
#import "NSString+JSONParsing.h"

@interface NSObject (JSONModel)

/**
 *  JSONModel解析范畴__实例方法
 *
 *  @param classes JSONModel子类类名
 *  @param json    json数据
 *
 *  @return 解析后的bean抽象对象
 */
- (id)hsy_resultObjectToJSONModelWithClasses:(Class)classes json:(id)json;
/**
 *  JSONModel解析范畴__类方法
 *
 *  @param classes JSONModel子类类名
 *  @param json    json数据
 *
 *  @return 解析后的bean抽象对象
 */
+ (id)hsy_resultObjectToJSONModelWithClasses:(Class)classes json:(id)json;


@end
