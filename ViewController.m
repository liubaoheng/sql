//
//  ViewController.m
//  sql
//
//  Created by sibo on 2017/2/20.
//  Copyright © 2017年 sibozn. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "FMBManager.h"
@interface ViewController ()
@property (nonatomic,strong)FMDatabase *db;
@property (nonatomic,strong)FMBManager *fm;
@property (nonatomic,strong)UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createButton];
    NSLog(@"viewLoad");
}
- (void)createButton {
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    self.textField.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textField];
    
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(10+i*60, 200, 50, 30);
        button.backgroundColor = [UIColor redColor];
        if (i == 0) {
            [button setTitle:@"增加" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnInsert) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (i==1) {
            [button setTitle:@"删除" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnDelete) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 2) {
            [button setTitle:@"修改" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnUpdate) forControlEvents:UIControlEventTouchUpInside];
        }else {
            [button setTitle:@"查询" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.view addSubview:button];
    }
}
- (void)btnInsert {
    NSLog(@"增加");
    NSInteger num = [self.textField.text integerValue];
    self.fm = [FMBManager FMDBMaagerShareinstace];
    [self.fm addSql:num];
}
- (void)btnDelete {
    NSLog(@"删除");
    NSInteger num = [self.textField.text integerValue];
    self.fm = [FMBManager FMDBMaagerShareinstace];
    [self.fm deleteSql:num];
}
- (void)btnUpdate {
    NSLog(@"修改");
    NSInteger num = [self.textField.text integerValue];
    self.fm = [FMBManager FMDBMaagerShareinstace];
    [self.fm updateSql:num];
}
- (void)btnSelect {
    NSLog(@"查询");
    NSInteger num = [self.textField.text integerValue];
    self.fm = [FMBManager FMDBMaagerShareinstace];
    [self.fm selectSql:num];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
