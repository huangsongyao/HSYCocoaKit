//
//  HSYBaseViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import <UIKit/UIKit.h>
#import "HSYHUDModel.h"
#import "HSYBaseRefleshModel.h"

@interface HSYBaseViewController : UIViewController

@property (nonatomic, strong) HSYBaseRefleshModel *viewModel;  //该指针允许指向HSYBaseModel子类中的对象，并且使用了建言模式，不允许为nil，默认为nil。
@property (nonatomic, copy) void(^requestSuccess)(id json);    //请求一般网络成功后预留一个接口用于子类使用
@property (nonatomic, copy) void(^requestFailure)(id error);   //请求一般网络失败后预留一个接口用于子类使用


/**
 *  请求状态码识别
 *
 *  @param stateCode 状态码
 *
 *  @return 状态码枚举或者error的code码
 */
- (kHSYHUDModelCodeType)requestStateCodeWithStateCode:(id)stateCode;

@end
