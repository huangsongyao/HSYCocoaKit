//
//  HSYCustomGestureView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/14.
//

#import "HSYCustomGestureView.h"
#import "UIView+Gestures.h"
#import "ReactiveCocoa.h"

@implementation HSYCustomGestureView

- (RACSignal *)hsy_addSingleGesture
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_addTapGestureRecognizerDelegate:self subscribeNext:^(UITapGestureRecognizer *gesture) {
            [subscriber sendNext:gesture];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_addSingleGesture”");
        }];
    }];
}

- (RACSignal *)hsy_addDoubleGesture
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_addDoubleGestureRecognizerDelegate:self subscribeNext:^(UITapGestureRecognizer *gesture) {
            [subscriber sendNext:gesture];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_addDoubleGesture”");
        }];
    }];
}

+ (NSArray<NSString *> *)hsy_defaultUnReponseClasses
{
    return @[@"UITableViewCell"];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch
{
    for (NSString *classes in self.hsy_unResponseClases) {
        if ([NSClassFromString(classes) isKindOfClass:touch.view.class]) {
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
