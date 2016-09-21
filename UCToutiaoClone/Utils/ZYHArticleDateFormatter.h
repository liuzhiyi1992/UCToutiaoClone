//
//  ZYHArticleDateFormatter.h
//  UCToutiaoClone
//
//  Created by lzy on 16/9/21.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHArticleDateFormatter : NSObject
+ (NSDateFormatter *)shareFormatter;
+ (NSString *)publicTimeStringByTimeInterval:(NSTimeInterval)timeInterval;
@end
