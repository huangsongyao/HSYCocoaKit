//
//  HSYBaseHeaderFooterView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/23.
//

#import "HSYBaseHeaderFooterView.h"
#import "HSYBaseTableViewCell.h"
#import "Masonry.h"

@implementation HSYBaseHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)hsy_lineInHeaderFooterView:(UIColor *)color constraintMaker:(void (^)(MASConstraintMaker *))block
{
    UIView *line = [HSYBaseTableViewCell hsy_line:color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:block];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
