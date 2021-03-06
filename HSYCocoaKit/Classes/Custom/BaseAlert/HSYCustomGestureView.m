//
//  HSYCustomGestureView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/14.
//

#import "HSYCustomGestureView.h"
#import "UIView+Gestures.h"
#import "ReactiveCocoa.h"
#import "UIView+Frame.h"
#import "PublicMacroFile.h"
#import "UIViewController+Keyboard.h"

NSInteger const kHSYCocoaKitSingleGestureDefaultTags        = 756;

@implementation HSYCustomGestureView

#pragma mark - Keyboard

- (RACSignal *)hsy_keyboardObserver:(BOOL)completedSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[UIViewController rac_kvoToKeyboardWillChangedByObject:nil] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNotification *notification) {
            if (notification.userInfo) {
                NSDictionary *userInfo = notification.userInfo;
                CGRect frameBegin = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
                CGRect frameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
                BOOL isKeyboardFewer = NO;
                if (frameEnd.origin.y > frameBegin.origin.y) {
                    isKeyboardFewer = YES;
                }
                RACTuple *tuple = RACTuplePack([NSValue valueWithCGRect:frameBegin], [NSValue valueWithCGRect:frameEnd], @(isKeyboardFewer));
                [subscriber sendNext:tuple];
                if (completedSignal) {
                    [subscriber sendCompleted];
                }
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_keyboardObserver:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

#pragma mark - Gesture

- (RACSignal *)hsy_addSingleGesture
{
    return [self hsy_addSingleGesture:YES];
}

- (RACSignal *)hsy_addSingleGesture:(BOOL)completedSignal
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_addTapGestureRecognizerDelegate:self subscribeNext:^(UITapGestureRecognizer *gesture) {
            [subscriber sendNext:gesture];
            if (completedSignal) {
                [subscriber sendCompleted];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_addSingleGesture:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

- (RACSignal *)hsy_addDoubleGesture
{
    return [self hsy_addDoubleGesture:YES];
}

- (RACSignal *)hsy_addDoubleGesture:(BOOL)completedSignal
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_addDoubleGestureRecognizerDelegate:self subscribeNext:^(UITapGestureRecognizer *gesture) {
            [subscriber sendNext:gesture];
            if (completedSignal) {
                [subscriber sendCompleted];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_addDoubleGesture:” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

+ (NSArray<NSString *> *)hsy_defaultUnReponseClasses
{
    return @[@"UITableViewCellContentView"];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch
{
    for (NSString *classes in self.hsy_unResponseClases) {
        if ([NSStringFromClass(touch.view.class) isEqualToString:classes]) {
            return NO;
        }
    }
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//****************************************************************************************************

@implementation HSYCustomSingleGestureMaskView

- (instancetype)initWithSingleGesture:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))gesture
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT)]) {
        self.backgroundColor = CLEAR_COLOR;
        self.tag = kHSYCocoaKitSingleGestureDefaultTags;
        @weakify(self);
        [[[self hsy_addSingleGesture] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UITapGestureRecognizer *tap) {
            @strongify(self);
            if (gesture) {
                gesture(tap, self);
            }
        }];
    }
    return self;
}

@end


