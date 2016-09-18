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
#import "NewsService.h"
#import "ZYHArticleModel.h"
#import "objc/runtime.h"

const char kHomeTableViewCellClass;

#define ARTICLE_MAP_SPECIALS @"specials"
#define ARTICLE_MAP_ARTICLES @"articles"

@interface ZYHPageTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *bgPlaceholderView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSArray *articlesIdList;
@property (assign, nonatomic) BOOL hadLoadData;
@property (assign, nonatomic) int page;
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

- (void)loadNewData {
    [self queryDataWithChannelId:_channelId];
}

- (void)loadMoreData {
    
}

- (void)freshData {
    NSLog(@"fresh Data");
}

- (void)queryDataWithChannelId:(NSString *)channelId {
    __weak __typeof(&*self)weakSelf = self;
    [NewsService queryNewsWithChannelId:channelId completion:^(UCTNetworkResponseStatus status, NSDictionary *dataDict) {
        if (status == UCTNetworkResponseSucceed) {
            //数据先放model解析出来
            weakSelf.articlesIdList = [dataDict objectForKey:@"items"];
            NSDictionary *articlesDict = [dataDict objectForKey:@"articles"];
            NSDictionary *specialsDict = [dataDict objectForKey:@"specials"];
            [weakSelf packageArticlesDataWithArticlesIdList:weakSelf.articlesIdList articlesDict:articlesDict specialsDict:specialsDict];
            [weakSelf.tableView reloadData];
        } else {
            NSLog(@"");
        }
    }];
}

- (void)packageArticlesDataWithArticlesIdList:(NSArray *)articlesIdList
                                 articlesDict:(NSDictionary *)articlesDict
                                 specialsDict:(NSDictionary *)specialsDict {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *articlesIdDict in articlesIdList) {
        NSString *articleMapString = [articlesIdDict objectForKey:@"map"];
        NSString *articleId = [articlesIdDict objectForKey:@"id"];
        if ([ARTICLE_MAP_ARTICLES isEqualToString:articleMapString]) {
            ZYHArticleModel *model = [self packageArticleModelWithArticleDict:[articlesDict objectForKey:articleId]];
            [mutArray addObject:model];
        } else if ([ARTICLE_MAP_SPECIALS isEqualToString:articleMapString]) {
            ZYHArticleModel *model = [self packageArticleModelWithArticleDict:[specialsDict objectForKey:articleId]];
            [mutArray addObject:model];
        } else {
            continue;
        }
    }
    self.dataList = [mutArray copy];
}

- (ZYHArticleModel *)packageArticleModelWithArticleDict:(NSDictionary *)articleDict {
    ZYHArticleModel *model = [[ZYHArticleModel alloc] initWithDataDict:articleDict];
    return model;
}

- (NSString *)analysisCellClassNameWithDataDict:(NSDictionary *)dataDict {
    return objc_getAssociatedObject(dataDict, &kHomeTableViewCellClass);
}

- (void)attachCellClassName:(NSString *)className dataDict:(NSDictionary *)dataDict {
    objc_setAssociatedObject(dataDict, &kHomeTableViewCellClass, className, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma - mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *dataDict = [_dataList objectAtIndex:indexPath.row];
    Class clazz = NSClassFromString([self analysisCellClassNameWithDataDict:dataDict]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
//    if (nil == cell) {
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([cell respondsToSelector:@selector(updateCellWithDataDict:)]) {
        [cell performSelector:@selector(updateCellWithDataDict:) withObject:dataDict afterDelay:0.f];
    }
#pragma clang diagnostic pop
    return cell;
    
    
    
    return nil;
}

- (void)setChannelId:(NSString *)channelId {
    _channelId = channelId;
    if (!_hadLoadData) {//缓存
        [self loadNewData];
    }
    NSLog(@"load page");
}

@end
