//
//  FMResultSet+Model.h
//  HSYFMDBDatabaseManager
//
//  Created by huangsongyao on 17/2/27.
//  Copyright © 2017年 huangsongyao. All rights reserved.
//

#import <FMDB/FMDB.h>

@class HSYFMDBOperationFieldInfo;
@interface FMResultSet (Model)

/**
 *  通过表单所映射的抽象类获取数据
 *
 *  @param operation 抽象类
 *
 *  @return 查询的数据集合
 */
- (NSMutableDictionary *)fmdbForColumn:(HSYFMDBOperationFieldInfo *)operation;

@end
