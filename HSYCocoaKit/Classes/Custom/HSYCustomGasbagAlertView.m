//
//  HSYCustomGasbagAlertView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/19.
//

#import "HSYCustomGasbagAlertView.h"
#import "HSYBaseTableViewCell.h"

//********************************************气囊动画的cell**********************************************

@interface HSYCustomGasbagCell : HSYBaseTableViewCell

@property (nonatomic, strong) UILabel *hsy_label;

@end

@implementation HSYCustomGasbagCell

@end

//********************************************气囊动画的list*********************************************

@interface HSYCustomGasbagView : UIView

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HSYCustomGasbagView

@end

//******************************************气囊动画的windows层********************************************

@interface HSYCustomGasbagAlertView ()

@property (nonatomic, strong) HSYCustomGasbagView *hsy_gasbagView;
@property (nonatomic, strong) UIView *hsy_blackMaskView;

@end

@implementation HSYCustomGasbagAlertView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
