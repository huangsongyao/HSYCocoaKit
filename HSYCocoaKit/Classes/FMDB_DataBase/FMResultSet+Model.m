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

- (NSMutableDictionary *)hsy_fmdbForColumn:(HSYFMDBOperationFieldInfo *)operation
{    
    NSMutableDictionary *paramter = [[NSMutableDictionary alloc] initWithCapacity:operation.hsy_fields.count];
    for (HSYFMDBOperationFields *field in operation.hsy_fields) {
        NSString *param = [self objectForColumn:field.hsy_fieldName];
        paramter[field.hsy_fieldName] = param;
    }
    return paramter;
}

@end
