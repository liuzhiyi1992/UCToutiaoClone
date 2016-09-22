//
//  UICollectionView+Bounds.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/22.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UICollectionView+Bounds.h"
#import "objc/runtime.h"

@implementation UICollectionView (Bounds)
- (void)zy_setBounds:(CGRect)bounds {
    BOOL isForbidSpringback = [self isForbidSpringback];
    BOOL isCrossBoundary = self.contentOffset.y < [self offsetYBoundary];
    
    if (!isForbidSpringback || !isCrossBoundary) {
        [self zy_setBounds:bounds];
    } else if (![self isAnimating]) {
        NSLog(@"自动往上处理");
        [self setIsAnimating:YES];
        [UIView animateWithDuration:2.f animations:^{
            CGRect scrollFrame = self.bounds;
            scrollFrame.origin.y = [self forbidAndAutoDistanceY];
            [self zy_setBounds:scrollFrame];
            [self setContentOffset:CGPointMake(self.contentOffset.x, [self forbidAndAutoDistanceY])];
        } completion:^(BOOL finished) {
            [self setIsForbidSpringback:NO];
            [self setIsAnimating:NO];
            [self setContentOffset:CGPointMake(self.contentOffset.x, [self forbidAndAutoDistanceY])];
            NSLog(@"完成");
        }];
    }
}

+ (void)load {
    [self swizzleMethod:@selector(setBounds:) anotherMethod:@selector(zy_setBounds:)];
}

+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    Method oneMethod = class_getInstanceMethod(self, oneSel);
    Method anotherMethod = class_getInstanceMethod(self, anotherSel);
    method_exchangeImplementations(oneMethod, anotherMethod);
}

- (BOOL)isForbidSpringback {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsForbidSpringback:(BOOL)isForbidSpringback {
    objc_setAssociatedObject(self, @selector(isForbidSpringback), @(isForbidSpringback), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)offsetYBoundary {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setOffsetYBoundary:(CGFloat)offsetYBoundary {
    objc_setAssociatedObject(self, @selector(offsetYBoundary), @(offsetYBoundary), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)forbidAndAutoDistanceY {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setForbidAndAutoDistanceY:(CGFloat)forbidAndAutoDistanceY {
    objc_setAssociatedObject(self, @selector(forbidAndAutoDistanceY), @(forbidAndAutoDistanceY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isAnimating {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsAnimating:(BOOL)isAnimating {
    objc_setAssociatedObject(self, @selector(isAnimating), @(isAnimating), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
