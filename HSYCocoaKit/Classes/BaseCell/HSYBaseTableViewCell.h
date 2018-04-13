//
//  HSYBaseTableViewCell.h
//  Pods
//
//  Created by huangsongyao on 2018/4/13.
//
//

#import <UIKit/UIKit.h>

@interface HSYBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL hsy_useFDTmplateLayout;              //是否支持“UITableView+FDTemplateLayoutCell”库的cell算高，默认不支持，设置为支持后，必须计算好HSYBaseTableViewCell或者其子类的self.height，父类中会调用“- sizeThatFits:”对高度重新计算

@end
