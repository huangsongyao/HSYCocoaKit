//
//  HSYBaseTableViewCell.h
//  Pods
//
//  Created by huangsongyao on 2018/4/13.
//
//

#import <UIKit/UIKit.h>

@class MASConstraintMaker;
@interface HSYBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL hsy_useFDTmplateLayout;              //是否支持“UITableView+FDTemplateLayoutCell”库的cell算高，默认不支持，设置为支持后，必须计算好HSYBaseTableViewCell或者其子类的self.height，父类中会调用“- sizeThatFits:”对高度重新计算

/**
 添加线条

 @param color 线条颜色
 @param block 线条的布局位置
 */
- (void)hsy_lineInCell:(UIColor *)color constraintMaker:(void(^)(MASConstraintMaker *))block;
+ (UIView *)hsy_line:(UIColor *)color;

@end
