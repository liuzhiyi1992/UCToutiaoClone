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

+ (NSString *)publicTimeStringByTimeInterval:(NSTimeInterval)timeInterval {
    timeInterval = timeInterval / 1000;
    NSDateFormatter *formatter = [self shareFormatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *timeString;
    int timeDiff = ([[NSDate date] timeIntervalSince1970] - timeInterval);
    if (timeDiff < 600) {//刚刚
        timeString = @"刚刚";
    } else if (timeDiff < 3600) {//分钟
        //todo 检查下耗时点
        [formatter setDateFormat:@"m分钟前"];
        timeString = [formatter stringFromDate:date];
    } else {
        [formatter setDateFormat:@"H小时前"];
        timeString = [formatter stringFromDate:date];
    }
    return timeString;
}
@end
