//
//  HSYViewControllerModel.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/4/2.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYCocoaKit.h"
#import <JSONModel/JSONModel.h>

@interface TestJ_SubModel : JSONModel

@property (nonatomic, strong) NSNumber <Optional>*hardware;
@property (nonatomic, strong) NSNumber <Optional>*createDate;
@property (nonatomic, strong) NSNumber <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*msg;
@property (nonatomic, strong) NSString <Optional>*sec;
@property (nonatomic, strong) NSNumber <Optional>*version;

@end

@protocol TestJ_SubModel;
@interface TestJ_Model : JSONModel

@property (nonatomic, strong) NSString <Optional>*code;
@property (nonatomic, strong) NSString <Optional>*msg;
@property (nonatomic, strong) TestJ_SubModel <Optional>*data;

@end


@interface HSYViewControllerModel : HSYBaseRefleshModel

@property (nonatomic, strong, readonly) TestJ_Model *j_model;

@end
