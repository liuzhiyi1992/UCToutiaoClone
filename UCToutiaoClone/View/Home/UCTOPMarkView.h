//
//  UCTOPMarkView.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/30.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OP_MARK_IMAGE_TITLE_MARGIN 2

@interface UCTOPMarkView : UIView
- (void)updateWithTitle:(NSString *)title iconUrlString:(NSString *)iconUrlString;
+ (CGSize)opMarkSizeWithString:(NSString *)string;
@end
