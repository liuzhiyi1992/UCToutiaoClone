//
//  ZYHArticleModel.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/18.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ZYHArticleModel.h"
#import "ZYHPageTableViewController.h"
#import "objc/runtime.h"

@implementation ZYHArticleModel
- (instancetype)initWithDataDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self packageModelWithDict:dict];
    }
    return self;
}

- (void)packageModelWithDict:(NSDictionary *)dict {
    self.articleId = dict[@"id"];
    self.articleTitle = dict[@"title"];
    self.recoid = dict[@"recoid"];
    self.urlString = dict[@"url"];
    self.thumbnails = dict[@"thumbnails"];
    self.images = dict[@"images"];
    self.opMark = dict[@"op_mark"];
    self.category = dict[@"category"];
    self.grabTime = [dict[@"grab_time"] stringValue];
    self.tags = dict[@"tags"];
    //todo site_logo(字典)
    //todo 决定cell class
}

- (void)attachCellClassName:(NSString *)className dataDict:(NSDictionary *)dataDict {
    objc_setAssociatedObject(dataDict, &kHomeTableViewCellClass, className, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
