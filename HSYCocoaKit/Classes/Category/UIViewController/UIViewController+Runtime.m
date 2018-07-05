//
//  UIViewController+Runtime.m
//  Pods
//
//  Created by huangsongyao on 2018/4/27.
//
//

#import "UIViewController+Runtime.h"
#import "NSObject+Property.h"
#import "NSObject+Runtime.h"

static NSString *kHSYCocoaKitHsy_runtimeDelegateKey = @"HSYCocoaKitHsy_runtimeDelegateKey";

@implementation UIViewControllerRuntimeDelegateObject

+ (instancetype)initWithDictionary:(NSDictionary *)dic
{
    UIViewControllerRuntimeDelegateObject *object = [NSObject objectRuntimeValues:dic classes:[UIViewControllerRuntimeDelegateObject class]];
    return object;
}

@end

@implementation UIViewController (Runtime)

- (void)setHsy_runtimeDelegate:(id<UIViewControllerRuntimeDelegate>)hsy_runtimeDelegate
{
    [self setProperty:hsy_runtimeDelegate forKey:kHSYCocoaKitHsy_runtimeDelegateKey nonatomic:OBJC_ASSOCIATION_ASSIGN];
}

- (id<UIViewControllerRuntimeDelegate>)hsy_runtimeDelegate
{
    return [self getPropertyForKey:kHSYCocoaKitHsy_runtimeDelegateKey];
}

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
