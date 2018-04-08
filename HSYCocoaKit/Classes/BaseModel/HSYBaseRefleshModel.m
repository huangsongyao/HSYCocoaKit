//
//  HSYBaseRefleshModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "HSYBaseRefleshModel.h"

@implementation HSYBaseRefleshModel

- (instancetype)init
{
    if (self = [super init]) {
        [self updateSize:100];
        [self firstPage];
    }
    return self;
}

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

- (void)updateNext:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map pullDown:(kHSYReflesStatusType)status
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
    [self requestNetwork:network toMap:map subscriberNext:^BOOL(NSMutableArray *result) {
        if (result.count == 0) {
            return NO;
        }
        @strongify(self);
        //加载成功后动态更新数据源信息，并设置当前的statusCode状态
        if (status == kHSYReflesStatusTypePullDown) {
            [self.datas removeAllObjects];
            self.datas = [result mutableCopy];
            self.pullDownStateCode = [HSYHUDModel initWithCodeType:kHSYHUDModelCodeTypeRequestPullDownSuccess];
        } else {
            for (id obj in result) {
                [self.datas addObject:obj];
            }
            self.pullUpStateCode = [HSYHUDModel initWithCodeType:kHSYHUDModelCodeTypeRequestPullUpSuccess];
        }
        return NO;
    }];
}


@end
