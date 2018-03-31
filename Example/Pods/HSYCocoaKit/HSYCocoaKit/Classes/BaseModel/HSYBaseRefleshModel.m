//
//  HSYBaseRefleshModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "HSYBaseRefleshModel.h"

@implementation HSYBaseRefleshModel

- (void)nextPage
{
    _page ++;
}

- (void)firstPage
{
    _page = 1;
}

- (void)updateSize:(NSInteger)size
{
    if (size <= 0) {
        return;
    }
    _size = size;
}

- (void)updateNext:(RACSignal *(^)())network toMap:(NSMutableArray *(^)(id x))map pullDown:(kHSYReflesStatusType)status
{
    switch (status) {
        case kHSYReflesStatusTypePullDown:
            [self firstPage];
            break;
        case kHSYReflesStatusTypePullUp:
            [self nextPage];
            break;
        default:
            break;
    }
    @weakify(self);
    [self requestNetwork:network toMap:map subscriberNext:^(NSMutableArray *result) {
        if (result.count == 0) {
            return;
        }
        @strongify(self);
        if (status == kHSYReflesStatusTypePullDown) {
            [self.datas removeAllObjects];
            self.datas = [result mutableCopy];
            self.pullDownStateCode = [HSYHUDModel initWithCodeType:kHSYHUDModelCodeTypeRequestSuccess];
        } else {
            for (id obj in result) {
                [self.datas addObject:obj];
            }
            self.pullUpStateCode = [HSYHUDModel initWithCodeType:kHSYHUDModelCodeTypeRequestSuccess];
        }
    }];
}


@end
