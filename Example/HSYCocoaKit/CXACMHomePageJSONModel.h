//
//  CXACMHomePageJSONModel.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/4.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "JSONModel.h"

@interface CXACMHomePageItemJSONModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *tOPIC;            //标题
@property (nonatomic, strong) NSString<Optional> *sHOW_TIME;        //时间
@property (nonatomic, strong) NSString<Optional> *nEWS_IMG_URL;     //图片地址
@property (nonatomic, strong) NSString<Optional> *sOURCE;           //来源
@property (nonatomic, strong) NSString<Optional> *aUTHOR;           //作者

@end

@protocol CXACMHomePageItemJSONModel;
@interface CXACMHomePageBodyListJSONModel : JSONModel

@property (nonatomic, strong) NSMutableArray<CXACMHomePageItemJSONModel, Optional> *Item;

@end

@interface CXACMHomePageBodyJSONModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *TotalCount;
@property (nonatomic, strong) NSString<Optional> *PageNo;
@property (nonatomic, strong) NSString<Optional> *RecNum;
@property (nonatomic, strong) CXACMHomePageBodyListJSONModel<Optional> *List;

@end

@interface CXACMHomePageHeaderJSONModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *reCode;
@property (nonatomic, strong) NSString<Optional> *rspTranDate;
@property (nonatomic, strong) NSString<Optional> *retMsg;
@property (nonatomic, strong) NSString<Optional> *rspTranTime;
@property (nonatomic, strong) NSString<Optional> *msgTyp;
@property (nonatomic, strong) NSString<Optional> *version;

@end

@interface CXACMHomePageMessageJSONModel : JSONModel

@property (nonatomic, strong) CXACMHomePageBodyJSONModel<Optional> *Body;
@property (nonatomic, strong) CXACMHomePageHeaderJSONModel<Optional> *Header;

@end

@interface CXACMHomePageJSONModel : JSONModel

@property (nonatomic, strong) CXACMHomePageMessageJSONModel<Optional> *message;
@property (nonatomic, strong) NSString<Optional> *msgCode;

@end
