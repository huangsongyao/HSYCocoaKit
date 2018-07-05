//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
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
