//
//  HSYBaseTableViewCell.m
//  Pods
//
//  Created by huangsongyao on 2018/4/13.
//
//

#import "HSYBaseTableViewCell.h"
#import "UIView+Frame.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Masonry.h"

NSInteger const kHSYCocoaKitBaseCellBottomLineTag        = 163;

@implementation HSYBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _hsy_useFDTmplateLayout = NO;
    }
    return self;
}

#pragma mark - Bottom Line

- (void)hsy_lineInCell:(UIColor *)color constraintMaker:(void(^)(MASConstraintMaker *))block
{
    UIView *line = [self.class hsy_line:color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:block];
}

- (void)hsy_removeLine
{
    UIView *line = [self.contentView viewWithTag:kHSYCocoaKitBaseCellBottomLineTag];
    if (line) {
        [line removeFromSuperview];
        line = nil;
    }
}

+ (UIView *)hsy_line:(UIColor *)color
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = color;
    return line;
}

#pragma mark - FDT

- (void)setHsy_useFDTmplateLayout:(BOOL)hsy_useFDTmplateLayout
{
    _hsy_useFDTmplateLayout = hsy_useFDTmplateLayout;
    if (self.hsy_useFDTmplateLayout) {
        self.fd_enforceFrameLayout = YES;
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat height = (self.hsy_useFDTmplateLayout ? self.height : size.height);
    return CGSizeMake(size.width, height);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
