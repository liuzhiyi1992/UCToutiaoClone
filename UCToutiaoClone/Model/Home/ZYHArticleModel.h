//
//  ZYHArticleModel.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/18.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHArticleModel : NSObject
@property (copy, nonatomic) NSString *articleId;
@property (copy, nonatomic) NSString *recoid;
@property (copy, nonatomic) NSString *articleTitle;
@property (copy, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSArray *thumbnails;
@property (strong, nonatomic) NSArray *images;

@property (copy, nonatomic) NSString *opMark;           //hot则有"hot"标志
@property (copy, nonatomic) NSString *opMarkIconUrl;

@property (copy, nonatomic) NSString *sourceName;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSArray *category;
@property (copy, nonatomic) NSString *grabTime;
@property (copy, nonatomic) NSString *publicTimeString;//publish_time
- (instancetype)initWithDataDict:(NSDictionary *)dict;
@end
