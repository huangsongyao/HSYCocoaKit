//
//  FMResultSet+Model.m
//  HSYFMDBDatabaseManager
//
//  Created by huangsongyao on 17/2/27.
//  Copyright © 2017年 huangsongyao. All rights reserved.
//

#import "FMResultSet+Model.h"
#import "HSYFMDBOperationFieldInfo.h"

@implementation FMResultSet (Model)

- (NSMutableDictionary *)fmdbForColumn:(HSYFMDBOperationFieldInfo *)operation
{    
    NSMutableDictionary *paramter = [[NSMutableDictionary alloc] initWithCapacity:operation.fields.count];
    for (HSYFMDBOperationFields *field in operation.fields) {
        NSString *param = [self objectForColumn:field.fieldName];
        paramter[field.fieldName] = param;
    }
    return paramter;
}

@end
