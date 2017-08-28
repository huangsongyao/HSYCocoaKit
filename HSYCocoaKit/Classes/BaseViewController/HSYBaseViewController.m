//
//  HSYBaseViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "HSYBaseViewController.h"
#import "NSError+Message.h"

@implementation HSYBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (kHSYHUDModelCodeType)requestStateCodeWithStateCode:(id)stateCode
{
    if([stateCode isKindOfClass:[NSError class]]) {
        [HSYHUDHelper hideAllHUDView];
        NSError *error = (NSError *)stateCode;
        if (error.userInfo[kErrorKey]) {
            [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWrong codeType:kHSYHUDModelCodeTypeDefault text:error.userInfo[kErrorKey] animationTime:HUD_HIDE_TIME];
        } else if (error.userInfo[NSLocalizedDescriptionKey]) {
            [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWrong codeType:kHSYHUDModelCodeTypeDefault text:error.userInfo[NSLocalizedDescriptionKey] animationTime:HUD_HIDE_TIME ];
        }
        return error.code;
    } else if ([stateCode isKindOfClass:[HSYHUDModel class]]) {
        HSYHUDModel *model = (HSYHUDModel *)stateCode;
        if (model.codeType == kHSYHUDModelCodeTypeUpdateLoading) {
            [HSYHUDHelper hideAllHUDView];
            [HSYHUDHelper showHUDViewForShowType:model.showType text:model.hudString hideAfter:model.animationTime ];
        } else if(model.codeType == kHSYHUDModelCodeTypeRequestSuccess) {
            [HSYHUDHelper hideAllHUDView];//清除loading页面
        } else if (model.codeType == kHSYHUDModelCodeTypeRequestFailure) {
            [HSYHUDHelper hideAllHUDView];//清除loading页面
            [HSYHUDHelper showHUDViewForShowType:model.showType text:model.hudString hideAfter:model.animationTime];
        }
        return model.codeType;
    }
    return kHSYHUDModelCodeTypeDefault;
}

@end
