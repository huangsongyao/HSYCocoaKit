//
//  HSYFMDBOperationManager.m
//  HSYFMDBDatabaseManager
//
//  Created by huangsongyao on 17/2/27.
//  Copyright © 2017年 huangsongyao. All rights reserved.
//

#import "HSYFMDBOperationManager.h"
#import "HSYFMDBOperationFieldInfo.h"
#import "HSYFMDBOperation.h"
#import "HSYFMDBMacro.h"

static HSYFMDBOperationManager *fmdbOperationManager = nil;

@interface HSYFMDBOperationManager ()

@end

@implementation HSYFMDBOperationManager

+ (instancetype)shareInstance
{    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmdbOperationManager = [[HSYFMDBOperationManager alloc] init];
    });
    return fmdbOperationManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self createDatabase];
    }
    return self;
}

- (void)createDatabase
{
    //这是一个测试的数据表
    //如果需要添加其他表，只需要按照这个格式进行添加，并且在HSYFMDBOperationManager(Fields)中添加静态方法标识数据格式，格式请模仿+ (NSMutableArray <NSDictionary *>*)testTableByFields
    NSMutableArray *fields = [[self.class hsy_createDatabaseOpeartionFieldInfoForFieldParams:[self.class hsy_testTableByFields]] mutableCopy];
    HSYFMDBOperationFieldInfo *testTable = [HSYFMDBOperationFieldInfo hsy_createDataBaseTableForName:FMDB_DATABASE_TEST_LIST_NAME fields:fields];
    
    //把表名添加到缓存数组中
    _tableNames = @[
                    FMDB_DATABASE_TEST_LIST_NAME,
                    ];
    //添加到数据库中
    _fmdbOperation = [[HSYFMDBOperation alloc] initWithDatabaseTables:[@[
                                                                         testTable,
                                                                         ] mutableCopy]];
}

+ (NSMutableArray <HSYFMDBOperationFieldInfo *>*)hsy_databaseTables
{
    //这是一个测试的数据表
    //如果需要添加其他表，只需要按照这个格式进行添加，并且在HSYFMDBOperationManager(Fields)中添加静态方法标识数据格式，格式请模仿+ (NSMutableArray <NSDictionary *>*)testTableByFields
    NSMutableArray *fields = [[self.class hsy_createDatabaseOpeartionFieldInfoForFieldParams:[self.class hsy_testTableByFields]] mutableCopy];
    HSYFMDBOperationFieldInfo *testTable = [HSYFMDBOperationFieldInfo hsy_createDataBaseTableForName:FMDB_DATABASE_TEST_LIST_NAME fields:fields];
    
    return [@[testTable] mutableCopy];
}

/**
 *  创建一个数据库表单的字段抽象类集合
 *
 *  @param fieldParams 表单的字段名和类型的对象集合，例如：NSMutableArray *params = [@[@{@"field1" : FIELE_TYPE,},@{@"field2" : FIELE_TYPE,},@{@"field3" : FIELE_TYPE,},] mutableCopy];
 *
 *  @return NSMutableArray
 */
+ (NSMutableArray *)hsy_createDatabaseOpeartionFieldInfoForFieldParams:(NSMutableArray <NSDictionary *>*)fieldParams
{
    NSMutableArray *infos = [[NSMutableArray alloc] init];
    for (NSDictionary *param in fieldParams) {
        NSString *fieldName = param.allKeys.firstObject;
        NSString *fieldType = param.allValues.firstObject;
        HSYFMDBOperationFields *fields = [[HSYFMDBOperationFields alloc] initWithFieldName:fieldName fieldType:fieldType];
        [infos addObject:fields];
    }
    return infos;
}

/**
 *  创建一个数据库表单操作抽象类
 *
 *  @param tableName 表名
 *  @param params    表单的字段名和类型的对象集合，例如：NSMutableArray *params = [@[@{@"field1" : FIELE_TYPE,},@{@"field2" : FIELE_TYPE,},@{@"field3" : FIELE_TYPE,},] mutableCopy];
 *
 *  @return HSYFMDBOperationInfo
 */
+ (HSYFMDBOperationFieldInfo *)hsy_createDatabaseOperationInfoForTableName:(NSString *)tableName fieldParams:(NSMutableArray <NSDictionary *>*)params
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationFieldInfo hsy_createDataBaseTableForName:tableName fields:[[self.class hsy_createDatabaseOpeartionFieldInfoForFieldParams:params] mutableCopy]];
    
    return operation;
    
}
/**
 *  创建一个数据库表单操作抽象类，用于插入数据
 *
 *  @param tableName 表名称
 *  @param params    表单的字段名和类型的对象集合，例如：NSMutableArray *params = [@[@{@"field1" : FIELE_TYPE,},@{@"field2" : FIELE_TYPE,},@{@"field3" : FIELE_TYPE,},] mutableCopy];
 *  @param datas     要插入的数据，格式为：NSMutableArray *datas = [@[@"第一个字段的第二次值",@"第二个字段的第二次值",@"第三个字段的第二次值",] mutableCopy];
 *
 *  @return HSYFMDBOperationInfo
 */
+ (HSYFMDBOperationFieldInfo *)hsy_createDatabaseOperationInfoForTableName:(NSString *)tableName fieldParams:(NSMutableArray <NSDictionary *>*)params insertDatas:(NSMutableArray <NSString *>*)datas
{
    HSYFMDBOperationFieldInfo *operation = [HSYFMDBOperationFieldInfo hsy_createDataBaseTableForName:tableName fields:[[self.class hsy_createDatabaseOpeartionFieldInfoForFieldParams:params] mutableCopy] insertDatas:datas];
    return operation;
}


@end

@implementation HSYFMDBOperationManager (Fields)

+ (NSMutableArray<NSDictionary *> *)hsy_testTableByFields
{
    NSMutableArray *params = [@[
                                @{
                                    USERID      : FIELE_TYPE,
                                    },
                                @{
                                    DETAILID    : FIELE_TYPE,
                                    },
                                ] mutableCopy];
    return params;
}

@end
