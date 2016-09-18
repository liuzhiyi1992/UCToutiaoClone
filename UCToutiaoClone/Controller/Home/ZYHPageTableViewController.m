//
//  ZYHomePageTableViewController.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ZYHPageTableViewController.h"
#import "Masonry.h"
#import "UIColor+hexColor.h"

@interface ZYHPageTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *bgPlaceholderView;
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation ZYHPageTableViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTableView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] init];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setBackgroundColor:[UIColor hexColor:@"f9f9f9"]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIImage *bgPlaceholderImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"channelPagePlaceholder.png"]];
    self.bgPlaceholderView = [[UIImageView alloc] initWithImage:bgPlaceholderImage];
    [self.tableView addSubview:_bgPlaceholderView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)freshData {
    NSLog(@"fresh Data");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)setChannelId:(NSString *)channelId {
    NSLog(@"load page");
}

@end
