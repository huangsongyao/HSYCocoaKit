//
//  HSYFMDBOperation.h
//  HSYFMDBDatabaseManager
//
//  Created by huangsongyao on 17/2/27.
//  Copyright © 2017年 huangsongyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class HSYFMDBOperationFieldInfo;
@interface HSYFMDBOperation : NSObject

@property (nonatomic, strong, readonly) FMDatabase *dateBase;               //FMDB数据库，只读
@property (nonatomic, copy, readonly) NSString *dateBasePath;               //数据库所在的路径，只读

/**
 *  初始化方法
 *
 *  @param tables 当前需要创建的表的抽象类集合
 *
 *  @return self
 */
- (instancetype)initWithDatabaseTables:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)tables;

/**
 *  单次插入数据
 *
 *  @param operationInfo 数据库操作抽象类
 *  @param completed     插入完成后的回调
 */
- (void)hsy_fmdb_insertDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                  completed:(void(^)(BOOL result, HSYFMDBOperationFieldInfo *info))completed;

/**
 *  启动一次事务进行一次或者多次的插入数据操作
 *
 *  @param operationInfos 数据库操作抽象类
 *  @param completed      插入完成后的回调
 */
- (void)hsy_fmdb_beginTransactionInsertDataForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos
                                                   completed:(void(^)(BOOL result))completed;

/**
 *  索引数据库表，索引结果为某个表单里所有的数据集合
 *
 *  @param operationInfo 数据库操作抽象类
 *  @param completed     索引完成后获取到结果的的回调
 */
- (void)hsy_fmdb_queryAllDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                    completed:(void(^)(NSMutableArray *result))completed;

/**
 *  索引数据库表，索引结果为满足 field = content 条件下的数据集合
 *
 *  @param operationInfo 数据库操作抽象类
 *  @param field         索引条件的表字段
 *  @param content       索引条件的表字段的内容
 *  @param completed     索引完成后获取到结果的的回调
 */
- (void)hsy_fmdb_queryDataForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                whereField:(NSString *)field
                              whereContent:(NSString *)content
                                 completed:(void(^)(NSMutableArray *result))completed;

/**
 *  删除单条或者多条满足 field = value 条件的数据表内容
 *
 *  @param tableName 数据表名
 *  @param value     删除条件的字段内容
 *  @param field     删除条件的字段名
 *  @param completed 删除完毕后的回调
 */
- (void)hsy_fmdb_deleteRowDataForTableName:(NSString *)tableName
                               deleteValue:(NSString *)value
                                whereField:(NSString *)field
                                 completed:(void(^)(BOOL result))completed;

/**
 *  修改满足 whereField = whereContent 条件下的表的内容，更新的内容为 updateField更新为updateContent
 *
 *  @param tableName     数据表名
 *  @param updateField   要更新数据的表字段
 *  @param updateContent 要更新数据的表字段的更新内容
 *  @param whereField    修改条件的字段名
 *  @param whereContent  修改条件的字段名的内容
 *  @param completed     修改介绍后的回调
 */
- (void)hsy_fmdb_modifyDataForTableName:(NSString *)tableName
                            updateField:(NSString *)updateField
                          updateContent:(NSString *)updateContent
                             whereField:(NSString *)whereField
                           whereContent:(NSString *)whereContent
                              completed:(void(^)(BOOL result))completed;

/**
 *  删除表中所有数据
 *
 *  @param tableName 表名称
 *  @param completed 删除结束后的回调
 */
- (void)hsy_fmdb_clearDataToTableName:(NSString *)tableName
                            completed:(void(^)(BOOL result))completed;


@end
