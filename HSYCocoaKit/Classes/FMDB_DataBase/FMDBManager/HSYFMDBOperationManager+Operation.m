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

@implementation HSYFMDBOperationManager (Operation)

#pragma mark - Insert


- (void)hsy_insertDataToTableName:(NSString *)tableName
                      fieldParams:(NSMutableArray <NSDictionary *>*)params
                      insertDatas:(NSMutableArray <NSString *>*)datas
                        completed:(void(^)(BOOL result, HSYFMDBOperationFieldInfo *info))completed
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationManager hsy_createDatabaseOperationInfoForTableName:tableName fieldParams:params insertDatas:datas];
    [[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_insertDataForOperationInfo:operation completed:^(BOOL result, HSYFMDBOperationFieldInfo *info) {
        if (completed) {
            completed(result, info);
        }
    }];
}

- (void)hsy_beginTransactionInsertDataForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos
                                              completed:(void(^)(BOOL result))completed
{
    [[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_beginTransactionInsertDataForOperationInfos:operationInfos completed:^(BOOL result) {
        if (completed) {
            completed(result);
        }
    }];
}

#pragma mark - Delete

- (void)hsy_deleteDataToTableName:(NSString *)tableName
                      deleteValue:(NSString *)value
                       whereField:(NSString *)field
                        completed:(void(^)(BOOL result))completed
{
    [[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_deleteRowDataForTableName:tableName deleteValue:value whereField:field completed:^(BOOL result) {
        if (completed) {
            completed(result);
        }
    }];
}

#pragma mark - Clean

- (void)hsy_cleanTableName:(NSString *)tableName completed:(void(^)(BOOL result))completed
{
    [[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_clearDataToTableName:tableName completed:^(BOOL result) {
        if (completed) {
            completed(result);
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
    [[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_queryAllDataForOperationInfo:operation completed:^(NSMutableArray *result) {
        if (completed) {
            completed(result);
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
    [[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_queryDataForOperationInfo:operation whereField:whereField whereContent:whereContent completed:^(NSMutableArray *result) {
        if (completed) {
            completed(result);
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
    [[HSYFMDBOperationManager shareInstance].fmdbOperation hsy_fmdb_modifyDataForTableName:tableName updateField:updateField updateContent:updateContent whereField:whereField whereContent:whereContent completed:^(BOOL result) {
        if (completed) {
            completed(result);
        }
    }];
}

@end
