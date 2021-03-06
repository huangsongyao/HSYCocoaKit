//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYFMDBOperation.h"
#import "HSYFMDBOperationFieldInfo.h"
#import "ReactiveCocoa.h"
#import "FMResultSet+Model.h"
#import "APPPathMacroFile.h"
#import "PublicMacroFile.h"

@interface HSYFMDBOperation ()

@property (nonatomic, strong) NSMutableArray <HSYFMDBOperationFieldInfo *>*databaseTables;
@property (nonatomic, copy, readonly) NSString *databaseName;

@end

@implementation HSYFMDBOperation

- (instancetype)initWithDatabaseTables:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)tables databaseName:(NSString *)name
{
    if (self = [super init]) {
        _databaseTables = tables;                               //数据表名，集合
        _databaseName = name;                                   //数据库名称
        [self hsy_initDB];
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self hsy_dataBasePath]];
    }
    return self;
}

#pragma mark - Init DataBase

- (void)hsy_initDB
{    
    _dateBase = [self hsy_inits];                                       //创建数据库
    _dateBasePath = [self hsy_dataBasePath];                            //数据库路径
    self.dateBase.traceExecution = YES;                                 //跟踪执行
    if ([self.dateBase open]) {
        for (HSYFMDBOperationFieldInfo *operation in self.databaseTables) {
            BOOL isExist = [self.dateBase tableExists:operation.hsy_name];
            if (isExist) {
                NSLog(@"%@ existing", operation.hsy_name);
            } else {
                BOOL result = [self.dateBase executeUpdateWithFormat:[NSString stringWithFormat:@"CREATE TABLE %@ (%@)", operation.hsy_name, [operation hsy_toDataBaseTableField]], nil];
                if (result) {
                    NSLog(@"%@ create successful", operation.hsy_name);
                } else {
                    NSLog(@"%@ create failure", operation.hsy_name);
                }
            }
        }
        [self.dateBase close];                                      //关闭数据库
    } else {
        NSLog(@"FMDB open failure");
    }
}

- (void)hsy_fmdb_operationForExecuteUpdateBlock:(id(^)(void))block completed:(void(^)(id x))completed
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

//********************************************串行队列*************************************************//

- (void)hsy_fmdb_synchronouslyQueueInDatabase:(RACSignal *(^)(FMDatabase *db))database
{
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if (database) {
            [[database(db) deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^{
                [db close];
            }];
        }
    }];
}

- (void)hsy_fmdb_synchronouslyQueueTransactionInDatabase:(RACSignal *(^)(FMDatabase *db, BOOL *rollback))database
{
    [self.databaseQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        if (database) {
            [[database(db, rollback) deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^{
                
            }];
        }
    }];
}

//********************************************数据库操作*************************************************//

#pragma mark - Insert Data

- (void)hsy_fmdb_insertDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                  completed:(void(^)(BOOL result, HSYFMDBOperationFieldInfo *info))completed
{
    @weakify(self);
    [self hsy_fmdb_operationForExecuteUpdateBlock:^{
        @strongify(self);
        BOOL result = [self hsy_fmdb_insertDataForOperationInfo:operationInfo];
        return @(result);
    } completed:^(id x){
        if (completed) {
            completed([x boolValue], operationInfo);
        }
    }];
}

