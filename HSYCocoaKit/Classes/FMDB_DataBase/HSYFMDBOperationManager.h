//
//  HSYFMDBOperationManager.h
//  HSYFMDBDatabaseManager
//
//  Created by huangsongyao on 17/2/27.
//  Copyright © 2017年 huangsongyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSYFMDBOperation.h"

@class HSYFMDBOperationFieldInfo;
@interface HSYFMDBOperationManager : NSObject

@property (nonatomic, strong, readonly) HSYFMDBOperation *fmdbOperation;                //数据库操作相关封装类
@property (nonatomic, strong, readonly) NSArray *tableNames;                            //缓存所有当前已经创建的表的表名

+ (instancetype)shareInstance;

/**
 子类重载本方法，模仿
 */
- (void)createDatabase;

/**
 *  创建一个数据库表单的字段抽象类集合
 *
 *  @param fieldParams 表单的字段名和类型的对象集合，例如：NSMutableArray *params = [@[@{@"field1" : FIELE_TYPE,},@{@"field2" : FIELE_TYPE,},@{@"field3" : FIELE_TYPE,},] mutableCopy];
 *
 *  @return NSMutableArray
 */
+ (NSMutableArray *)createDatabaseOpeartionFieldInfoForFieldParams:(NSMutableArray <NSDictionary *>*)fieldParams;

/**
 *  创建一个数据库表单操作抽象类
 *
 *  @param tableName 表名
 *  @param params    表单的字段名和类型的对象集合，例如：NSMutableArray *params = [@[@{@"field1" : FIELE_TYPE,},@{@"field2" : FIELE_TYPE,},@{@"field3" : FIELE_TYPE,},] mutableCopy];
 *
 *  @return HSYFMDBOperationInfo
 */
+ (HSYFMDBOperationFieldInfo *)createDatabaseOperationInfoForTableName:(NSString *)tableName fieldParams:(NSMutableArray <NSDictionary *>*)params;

/**
 *  创建一个数据库表单操作抽象类，用于插入数据
 *
 *  @param tableName 表名称
 *  @param params    表单的字段名和类型的对象集合，例如：NSMutableArray *params = [@[@{@"field1" : FIELE_TYPE,},@{@"field2" : FIELE_TYPE,},@{@"field3" : FIELE_TYPE,},] mutableCopy];
 *  @param datas     要插入的数据，格式为：NSMutableArray *datas = [@[@"第一个字段的第二次值",@"第二个字段的第二次值",@"第三个字段的第二次值",] mutableCopy];
 *
 *  @return HSYFMDBOperationInfo
 */
+ (HSYFMDBOperationFieldInfo *)createDatabaseOperationInfoForTableName:(NSString *)tableName fieldParams:(NSMutableArray <NSDictionary *>*)params insertDatas:(NSMutableArray <NSString *>*)datas;

@end

@interface HSYFMDBOperationManager (Fields)

/**
 * ***表字段格式，如果需要需要添加时，可自行添加方法，格式请务必模范"- testTableByFields"******
 *
 * 测试用的数据表
 *  @return 表字段格式集合
 */
+ (NSMutableArray <NSDictionary *>*)testTableByFields;


@end
