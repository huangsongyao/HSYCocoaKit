//
//  UIViewController+Runtime.m
//  Pods
//
//  Created by huangsongyao on 2018/4/27.
//
//

#import "UIViewController+Runtime.h"
#import <objc/runtime.h>

@implementation UIViewController (Runtime)

+ (void)load
{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self.class, @selector(exchangeDealloc)));
}

- (void)exchangeDealloc
{
    NSLog(@"===%@ dealloc===", self.class);
    [self exchangeDealloc];
}

@end
