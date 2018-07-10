//
//  HSYCustomBannerBaseCell.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import "HSYCustomBannerBaseCell.h"
#import "ReactiveCocoa.h"
#import "HSYCustomBannerView.h"
#import "Masonry.h"

@implementation HSYCustomBannerCellContentView

- (instancetype)initWithSubscribeNext:(void(^)(id x))next
{
    if (self = [super init]) {
        [[[self hsy_addSingleGesture] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:next];
    }
    return self;
}

@end

//***********************

@implementation HSYCustomBannerBaseCell

- (instancetype)initWithData:(HSYCustomBannerDataSourece *)data
{
    if (self = [super initWithFrame:CGRectZero]) {
        @weakify(self);
        _hsy_contentView = [[HSYCustomBannerCellContentView alloc] initWithSubscribeNext:^(id x) {
            @strongify(self);
            if (self.hsy_delegate && [self.hsy_delegate respondsToSelector:@selector(hsy_customBannerBaseCell:)]) {
                [self.hsy_delegate hsy_customBannerBaseCell:self];
            }
        }];
        [self addSubview:self.hsy_contentView];
        [self.hsy_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
