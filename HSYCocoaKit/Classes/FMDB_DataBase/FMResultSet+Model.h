//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
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
- (NSMutableDictionary *)hsy_fmdbForColumn:(HSYFMDBOperationFieldInfo *)operation;

@end
