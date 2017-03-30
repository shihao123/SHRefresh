//
//  ViewController.m
//  SHRefreshDemo
//
//  Created by zhugang on 17/1/12.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+SHRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UITableView*testTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"SHRefreshDemo";
    [self.view addSubview:self.testTableView];
    [self.testTableView addRefreshWithTarget:self action:@selector(doSomething)];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)doSomething
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.testTableView endRefresh];
        
    });
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*identifier = @"identifier";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.text= [NSString stringWithFormat:@"test%ld",indexPath.row];
    return cell;
}

- (UITableView*)testTableView
{
    if (_testTableView == nil) {
        _testTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
        _testTableView.delegate = self;
        _testTableView.dataSource = self;
    }
    return _testTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
