//
//  UIResponder+Orientation.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/24.
//

#import "UIResponder+Orientation.h"
#import "NSObject+Property.h"

static NSString *kHSYCocoaKitInterfaceOrientationKey    = @"HSYCocoaKitInterfaceOrientationKey";
static NSString *kHSYCocoaKitLandscapeDirectionKey      = @"kHSYCocoaKitLandscapeDirectionKey";

@implementation UIResponder (Orientation)

#pragma mark - Runtime For Property

- (NSNumber *)hsy_landscapeInterfaceOrientation
{
    NSNumber *landscapeInterfaceOrientation = [self getPropertyForKey:kHSYCocoaKitInterfaceOrientationKey];
    return landscapeInterfaceOrientation;
}

- (void)setHsy_landscapeInterfaceOrientation:(NSNumber *)hsy_landscapeInterfaceOrientation
{
    [self setProperty:hsy_landscapeInterfaceOrientation forKey:kHSYCocoaKitInterfaceOrientationKey nonatomic:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (NSNumber *)hsy_landscapeDirection
{
    NSNumber *direction = [self getPropertyForKey:kHSYCocoaKitLandscapeDirectionKey];
    return direction;
}

- (void)setHsy_landscapeDirection:(NSNumber *)hsy_landscapeDirection
{
    [self setProperty:hsy_landscapeDirection forKey:kHSYCocoaKitLandscapeDirectionKey nonatomic:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

#pragma mark - Methods

+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)landscapeDirection:(BOOL)landscape
{
    UIInterfaceOrientation interfaceOrientation = UIInterfaceOrientationPortrait;
    if (landscape) {
        interfaceOrientation = UIInterfaceOrientationLandscapeRight;
    }
    NSDictionary *dic = @{@(UIInterfaceOrientationPortrait) : @(UIInterfaceOrientationMaskPortrait), @(UIInterfaceOrientationLandscapeRight) : @(UIInterfaceOrientationMaskLandscapeRight), };
    UIInterfaceOrientationMask interfaceOrientationMask = [dic[@(interfaceOrientation)] integerValue];
    self.hsy_landscapeDirection = @(interfaceOrientationMask);
    [UIResponder interfaceOrientation:interfaceOrientation];
}

@end
