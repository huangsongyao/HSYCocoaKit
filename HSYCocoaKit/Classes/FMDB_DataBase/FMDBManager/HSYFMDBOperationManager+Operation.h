//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYFMDBOperationManager.h"

@class HSYFMDBOperationFieldInfo;
@interface HSYFMDBOperationManager (Operation)

/**
 *  插入数据
 *
 *  @param tableName 表名
 *  @param params    表字段和表字段类型的集合,入参的格式为：[HSYFMDBOperationManager testTableByFields]
 *  @param datas     要插入的数据，集合内的字段和params中的表字段顺序是一一对应的,入参的格式为：[@[@"第一个字段的值",@"第二个字段的值",@"第三个字段的值",] mutableCopy]
 *  @param completed 操作完成后的回调
 */
- (void)hsy_insertDataToTableName:(NSString *)tableName
                      fieldParams:(NSMutableArray <NSDictionary *>*)params
                      insertDatas:(NSMutableArray <NSString *>*)datas
                        completed:(void(^)(BOOL result, HSYFMDBOperationFieldInfo *info))completed;

/**
 *  开启一个事务进行批量插入
 *
 *  @param operationInfos 表单映射的集合
 *  @param completed      操作完成后的回调
 */
- (void)hsy_beginTransactionInsertDataForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos completed:(void(^)(BOOL result))completed;

/**
 *  删除数据
 *
 *  @param tableName 表名
 *  @param value     要删除的数据的某个字段的值
 *  @param field     要删除的数据的某个字段
 *  @param completed 操作完成后的回调
 */
- (void)hsy_deleteDataToTableName:(NSString *)tableName
                      deleteValue:(NSString *)value
                       whereField:(NSString *)field
                        completed:(void(^)(BOOL result))completed;

/**
 *  清空表数据
 *
 *  @param tableName 表名
 *  @param completed 操作完成后的回调
 */
- (void)hsy_cleanTableName:(NSString *)tableName
                 completed:(void(^)(BOOL result))completed;

/**
 *  清空所有的表的数据
 *
 *  @param completed 操作完成后的回调
 */
- (void)hsy_cleanAllTableForCompleted:(void(^)(BOOL result, NSString *tableName))completed;

/**
 *  清空某几个表数据
 *
 *  @param tableNames 表名集合
 *  @param completed  操作完成后的回调
 */
- (void)hsy_cleanTableNames:(NSArray <NSString *>*)tableNames
                  completed:(void(^)(BOOL result, NSString *tableName))completed;


/**
 *  索引一张表中的所有数据
 *
 *  @param tableName 表名
 *  @param params    表字段和表字段类型的集合,[HSYFMDBOperationManager testTableByFields]
 *  @param completed 操作完成后的回调
 */
- (void)hsy_queryAllDataForTableName:(NSString *)tableName
                         fieldParams:(NSMutableArray <NSDictionary *>*)params
                       hsy_completed:(void(^)(NSMutableArray *result))completed;

/**
 *  索引一张表中满足条件的所有数据
 *
 *  @param tableName    表名
 *  @param params       表字段和表字段类型的集合,[HSYFMDBOperationManager testTableByFields]
 *  @param whereField   索引条件的字段
 *  @param whereContent 索引条件的字段的内容
 *  @param completed    操作完成后的回调
 */
- (void)hsy_queryDataForTableName:(NSString *)tableName
                      fieldParams:(NSMutableArray <NSDictionary *>*)params
                       whereField:(NSString *)whereField
                     whereContent:(NSString *)whereContent
                        completed:(void(^)(NSMutableArray *result))completed;

/**
 *  修改数据
 *
 *  @param tableName     表名
 *  @param updateField   要更新的字段的字段名
 *  @param updateContent 要更新的字段的更新内容
 *  @param whereField    索引条件的字段的字段名
 *  @param whereContent  索引条件的字段的内容
 *  @param completed     操作完成后的回调
 */
- (void)hsy_modifyDataForTableName:(NSString *)tableName
                       updateField:(NSString *)updateField
                     updateContent:(NSString *)updateContent
                        whereField:(NSString *)whereField
                      whereContent:(NSString *)whereContent
                         completed:(void(^)(BOOL result))completed;


@end
