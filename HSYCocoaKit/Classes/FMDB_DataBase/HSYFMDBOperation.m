//
//  HSYFMDBOperation.m
//  HSYFMDBDatabaseManager
//
//  Created by huangsongyao on 17/2/27.
//  Copyright © 2017年 huangsongyao. All rights reserved.
//

#import "HSYFMDBOperation.h"
#import "HSYFMDBOperationFieldInfo.h"
#import "ReactiveCocoa.h"
#import "FMResultSet+Model.h"
#import "HSYFMDBMacro.h"

@interface HSYFMDBOperation ()

@property (nonatomic, strong) NSMutableArray <HSYFMDBOperationFieldInfo *>*databaseTables;

@end
@implementation HSYFMDBOperation

- (instancetype)initWithDatabaseTables:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)tables
{
    if (self = [super init]) {
        _databaseTables = tables;                               //数据表名，集合
        [self initDB];
    }
    return self;
}

#pragma mark - Init DataBase

- (void)initDB
{    
    _dateBase = [HSYFMDBOperation inits];                           //创建数据库
    _dateBasePath = [HSYFMDBOperation dataBasePath];                //数据库路径
    self.dateBase.traceExecution = YES;                             //跟踪执行
    if ([self.dateBase open]) {
        for (HSYFMDBOperationFieldInfo *operation in self.databaseTables) {
            BOOL isExist = [self.dateBase tableExists:operation.name];
            if (isExist) {
                NSLog(@"%@ existing", operation.name);
            } else {
                BOOL result = [self.dateBase executeUpdateWithFormat:[NSString stringWithFormat:@"CREATE TABLE %@ (%@)", operation.name, [operation toDataBaseTableField]], nil];
                if (result) {
                    NSLog(@"%@ create successful", operation.name);
                } else {
                    NSLog(@"%@ create failure", operation.name);
                }
            }
        }
        [self.dateBase close];                                      //关闭数据库
    } else {
        NSLog(@"FMDB open failure");
    }
}

- (void)fmdb_operationForExecuteUpdateBlock:(id(^)())block completed:(void(^)(id x))completed
{
    if (![self.dateBase open]) {
        return;
    }
    id result = nil;
    if(block) {
        result = block();
    }
    [self.dateBase close];
    if (result && completed) {
        completed(result);
    }
}

//********************************************数据库操作*************************************************//

#pragma mark - Insert Data

- (void)fmdb_insertDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                              completed:(void(^)(BOOL result, HSYFMDBOperationFieldInfo *info))completed
{
    @weakify(self);
    [self fmdb_operationForExecuteUpdateBlock:^{
        @strongify(self);
        BOOL result = [self fmdb_insertDataForOperationInfo:operationInfo];
        return @(result);
    } completed:^(id x){
        if (completed) {
            completed([x boolValue], operationInfo);
        }
    }];
}

