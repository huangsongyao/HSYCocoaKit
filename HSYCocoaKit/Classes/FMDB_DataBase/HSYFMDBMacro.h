//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#ifndef HSYFMDBMacro_h
#define HSYFMDBMacro_h

#import "FMResultSet+Model.h"
#import "HSYFMDBOperation.h"
#import "HSYFMDBOperationFieldInfo.h"
#import "HSYFMDBOperationManager+Operation.h"
#import "HSYFMDBOperationManager.h"

//映射数据库使用说明
/*
 1、创建数据库
    <1.首先必须为HSYFMDBOperationManager类创建一个公有范畴（Category），用于提供映射所需要的表字段格式如下：
        @interface HSYFMDBOperationManager (Fields)
        + (NSMutableArray <NSDictionary *>*)hsy_testTableByFields;
        @end
 
        @implementation HSYFMDBOperationManager (Fields)
        //格式规则：[@[@{@"字段名称1" : FIELE_TYPE}, @{@"字段名称1" : FIELE_TYPE}, ...] mutableCopy]; 其中FIELE_TYPE为宏定义的@"TEXT"
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
    <2.使用范畴总的表字段映射
        //    //这是一个测试的数据表
        //    //如果需要添加其他表，只需要按照这个格式进行添加，并且在HSYFMDBOperationManager(Fields)中添加静态方法标识数据格式，格式请模仿+ (NSMutableArray <NSDictionary *>*)testTableByFields
        //    NSMutableArray *fields = [[self.class hsy_createDatabaseOpeartionFieldInfoForFieldParams:[self.class hsy_testTableByFields]] mutableCopy];
        //    HSYFMDBOperationFieldInfo *testTable = [HSYFMDBOperationFieldInfo hsy_createDataBaseTableForName:FMDB_DATABASE_TEST_LIST_NAME fields:fields];
        //  NSMutableArray *infos = [@[
                                        testTable
                                    ] mutableCopy];
        //    调用创建数据库的api方法
        //    [[HSYFMDBOperationManager shareInstance] createDatabase:@"数据库的名称" tableFieldInfos:infos];
 2、数据基本操作
        请使用“HSYFMDBOperationManager+Operation.h”头文件中的操作方式
 */

#endif /* HSYFMDBMacro_h */