- (void)hsy_fmdb_beginTransactionInsertDataForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos completed:(void(^)(BOOL result))completed
{
    if (![self.dateBase open]) {
        return;
    }
    [self.dateBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (HSYFMDBOperationFieldInfo *operationInfo in operationInfos) {
            [self hsy_fmdb_insertDataForOperationInfo:operationInfo];
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

- (BOOL)hsy_fmdb_insertDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
{
    BOOL result = NO;
    result = [self.dateBase executeUpdateWithFormat:[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)", operationInfo.hsy_name, [operationInfo hsy_toDataBaseTableInsertFields], [operationInfo hsy_toDataBaseTableInsertStatements]], nil];
    if (!result) {
        NSLog(@"Insert %@ Failure!", [operationInfo hsy_toDataBaseTableInsertStatements]);
    }
    return result;
}

- (RACSignal *)hsy_fmdb_insertDataQueueForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_fmdb_synchronouslyQueueInDatabase:^RACSignal *(FMDatabase *db) {
            @strongify(self);
            [self hsy_fmdb_insertDataForOperationInfo:operationInfo completed:^(BOOL result, HSYFMDBOperationFieldInfo *info) {
                RACTuple *tuple = RACTuplePack(@(result), info);
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
            return [RACSignal empty];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_fmdb_insertDataQueueForOperationInfo:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

- (RACSignal *)hsy_fmdb_beginTransactionInsertDataQueueForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_fmdb_synchronouslyQueueInDatabase:^RACSignal *(FMDatabase *db) {
            [self hsy_fmdb_beginTransactionInsertDataForOperationInfos:operationInfos completed:^(BOOL result) {
                RACTuple *tuple = RACTuplePack(@(result));
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
            return [RACSignal empty];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_fmdb_beginTransactionInsertDataQueueForOperationInfos:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

#pragma mark - Query Data

- (void)hsy_fmdb_queryAllDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                    completed:(void(^)(NSMutableArray *result))completed
{
    @weakify(self);
    [self hsy_fmdb_operationForExecuteUpdateBlock:^{
        @strongify(self);
        NSMutableArray *contentArray = [[NSMutableArray alloc] init];
        FMResultSet *resultSet = [self.dateBase executeQueryWithFormat:[NSString stringWithFormat:@"SELECT * FROM %@", operationInfo.hsy_name], nil];
        while ([resultSet next]) {
            NSMutableDictionary *result = [resultSet hsy_fmdbForColumn:operationInfo];
            [contentArray addObject:result];
        }
        return contentArray;
    } completed:^(NSMutableArray *result){
        if(completed) {
            completed(result);
        }
    }];
}

- (void)hsy_fmdb_queryDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                whereField:(NSString *)field
                              whereContent:(NSString *)content
                                 completed:(void(^)(NSMutableArray *result))completed
{
    @weakify(self);
    [self hsy_fmdb_operationForExecuteUpdateBlock:^{
        @strongify(self);
        NSMutableArray *contentArray = [[NSMutableArray alloc] init];
        FMResultSet *resultSet = [self.dateBase executeQueryWithFormat:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'", operationInfo.hsy_name, field, content], nil];
        while ([resultSet next]) {
            NSMutableDictionary *result = [resultSet hsy_fmdbForColumn:operationInfo];
            [contentArray addObject:result];
        }
        return contentArray;
    } completed:^(NSMutableArray *result){
        if(completed) {
            completed(result);
        }
    }];
}

- (RACSignal *)hsy_fmdb_queryAllDataQueueForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_fmdb_synchronouslyQueueInDatabase:^RACSignal *(FMDatabase *db) {
            @strongify(self);
            [self hsy_fmdb_queryAllDataForOperationInfo:operationInfo completed:^(NSMutableArray *result) {
                RACTuple *tuple = RACTuplePack(result);
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
            return [RACSignal empty];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_fmdb_queryAllDataQueueForOperationInfo:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

- (RACSignal *)hsy_fmdb_queryDataForQueueOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                            whereField:(NSString *)field
                                          whereContent:(NSString *)content
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_fmdb_synchronouslyQueueInDatabase:^RACSignal *(FMDatabase *db) {
            @strongify(self);
            [self hsy_fmdb_queryDataForOperationInfo:operationInfo whereField:field whereContent:content completed:^(NSMutableArray *result) {
                RACTuple *tuple = RACTuplePack(result);
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
            return [RACSignal empty];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_fmdb_queryDataForQueueOperationInfo:whereField:whereContent:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

#pragma mark - Delete Data

- (void)hsy_fmdb_deleteRowDataForTableName:(NSString *)tableName
                               deleteValue:(NSString *)value
                                whereField:(NSString *)field
                                 completed:(void(^)(BOOL result))completed
{
    @weakify(self);
    [self hsy_fmdb_operationForExecuteUpdateBlock:^id{
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

- (RACSignal *)hsy_fmdb_deleteRowDataQueueForTableName:(NSString *)tableName
                                           deleteValue:(NSString *)value
                                            whereField:(NSString *)field
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_fmdb_synchronouslyQueueInDatabase:^RACSignal *(FMDatabase *db) {
            @strongify(self);
            [self hsy_fmdb_deleteRowDataForTableName:tableName deleteValue:value whereField:field completed:^(BOOL result) {
                RACTuple *tuple = RACTuplePack(@(result));
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
            return [RACSignal empty];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_fmdb_deleteRowDataQueueForTableName:deleteValue:whereField:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

#pragma mark - Modify Data

- (void)hsy_fmdb_modifyDataForTableName:(NSString *)tableName
                            updateField:(NSString *)updateField
                          updateContent:(NSString *)updateContent
                             whereField:(NSString *)whereField
                           whereContent:(NSString *)whereContent
                              completed:(void(^)(BOOL result))completed
{
    @weakify(self);
    [self hsy_fmdb_operationForExecuteUpdateBlock:^id{
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

- (RACSignal *)hsy_fmdb_modifyDataQueueForTableName:(NSString *)tableName
                                        updateField:(NSString *)updateField
                                      updateContent:(NSString *)updateContent
                                         whereField:(NSString *)whereField
                                       whereContent:(NSString *)whereContent
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_fmdb_synchronouslyQueueInDatabase:^RACSignal *(FMDatabase *db) {
            @strongify(self);
            [self hsy_fmdb_modifyDataForTableName:tableName updateField:updateField updateContent:updateContent whereField:whereField whereContent:whereContent completed:^(BOOL result) {
                RACTuple *tuple = RACTuplePack(@(result));
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
            return [RACSignal empty];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_fmdb_modifyDataQueueForTableName:updateField:updateContent:whereField:whereContent” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

#pragma mark - Clean Table

- (void)hsy_fmdb_clearDataToTableName:(NSString *)tableName completed:(void(^)(BOOL result))completed
{
    @weakify(self);
    [self hsy_fmdb_operationForExecuteUpdateBlock:^id{
        @strongify(self);
        BOOL result = [self.dateBase executeUpdateWithFormat:[NSString stringWithFormat:@"DELETE FROM %@", tableName], nil];
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

- (RACSignal *)hsy_fmdb_clearDataQueueToTableName:(NSString *)tableName
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_fmdb_synchronouslyQueueInDatabase:^RACSignal *(FMDatabase *db) {
            @strongify(self);
            [self hsy_fmdb_clearDataToTableName:tableName completed:^(BOOL result) {
                RACTuple *tuple = RACTuplePack(@(result));
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
            return [RACSignal empty];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_fmdb_clearDataQueueToTableName” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

//***********************************************创建数据库**********************************************//

#pragma mark - Create DataBase

- (FMDatabase *)hsy_inits
{
    NSString *databasePath = [self hsy_dataBasePath];
    NSLog(@"databasePath = %@", databasePath);
    //创建数据库
    FMDatabase *db = [[FMDatabase alloc] initWithPath:databasePath];
    return db;
}

//**********************************************数据库缓存路径*******************************************//

#pragma mark - SQL Path

+ (NSString *)hsy_applicationDocumentsDirectory
{
    return kPATH_DOCUMENT;
}

+ (NSString *)hsy_userDocumentsDirectory
{
    return [HSYFMDBOperation hsy_applicationDocumentsDirectory];
}

- (NSString *)hsy_dataBasePath
{
    NSString *databasePath =  [HSYFMDBOperation hsy_userDocumentsDirectory];
    databasePath = [databasePath stringByAppendingPathComponent:self.databaseName];
    return databasePath;
}

@end
