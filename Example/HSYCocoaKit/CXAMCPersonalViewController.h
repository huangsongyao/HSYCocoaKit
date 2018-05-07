//
//  CXAMCPersonalViewController.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/7.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYBaseTableViewController.h"

static CGFloat textFieldHeight = 43.0f;
static CGFloat titleLeft = 22.0f;

@interface CXAMCPersonalViewController : HSYBaseTableViewController

+ (UIButton *)logoutButton:(NSString *)title clickedOn:(void(^)(UIButton *button))clicked;

@end
