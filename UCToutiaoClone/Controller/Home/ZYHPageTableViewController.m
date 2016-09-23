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
#import "objc/message.h"

const char kHomeTableViewCellClass;

#define ARTICLE_MAP_SPECIALS @"specials"
#define ARTICLE_MAP_ARTICLES @"articles"

id (*objc_msgSendGetCellIdentifier)(id self, SEL _cmd) = (void *)objc_msgSend;

@interface UITableViewCell ()
- (void)updateCellWithModel:(ZYHArticleModel *)model;
@end


@interface ZYHPageTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *bgPlaceholderView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSArray *articlesIdList;
@property (strong, nonatomic) NSMutableDictionary *templateCellDict;
@property (assign, nonatomic) BOOL hadLoadData;
@property (assign, nonatomic) int page;
@end

@implementation ZYHPageTableViewController
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self setupTableView];
//    }
//    return self;
//}

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
    [NewsService queryNewsWithChannelId:channelId method:@"new" recoid:@"" completion:^(UCTNetworkResponseStatus status, NSDictionary *dataDict) {
        if (status == UCTNetworkResponseSucceed) {
            //数据先放model解析出来
            weakSelf.articlesIdList = [dataDict objectForKey:@"items"];
            NSDictionary *articlesDict = [dataDict objectForKey:@"articles"];
            NSDictionary *specialsDict = [dataDict objectForKey:@"specials"];
            [weakSelf packageArticlesDataWithArticlesIdList:weakSelf.articlesIdList articlesDict:articlesDict specialsDict:specialsDict];
            [weakSelf setHadLoadData:YES];
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
            NSDictionary *specialArticleDict = [specialsDict objectForKey:articleId];
            NSArray *specialArticleList =  [specialArticleDict objectForKey:@"articles"];
            ZYHArticleModel *specialModel = [self packageArticleModelWithArticleDict:specialArticleDict];
            [mutArray addObject:specialModel];
            for (NSDictionary *articleDict in specialArticleList) {
                [mutArray addObject:[self packageArticleModelWithArticleDict:articleDict]];
            }
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

- (NSString *)analysisCellClassNameWithModel:(ZYHArticleModel *)model {
    return objc_getAssociatedObject(model, &kHomeTableViewCellClass);
}

- (void)attachCellClassName:(NSString *)className dataDict:(NSDictionary *)dataDict {
    objc_setAssociatedObject(dataDict, &kHomeTableViewCellClass, className, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma - mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    @autoreleasepool {
        ZYHArticleModel *model = [_dataList objectAtIndex:indexPath.row];
        Class clazz = NSClassFromString([self analysisCellClassNameWithModel:model]);
        NSString *identifier = objc_msgSendGetCellIdentifier(clazz, NSSelectorFromString(@"cellReuseIdentifier"));
        UITableViewCell *cell = [self.templateCellDict objectForKey:identifier];
        if (nil == cell) {
            cell = [[clazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [self.templateCellDict setObject:cell forKey:identifier];
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([cell respondsToSelector:@selector(updateCellWithModel:)]) {
            [cell updateCellWithModel:model];
        }
#pragma clang diagnostic pop
        NSLayoutConstraint *calculateCellConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:[[UIScreen mainScreen] bounds].size.width];
        [cell.contentView addConstraint:calculateCellConstraint];
        CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        [cell.contentView removeConstraint:calculateCellConstraint];
        return cellSize.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYHArticleModel *model = [_dataList objectAtIndex:indexPath.row];
    Class clazz = NSClassFromString([self analysisCellClassNameWithModel:model]);
    NSString *identifier = objc_msgSendGetCellIdentifier(clazz, NSSelectorFromString(@"cellReuseIdentifier"));
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([cell respondsToSelector:@selector(updateCellWithModel:)]) {
//        [cell performSelector:@selector(updateCellWithModel:) withObject:model afterDelay:0.f];
//        [cell performSelector:@selector(updateCellWithModel:) withObject:model afterDelay:0.f];
        [cell updateCellWithModel:model];
    }
#pragma clang diagnostic pop
    return cell;
}

- (void)setChannelId:(NSString *)channelId {
    _channelId = channelId;
    if (!_hadLoadData) {//缓存
        [self loadNewData];
    }
    NSLog(@"load page");
}

@end
