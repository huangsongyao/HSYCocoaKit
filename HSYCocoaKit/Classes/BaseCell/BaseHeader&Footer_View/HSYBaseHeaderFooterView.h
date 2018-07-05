//
//  HSYBaseHeaderFooterView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/23.
//

#import <UIKit/UIKit.h>

@class MASConstraintMaker;
@interface HSYBaseHeaderFooterView : UITableViewHeaderFooterView

/**
 添加线条
 
 @param color 线条颜色
 @param block 线条的布局位置
 */
- (void)hsy_lineInHeaderFooterView:(UIColor *)color constraintMaker:(void(^)(MASConstraintMaker *))block;

@end
