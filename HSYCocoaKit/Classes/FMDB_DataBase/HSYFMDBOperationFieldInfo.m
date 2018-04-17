//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYFMDBOperationFieldInfo.h"

@implementation HSYFMDBOperationFields

- (instancetype)initWithFieldName:(NSString *)name fieldType:(NSString *)type
{
    if (self = [super init]) {
        self.hsy_fieldName = name;
        self.hsy_fieldType = type;
    }
    return self;
}

+ (NSMutableArray *)hsy_toOperationFields:(NSMutableArray *)fieldsInfo
{
    if (fieldsInfo.count == 0) {
        return nil;
    }
    NSMutableArray *newFields = [NSMutableArray arrayWithCapacity:fieldsInfo.count];
    for (NSDictionary *dic in fieldsInfo) {
        HSYFMDBOperationFields *info = [[HSYFMDBOperationFields alloc] initWithFieldName:dic.allKeys.firstObject fieldType:dic.allValues.firstObject];
        [newFields addObject:info];
    }
    return newFields;
}

@end

@implementation HSYFMDBOperationFieldInfo

- (instancetype)init {
    if (self = [super init]) {
        
        self.hsy_fields = [NSMutableArray arrayWithCapacity:3];
        self.hsy_statements = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}

- (NSString *)hsy_toDataBaseTableField
{
    if (self.hsy_fields.count == 0) {
        return nil;
    }
    HSYFMDBOperationFields *firstInfo = [self.hsy_fields firstObject];
    NSString *field = [NSString stringWithFormat:@"%@ %@", firstInfo.hsy_fieldName, firstInfo.hsy_fieldType];
    for (NSInteger i = 1; i < self.hsy_fields.count; i ++) {
        HSYFMDBOperationFields *fieldInfo = self.hsy_fields[i];
        NSString *nextField = [NSString stringWithFormat:@"%@ %@", fieldInfo.hsy_fieldName, fieldInfo.hsy_fieldType];
        field = [NSString stringWithFormat:@"%@,%@", field, nextField];
    }
    return field;
}

- (NSString *)hsy_toDataBaseTableInsertStatements
{
    NSMutableArray *new = [[NSMutableArray alloc] init];
    for (NSString *obj in self.hsy_statements) {
        [new addObject:[NSString stringWithFormat:@"'%@'", obj]];
    }
    return [HSYFMDBOperationFieldInfo hsy_statementsForParams:new];
}

- (NSString *)hsy_toDataBaseTableInsertFields
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (HSYFMDBOperationFields *info in self.hsy_fields) {
        [temp addObject:info.hsy_fieldName];
    }
    return [HSYFMDBOperationFieldInfo hsy_statementsForParams:temp];
}

+ (NSString *)hsy_statementsForParams:(NSMutableArray <NSString *>*)params
{
    if (params.count == 0) {
        return nil;
    }
    NSString *statement = [params firstObject];
    for (NSInteger i = 1; i < params.count; i ++) {
        statement = [NSString stringWithFormat:@"%@,%@", statement, params[i]];
    }
    return statement;
}

- (NSDictionary *)hsy_toDictionaryFields
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < self.hsy_fields.count; i ++) {
        HSYFMDBOperationFields *field = self.hsy_fields[i];
        NSString *value = self.hsy_statements[i];
        dic[field.hsy_fieldName] = value;
    }
    return dic;
}

@end

@implementation HSYFMDBOperationFieldInfo (Show)

+ (HSYFMDBOperationFieldInfo *)hsy_createDataBaseTableForName:(NSString *)name fields:(NSMutableArray<HSYFMDBOperationFields *> *)fields
{
    HSYFMDBOperationFieldInfo *operationInfo = [[HSYFMDBOperationFieldInfo alloc] init];
    operationInfo.hsy_name = name;
    operationInfo.hsy_fields = fields;
    return operationInfo;
}

+ (HSYFMDBOperationFieldInfo *)hsy_createDataBaseTableForName:(NSString *)name fields:(NSMutableArray<HSYFMDBOperationFields *> *)fields insertDatas:(NSMutableArray<NSString *> *)statements
{
    HSYFMDBOperationFieldInfo *operationInfo = [[HSYFMDBOperationFieldInfo alloc] init];
    operationInfo.hsy_name = name;
    operationInfo.hsy_statements = statements;
    operationInfo.hsy_fields = fields;
    return operationInfo;
}

@end
