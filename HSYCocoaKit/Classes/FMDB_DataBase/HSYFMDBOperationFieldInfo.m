//
//  HSYFMDBOperationFieldInfo.m
//  HSYFMDBDatabaseManager
//
//  Created by huangsongyao on 17/2/27.
//  Copyright © 2017年 huangsongyao. All rights reserved.
//

#import "HSYFMDBOperationFieldInfo.h"

@implementation HSYFMDBOperationFields

- (instancetype)initWithFieldName:(NSString *)name fieldType:(NSString *)type
{
    if (self = [super init]) {
        _fieldName = name;
        _fieldType = type;
    }
    return self;
}

+ (NSMutableArray *)toOperationFields:(NSMutableArray *)fieldsInfo
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
        
        _fields = [NSMutableArray arrayWithCapacity:3];
        _statements = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}

- (NSString *)toDataBaseTableField
{
    if (self.fields.count == 0) {
        return nil;
    }
    HSYFMDBOperationFields *firstInfo = [self.fields firstObject];
    NSString *field = [NSString stringWithFormat:@"%@ %@", firstInfo.fieldName, firstInfo.fieldType];
    for (NSInteger i = 1; i < self.fields.count; i ++) {
        HSYFMDBOperationFields *fieldInfo = self.fields[i];
        NSString *nextField = [NSString stringWithFormat:@"%@ %@", fieldInfo.fieldName, fieldInfo.fieldType];
        field = [NSString stringWithFormat:@"%@,%@", field, nextField];
    }
    return field;
}

- (NSString *)toDataBaseTableInsertStatements
{
    NSMutableArray *new = [[NSMutableArray alloc] init];
    for (NSString *obj in self.statements) {
        [new addObject:[NSString stringWithFormat:@"'%@'", obj]];
    }
    return [HSYFMDBOperationFieldInfo statementsForParams:new];
}

- (NSString *)toDataBaseTableInsertFields
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (HSYFMDBOperationFields *info in self.fields) {
        [temp addObject:info.fieldName];
    }
    return [HSYFMDBOperationFieldInfo statementsForParams:temp];
}

+ (NSString *)statementsForParams:(NSMutableArray <NSString *>*)params
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

- (NSDictionary *)toDictionaryFields
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < self.fields.count; i ++) {
        HSYFMDBOperationFields *field = self.fields[i];
        NSString *value = self.statements[i];
        dic[field.fieldName] = value;
    }
    return dic;
}

@end

@implementation HSYFMDBOperationFieldInfo (Show)

+ (HSYFMDBOperationFieldInfo *)createDataBaseTableForName:(NSString *)name fields:(NSMutableArray<HSYFMDBOperationFields *> *)fields
{
    HSYFMDBOperationFieldInfo *operationInfo = [[HSYFMDBOperationFieldInfo alloc] init];
    operationInfo.name = name;
    operationInfo.fields = fields;
    return operationInfo;
}

+ (HSYFMDBOperationFieldInfo *)createDataBaseTableForName:(NSString *)name fields:(NSMutableArray<HSYFMDBOperationFields *> *)fields insertDatas:(NSMutableArray<NSString *> *)statements
{
    HSYFMDBOperationFieldInfo *operationInfo = [[HSYFMDBOperationFieldInfo alloc] init];
    operationInfo.name = name;
    operationInfo.statements = statements;
    operationInfo.fields = fields;
    return operationInfo;
}

@end