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
@property (copy, nonatomic) NSString *opMark;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSArray *category;
@property (copy, nonatomic) NSString *grabTime;
- (instancetype)initWithDataDict:(NSDictionary *)dict;
@end
