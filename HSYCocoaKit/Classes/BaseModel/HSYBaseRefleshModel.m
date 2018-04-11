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
        [self hsy_updateSize:100];
        [self hsy_firstPage];
    }
    return self;
}

- (void)hsy_nextPage
{
    _page ++;
}

- (void)hsy_firstPage
{
    _page = 1;
}

- (void)hsy_updateSize:(NSInteger)size
{
    if (size <= 0) {
        return;
    }
    _size = size;
}

- (void)hsy_updateNext:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map pullDown:(kHSYReflesStatusType)status
{
    switch (status) {
        case kHSYReflesStatusTypePullDown:
            [self hsy_firstPage];
            break;
        case kHSYReflesStatusTypePullUp:
            [self hsy_nextPage];
            break;
        default:
            break;
    }
    @weakify(self);
    [self hsy_requestNetwork:network toMap:map subscriberNext:^BOOL(NSMutableArray *result) {
        if (result.count == 0) {
            return NO;
        }
        @strongify(self);
        //加载成功后动态更新数据源信息，并设置当前的statusCode状态
        if (status == kHSYReflesStatusTypePullDown) {
            [self.hsy_datas removeAllObjects];
            self.hsy_datas = [result mutableCopy];
            self.hsy_pullDownStateCode = [HSYHUDModel initWithCodeType:kHSYHUDModelCodeTypeRequestPullDownSuccess];
        } else {
            for (id obj in result) {
                [self.hsy_datas addObject:obj];
            }
            self.hsy_pullUpStateCode = [HSYHUDModel initWithCodeType:kHSYHUDModelCodeTypeRequestPullUpSuccess];
        }
        return NO;
    }];
}


@end
