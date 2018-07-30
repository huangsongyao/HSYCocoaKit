//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class HSYFMDBOperationFieldInfo;
@class RACSignal;
@interface HSYFMDBOperation : NSObject

@property (nonatomic, strong, readonly) FMDatabase *dateBase;               //FMDB数据库，只读
@property (nonatomic, copy, readonly) NSString *dateBasePath;               //数据库所在的路径，只读
@property (nonatomic, strong, readonly) FMDatabaseQueue *databaseQueue;     //FMDB读取穿行操作队列，保证多线程访问时不会出现数据竞争

#pragma mark - Un Queue

/**
 *  初始化方法
 *
 *  @param tables 当前需要创建的表的抽象类集合
 *  @param name   数据库名称
 *
 *  @return self
 */
- (instancetype)initWithDatabaseTables:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)tables
                          databaseName:(NSString *)name;

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
- (void)hsy_fmdb_beginTransactionInsertDataForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos completed:(void(^)(BOOL result))completed;

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

#pragma mark - Queue

/**
 “队列操作格式”的单次数据插入

 @param operationInfo 数据库操作抽象类
 @return RACSignal
 */
- (RACSignal *)hsy_fmdb_insertDataQueueForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo;

/**
 “队列操作格式”的事务多次数据插入

 @param operationInfos 数据库操作抽象类
 @return RACSignal
 */
- (RACSignal *)hsy_fmdb_beginTransactionInsertDataQueueForOperationInfos:(NSMutableArray <HSYFMDBOperationFieldInfo *>*)operationInfos;

/**
 “队列操作格式”的查询表单中的所有数据

 @param operationInfo 数据库操作抽象类
 @return RACSignal
 */
- (RACSignal *)hsy_fmdb_queryAllDataQueueForOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo;

/**
 “队列操作格式”的查询满足 field = content 条件的数据

 @param operationInfo 数据库操作抽象类
 @param field 索引条件的表字段
 @param content 索引条件的表字段的内容
 @return RACSignal
 */
- (RACSignal *)hsy_fmdb_queryDataForQueueOperationInfo:(HSYFMDBOperationFieldInfo *)operationInfo
                                            whereField:(NSString *)field
                                          whereContent:(NSString *)content;

/**
 “队列操作格式”的删除满足 field = value 条件的数据

 @param tableName 数据库表单名称
 @param value 删除条件的字段内容
 @param field 删除条件的字段名
 @return RACSignal
 */
- (RACSignal *)hsy_fmdb_deleteRowDataQueueForTableName:(NSString *)tableName
                                           deleteValue:(NSString *)value
                                            whereField:(NSString *)field;

/**
 “队列操作格式”的修改满足 whereField = whereContent 条件下的表的内容，更新的内容为 updateField更新为updateContent

 @param tableName 数据表名
 @param updateField 要更新数据的表字段
 @param updateContent 要更新数据的表字段的更新内容
 @param whereField 修改条件的字段名
 @param whereContent 修改条件的字段名的内容
 @return RACSignal
 */
- (RACSignal *)hsy_fmdb_modifyDataQueueForTableName:(NSString *)tableName
                                        updateField:(NSString *)updateField
                                      updateContent:(NSString *)updateContent
                                         whereField:(NSString *)whereField
                                       whereContent:(NSString *)whereContent;

/**
 “队列操作格式”的删除表中所有数据

 @param tableName 表名称
 @return RACSignal
 */
- (RACSignal *)hsy_fmdb_clearDataQueueToTableName:(NSString *)tableName;

@end
