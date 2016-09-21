//
//  ZYHArticleDateFormatter.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/21.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ZYHArticleDateFormatter.h"

static NSDateFormatter *_zyhArticleDateFormatter;
@implementation ZYHArticleDateFormatter
+ (NSDateFormatter *)shareFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _zyhArticleDateFormatter = [[NSDateFormatter alloc] init];
    });
    return _zyhArticleDateFormatter;
}

+ (NSString *)publicTimeStringByDate:(NSDate *)date {
    NSDateFormatter *formatter = [self shareFormatter];
    [formatter setDateFormat:@"H"];
    NSString *timeString = [formatter stringFromDate:date];
    if (0 == [timeString intValue]) {
        return @"刚刚";
    }
    return [NSString stringWithFormat:@"%@小时前", timeString];
}
@end
