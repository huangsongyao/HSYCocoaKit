//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <Foundation/Foundation.h>

#define FIELE_TYPE                      @"TEXT"

@class HSYFMDBOperationFieldInfo;
@interface HSYFMDBOperationFields : NSObject

@property (nonatomic, strong) NSString *hsy_fieldName;                                  //字段名
@property (nonatomic, strong) NSString *hsy_fieldType;                                  //字段类型

- (instancetype)initWithFieldName:(NSString *)name
                        fieldType:(NSString *)type;

/**
 数据行集合快速创建方法

 @param fieldsInfos 格式为：@[@[@{@"字段名1" : @"字段名1对应的类型"}, @{@"字段名2" : @"字段名2对应的类型"}, ...] copy]
 @return NSMutableArray<HSYFMDBOperationFields *> *
 */
+ (NSMutableArray<HSYFMDBOperationFields *> *)hsy_toOperationFields:(NSMutableArray *)fieldsInfos;

@end

@interface HSYFMDBOperationFieldInfo : NSObject

@property (nonatomic, strong) NSString *hsy_name;                                       //数据库表名
@property (nonatomic, strong) NSMutableArray <HSYFMDBOperationFields *>*hsy_fields;     //数据库要添加到表中的字段名称和字段名称对应的类型 的抽象类集合
@property (nonatomic, strong) NSMutableArray <NSString *>*hsy_statements;               //数据库要插入的数据

- (NSString *)hsy_toDataBaseTableField;                                                 //通过对fields集合进行处理，获取到一个创建表的字符串
- (NSString *)hsy_toDataBaseTableInsertStatements;                                      //通过对fields集合进行处理，获取到一个用于插入数据的字符串
- (NSString *)hsy_toDataBaseTableInsertFields;

- (NSDictionary *)hsy_toDictionaryFields;                                               //通过对fields集合的处理，获取到键值对类型，格式为：@{@"表单字段A" : @"表单字段A的值a", @"表单字段B" : @"表单字段B的值b", ...}

@end

@interface HSYFMDBOperationFieldInfo (Show)

/**
 *  快捷创建，用于创建数据库表
 *
 *  @param name   表名称
 *  @param fields 表字段的抽象类集合
 *
 *  @return HSYFMDBOperationInfo
 */
+ (HSYFMDBOperationFieldInfo *)hsy_createDataBaseTableForName:(NSString *)name fields:(NSMutableArray <HSYFMDBOperationFields *>*)fields;

/**
 *  快捷创建，用于插入数据
 *
 *  @param name       表名称
 *  @param fields   表字段的抽象类集合
 *  @param statements 要插入到name表的数据集合，例如，表name有：a、b、c三个字段，入参格式为：@[@"字段a的数据", @"字段b的数据", @"字段c的数据"];
 *
 *  @return HSYFMDBOperationInfo
 */
+ (HSYFMDBOperationFieldInfo *)hsy_createDataBaseTableForName:(NSString *)name fields:(NSMutableArray <HSYFMDBOperationFields *>*)fields insertDatas:(NSMutableArray <NSString *>*)statements;


@end

