//
//  HSYFMDBOperationManager+Operation.m
//  HSYFMDBDatabaseManager
//
//  Created by huangsongyao on 17/2/27.
//  Copyright © 2017年 huangsongyao. All rights reserved.
//

#import "HSYFMDBOperationManager+Operation.h"
#import "HSYFMDBOperationFieldInfo.h"
#import "HSYFMDBOperation.h"

@implementation HSYFMDBOperationManager (Operation)

#pragma mark - Insert

- (void)insertDataToTableName:(NSString *)tableName fieldParams:(NSMutableArray <NSDictionary *>*)params insertDatas:(NSMutableArray <NSString *>*)datas completed:(void(^)(BOOL result, HSYFMDBOperationFieldInfo *info))completed
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationManager createDatabaseOperationInfoForTableName:tableName fieldParams:params insertDatas:datas];
    [[HSYFMDBOperationManager shareInstance].fmdbOperation fmdb_insertDataForOperationInfo:operation completed:^(BOOL result, HSYFMDBOperationFieldInfo *info) {
        if (completed) {
            completed(result, info);
        }
    }];
}

- (void)beginTransactionInsertDataForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos completed:(void(^)(BOOL result))completed
{
    [[HSYFMDBOperationManager shareInstance].fmdbOperation fmdb_beginTransactionInsertDataForOperationInfos:operationInfos completed:^(BOOL result) {
        if (completed) {
            completed(result);
        }
    }];
}

#pragma mark - Delete

- (void)deleteDataToTableName:(NSString *)tableName deleteValue:(NSString *)value whereField:(NSString *)field completed:(void(^)(BOOL result))completed
{
    [[HSYFMDBOperationManager shareInstance].fmdbOperation fmdb_deleteRowDataForTableName:tableName deleteValue:value whereField:field completed:^(BOOL result) {
        if (completed) {
            completed(result);
        }
    }];
}

#pragma mark - Clean

- (void)cleanTableName:(NSString *)tableName completed:(void(^)(BOOL result))completed
{
    [[HSYFMDBOperationManager shareInstance].fmdbOperation fmdb_clearDataToTableName:tableName completed:^(BOOL result) {
        if (completed) {
            completed(result);
        }
    }];
}

- (void)cleanAllTableForCompleted:(void (^)(BOOL result, NSString *tableName))completed
{
    [self cleanTableNames:self.tableNames completed:^(BOOL result, NSString *tableName) {
                                if (completed) {
                                    completed(result, tableName);
                                }
                            }];
}

- (void)cleanTableNames:(NSArray <NSString *>*)tableNames completed:(void (^)(BOOL result, NSString *tableName))completed
{
    for (NSString *tableName in tableNames) {
        [self cleanTableName:tableName completed:^(BOOL result) {
            if (completed && !result) {
                //某个表单清空失败时才回调
                completed(result, [NSString stringWithFormat:@"%@ clean failure", tableName]);
            }
        }];
    }
}

#pragma mark - Query

- (void)queryAllDataForTableName:(NSString *)tableName fieldParams:(NSMutableArray <NSDictionary *>*)params completed:(void(^)(NSMutableArray *result))completed
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationManager createDatabaseOperationInfoForTableName:tableName fieldParams:params];
    [[HSYFMDBOperationManager shareInstance].fmdbOperation fmdb_queryAllDataForOperationInfo:operation completed:^(NSMutableArray *result) {
        if (completed) {
            completed(result);
        }
    }];
}

- (void)queryDataForTableName:(NSString *)tableName fieldParams:(NSMutableArray <NSDictionary *>*)params whereField:(NSString *)whereField whereContent:(NSString *)whereContent completed:(void(^)(NSMutableArray *result))completed
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationManager createDatabaseOperationInfoForTableName:tableName fieldParams:params];
    [[HSYFMDBOperationManager shareInstance].fmdbOperation fmdb_queryDataForOperationInfo:operation whereField:whereField whereContent:whereContent completed:^(NSMutableArray *result) {
        if (completed) {
            completed(result);
        }
    }];
}

#pragma mark - Modify

- (void)modifyDataForTableName:(NSString *)tableName updateField:(NSString *)updateField updateContent:(NSString *)updateContent whereField:(NSString *)whereField whereContent:(NSString *)whereContent completed:(void(^)(BOOL result))completed
{
    [[HSYFMDBOperationManager shareInstance].fmdbOperation fmdb_modifyDataForTableName:tableName updateField:updateField updateContent:updateContent whereField:whereField whereContent:whereContent completed:^(BOOL result) {
        if (completed) {
            completed(result);
        }
    }];
}

@end
