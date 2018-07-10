//
//  HSYCustomBannerCell.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import "HSYCustomBannerCell.h"
#import "NSObject+UIKit.h"

@implementation HSYCustomBannerCell

- (instancetype)initWithData:(HSYCustomBannerDataSourece *)data
{
    if (self = [super initWithData:data]) {
        self.backgroundColor = [UIColor blueColor];
        self.label = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeTextColor) : BLACK_COLOR, @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_BOLD_SYSTEM_FONT_18, @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter), }];
        [self.hsy_contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.hsy_contentView);
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
