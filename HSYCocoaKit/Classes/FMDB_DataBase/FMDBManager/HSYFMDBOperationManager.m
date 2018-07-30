//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYFMDBOperationManager.h"
#import "HSYFMDBOperationFieldInfo.h"
#import "HSYFMDBOperation.h"

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

- (void)createDatabase:(NSString *)dbName
       tableFieldInfos:(NSMutableArray<HSYFMDBOperationFieldInfo *> *)tableFieldInfos
{
    //预缓存好所有的数据库表名
    _tableNames = [NSMutableArray arrayWithCapacity:tableFieldInfos.count];
    for (HSYFMDBOperationFieldInfo *info in tableFieldInfos) {
        [self.tableNames addObject:info.hsy_name];
    }
    //添加到数据库中
    _fmdbOperation = [[HSYFMDBOperation alloc] initWithDatabaseTables:tableFieldInfos
                                                         databaseName:dbName];
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

