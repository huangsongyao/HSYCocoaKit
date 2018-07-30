//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYFMDBOperationManager+Operation.h"
#import "HSYFMDBOperationFieldInfo.h"
#import "HSYFMDBOperation.h"
#import "ReactiveCocoa.h"

@implementation HSYFMDBOperationManager (Operation)

#pragma mark - Insert

- (void)hsy_insertDataToTableName:(NSString *)tableName
                      fieldParams:(NSMutableArray <NSDictionary *>*)params
                      insertDatas:(NSMutableArray <NSString *>*)datas
                        completed:(void(^)(BOOL result, HSYFMDBOperationFieldInfo *info))completed
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationManager hsy_createDatabaseOperationInfoForTableName:tableName fieldParams:params insertDatas:datas];
    [[[[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_insertDataQueueForOperationInfo:operation] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        if (completed) {
            completed([tuple.first boolValue], tuple.second);
        }
    }];
}

- (void)hsy_beginTransactionInsertDataForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos completed:(void(^)(BOOL result))completed
{
    [[[[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_beginTransactionInsertDataQueueForOperationInfos:operationInfos] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        if (completed) {
            completed([tuple.first boolValue]);
        }
    }];
}

#pragma mark - Delete

- (void)hsy_deleteDataToTableName:(NSString *)tableName
                      deleteValue:(NSString *)value
                       whereField:(NSString *)field
                        completed:(void(^)(BOOL result))completed
{
    [[[[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_deleteRowDataQueueForTableName:tableName deleteValue:value whereField:field] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        if (completed) {
            completed([tuple.first boolValue]);
        }
    }];
}

#pragma mark - Clean

- (void)hsy_cleanTableName:(NSString *)tableName completed:(void(^)(BOOL result))completed
{
    [[[[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_clearDataQueueToTableName:tableName] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        if (completed) {
            completed([tuple.first boolValue]);
        }
    }];
}

- (void)hsy_cleanAllTableForCompleted:(void (^)(BOOL result, NSString *tableName))completed
{
    [self hsy_cleanTableNames:self.tableNames completed:^(BOOL result, NSString *tableName) {
                                if (completed) {
                                    completed(result, tableName);
                                }
                            }];
}

- (void)hsy_cleanTableNames:(NSArray <NSString *>*)tableNames completed:(void (^)(BOOL result, NSString *tableName))completed
{
    for (NSString *tableName in tableNames) {
        [self hsy_cleanTableName:tableName completed:^(BOOL result) {
            if (completed && !result) {
                //某个表单清空失败时才回调
                completed(result, [NSString stringWithFormat:@"%@ clean failure", tableName]);
            }
        }];
    }
}

#pragma mark - Query

- (void)hsy_queryAllDataForTableName:(NSString *)tableName fieldParams:(NSMutableArray<NSDictionary *> *)params hsy_completed:(void (^)(NSMutableArray *))completed
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationManager hsy_createDatabaseOperationInfoForTableName:tableName fieldParams:params];
    [[[[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_queryAllDataQueueForOperationInfo:operation] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        if (completed) {
            completed(tuple.first);
        }
    }];
}

- (void)hsy_queryDataForTableName:(NSString *)tableName
                      fieldParams:(NSMutableArray <NSDictionary *>*)params
                       whereField:(NSString *)whereField
                     whereContent:(NSString *)whereContent
                        completed:(void(^)(NSMutableArray *result))completed
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationManager hsy_createDatabaseOperationInfoForTableName:tableName fieldParams:params];
    [[[[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_queryDataForQueueOperationInfo:operation whereField:whereField whereContent:whereContent] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        if (completed) {
            completed(tuple.first);
        }
    }];
}

#pragma mark - Modify

- (void)hsy_modifyDataForTableName:(NSString *)tableName
                       updateField:(NSString *)updateField
                     updateContent:(NSString *)updateContent
                        whereField:(NSString *)whereField
                      whereContent:(NSString *)whereContent
                         completed:(void(^)(BOOL result))completed
{
    [[[[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_modifyDataQueueForTableName:tableName updateField:updateField updateContent:updateContent whereField:whereField whereContent:whereContent] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        if (completed) {
            completed([tuple.first boolValue]);
        }
    }];
}

@end