- (void)fmdb_beginTransactionInsertDataForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos
                                               completed:(void(^)(BOOL result))completed
{
    if (![self.dateBase open]) {
        return;
    }
    [self.dateBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (HSYFMDBOperationFieldInfo *operationInfo in operationInfos) {
            [self fmdb_insertDataForOperationInfo:operationInfo];
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        BOOL result = [self.dateBase rollback];
        if (completed) {
            completed(result);
        }
    }
    @finally {
        if (!isRollBack) {
            BOOL result = [self.dateBase commit];
            if (completed) {
                completed(result);
            }
        }
    }
    [self.dateBase close];
}

- (BOOL)fmdb_insertDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
{
    BOOL result = NO;
    result = [self.dateBase executeUpdateWithFormat:[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)", operationInfo.name, [operationInfo toDataBaseTableInsertFields], [operationInfo toDataBaseTableInsertStatements]], nil];
    if (!result) {
        NSLog(@"Insert %@ Failure!", [operationInfo toDataBaseTableInsertStatements]);
    }
    return result;
}

#pragma mark - Query Data

- (void)fmdb_queryAllDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                completed:(void(^)(NSMutableArray *result))completed
{
    @weakify(self);
    [self fmdb_operationForExecuteUpdateBlock:^{
        @strongify(self);
        NSMutableArray *contentArray = [[NSMutableArray alloc] init];
        FMResultSet *resultSet = [self.dateBase executeQueryWithFormat:[NSString stringWithFormat:@"SELECT * FROM %@", operationInfo.name], nil];
        while ([resultSet next]) {
            NSMutableDictionary *result = [resultSet fmdbForColumn:operationInfo];
            [contentArray addObject:result];
        }
        return contentArray;
    } completed:^(NSMutableArray *result){
        if(completed) {
            completed(result);
        }
    }];
}

- (void)fmdb_queryDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                            whereField:(NSString *)field
                          whereContent:(NSString *)content
                             completed:(void(^)(NSMutableArray *result))completed
{
    @weakify(self);
    [self fmdb_operationForExecuteUpdateBlock:^{
        @strongify(self);
        NSMutableArray *contentArray = [[NSMutableArray alloc] init];
        FMResultSet *resultSet = [self.dateBase executeQueryWithFormat:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'", operationInfo.name, field, content], nil];
        while ([resultSet next]) {
            NSMutableDictionary *result = [resultSet fmdbForColumn:operationInfo];
            [contentArray addObject:result];
        }
        return contentArray;
    } completed:^(NSMutableArray *result){
        if(completed) {
            completed(result);
        }
    }];
}

#pragma mark - Delete Data

- (void)fmdb_deleteRowDataForTableName:(NSString *)tableName
                           deleteValue:(NSString *)value
                            whereField:(NSString *)field
                             completed:(void(^)(BOOL result))completed
{
    @weakify(self);
    [self fmdb_operationForExecuteUpdateBlock:^id{
        @strongify(self);
        BOOL result = [self.dateBase executeUpdateWithFormat:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'", tableName, field, value], nil];
        if (!result) {
            NSLog(@"delete %@ = %@ failure", field, value);
        }
        return @(result);
    } completed:^(id x) {
        if (completed) {
            completed([x boolValue]);
        }
    }];
}

#pragma mark - Modify Data

- (void)fmdb_modifyDataForTableName:(NSString *)tableName
                        updateField:(NSString *)updateField
                      updateContent:(NSString *)updateContent
                         whereField:(NSString *)whereField
                       whereContent:(NSString *)whereContent
                          completed:(void(^)(BOOL result))completed
{
    @weakify(self);
    [self fmdb_operationForExecuteUpdateBlock:^id{
        @strongify(self);
        BOOL result = [self.dateBase executeUpdateWithFormat:[NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@'", tableName, updateField, updateContent, whereField, whereContent], nil];
        if (!result) {
            NSLog(@"Update %@ Set %@ = %@ failure", tableName, updateField, updateContent);
        }
        return @(result);
        
    } completed:^(id x) {
        if (completed) {
            completed([x boolValue]);
        }
    }];
}

#pragma mark - Clean Table

- (void)fmdb_clearDataToTableName:(NSString *)tableName completed:(void(^)(BOOL result))completed
{
    @weakify(self);
    [self fmdb_operationForExecuteUpdateBlock:^id{
        @strongify(self);
        BOOL result =[self.dateBase executeUpdateWithFormat:[NSString stringWithFormat:@"DELETE FROM %@", tableName], nil];
        if (!result) {
            NSLog(@"clear %@ failure", tableName);
        }
        return @(result);
    } completed:^(id x) {
        if (completed) {
            completed([x boolValue]);
        }
    }];
}

//***********************************************创建数据库**********************************************//

#pragma mark - Create DataBase

+ (FMDatabase *)inits
{
    NSString *databasePath = [HSYFMDBOperation dataBasePath];
    //创建数据库
    FMDatabase *db = [[FMDatabase alloc] initWithPath:databasePath];
    return db;
}

//**********************************************数据库缓存路径*******************************************//

#pragma mark - SQL Path

+ (NSString *)applicationDocumentsDirectory
{
    return PATH_DOCUMENT;
}

+ (NSString *)userDocumentsDirectory
{
    return [HSYFMDBOperation applicationDocumentsDirectory];
}

+ (NSString *)dataBasePath
{
    NSString *databasePath =  [HSYFMDBOperation userDocumentsDirectory];
    databasePath = [databasePath stringByAppendingPathComponent:FMDB_DATABASE_FILE_NAME];
    return databasePath;
}

@end
