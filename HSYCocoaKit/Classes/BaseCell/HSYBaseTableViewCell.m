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

@implementation HSYBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _hsy_useFDTmplateLayout = NO;
    }
    return self;
}

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
