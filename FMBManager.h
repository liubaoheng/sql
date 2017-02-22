//
//  FMBManager.h
//  sql
//
//  Created by sibo on 2017/2/22.
//  Copyright © 2017年 sibozn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface FMBManager : NSObject
@property (nonatomic,strong)FMDatabase *db;
+ (instancetype)FMDBMaagerShareinstace;
//增加数据
- (void)addSql:(NSInteger)num;
//删除数据
- (void)deleteSql:(NSInteger)num;
//修改数据
- (void)updateSql:(NSInteger)num;
//查询数据
- (void)selectSql:(NSInteger)num;
@end
