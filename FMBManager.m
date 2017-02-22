//
//  FMBManager.m
//  sql
//
//  Created by sibo on 2017/2/22.
//  Copyright © 2017年 sibozn. All rights reserved.
//

#import "FMBManager.h"
static FMBManager *_install = nil;
@implementation FMBManager
- (id)init {
    self = [super init];
    if (self) {
        NSLog(@"init2");
        [self createSqlPath];
    }
    return self;
}
+ (instancetype)FMDBMaagerShareinstace {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _install = [[FMBManager alloc]init];
    });
    return _install;
}
//获取document路径创建数据库
- (void)createSqlPath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"TEST.sqlite"];
    NSLog(@"数据库地址2%@",fileName);
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    self.db = db;
    BOOL success = [db open];
    if (success) {
        NSLog(@"数据库创建成功");
        NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS t_test (ID INTERGER PRIMARY KEY AUTOINCREMENT,NAME TEXT,AGE INTERGER)";
        BOOL sucessT = [self.db executeUpdate:sqlStr];
        if (sucessT) {
            NSLog(@"t_test表创建成功");
        }else {
            NSLog(@"t_test表创建失败");
        }
    }else {
        NSLog(@"数据库创建失败");
    }
}
//增加数据
- (void)addSql:(NSInteger)num {
    for (NSInteger i = 0; i < num; i++) {
        NSString *name = [NSString stringWithFormat:@"J_mailboxx-%ld",i];
        //随机产生20~25的年龄
        NSInteger age = arc4random_uniform(5)+20;
        //Sql插入拼接语句
         NSString *resultStr = [NSString stringWithFormat:@"INSERT INTO t_test (NAME,AGE) VALUES('%@',%zd) ",name,age];
        //执行sql插入语句（调用FMDB对象方法）
        BOOL success = [self.db executeUpdate:resultStr];
        //判断成功与否
        if (success) {
            NSLog(@"添加成功");
        }else {
            NSLog(@"添加失败");
        }
        
    }
}
//删除数据
- (void)deleteSql:(NSInteger)num {
    //删除语句
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM t_test WHERE AGE = '%ld';",num];
    //执行sql删除语句
    BOOL sucess = [self.db executeUpdate:sqlStr];
    if (sucess) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
}
//修改数据
- (void)updateSql:(NSInteger)num {
    //修改语句
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE t_test SET AGE = 30 WHERE AGE < '%ld';",num]
    ;
    //执行语句
    BOOL success = [self.db executeUpdate:sqlStr];
    if (success) {
        NSLog(@"修改数据成功");
    }else {
        NSLog(@"修改数据失败");
    }

}
//查询数据
- (void)selectSql:(NSInteger)num {
    //查询语句
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT NAME,AGE FROM t_test WHERE AGE = '%ld';",num];
    //执行sql语句
    FMResultSet *set = [self.db executeQuery:sqlStr];
    while ([set next]) {
        NSString *name = [set stringForColumnIndex:0];
        NSInteger age = [set intForColumnIndex:1];
        NSLog(@"name= %@ age = %ld",name,age);
    }
}
@end
