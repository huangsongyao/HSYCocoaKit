//
//  HSYBaseViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "HSYBaseViewController.h"
#import "NSError+Message.h"
#import "PublicMacroFile.h"

@implementation HSYBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //viewModel不允许为nil，可以指向它的子类对象
    NSParameterAssert(self.viewModel);
    if (VERSION_GTR_IOS8) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //监听一般网络请求成功
    @weakify(self);
    [[RACObserve(self, self.viewModel.successStatusCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        if (self.requestSuccess) {
            self.requestSuccess(x);
        }
    }];
    //监听一般网络请求失败
    [[RACObserve(self, self.viewModel.errorStatusCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        switch ([self requestStateCodeWithStateCode:x]) {
            case kHSYHUDModelCodeTypeRequestFailure:
                [HSYHUDHelper showHUDViewForMessage:HSYLOCALIZED(@"请求失败，请稍后再试")];
                break;
            case kHSYHUDModelCodeTypeSaveFileFailure:
                [HSYHUDHelper showHUDViewForMessage:HSYLOCALIZED(@"上传失败，请稍后再试")];
                break;
                
            default:
                break;
        }
        if (self.requestFailure) {
            self.requestFailure(x);
        }
    }];
}

- (kHSYHUDModelCodeType)requestStateCodeWithStateCode:(id)stateCode
{
    if([stateCode isKindOfClass:[NSError class]]) {
        [HSYHUDHelper hideAllHUDView];
        NSError *error = (NSError *)stateCode;
        if (error.userInfo[kErrorForNotNetworkKey]) {
            [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWrong codeType:kHSYHUDModelCodeTypeDefault text:error.userInfo[kErrorForNotNetworkKey] animationTime:HUD_HIDE_TIME];
        } else if (error.userInfo[NSLocalizedDescriptionKey]) {
            [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWrong codeType:kHSYHUDModelCodeTypeDefault text:error.userInfo[NSLocalizedDescriptionKey] animationTime:HUD_HIDE_TIME ];
        }
        return error.code;
    } else if ([stateCode isKindOfClass:[HSYHUDModel class]]) {
        HSYHUDModel *model = (HSYHUDModel *)stateCode;
        if (model.codeType == kHSYHUDModelCodeTypeUpdateLoading) {
            [HSYHUDHelper hideAllHUDView];//清除loading页面
            if (model.showPromptContent) {
                [HSYHUDHelper showHUDViewForShowType:model.showType text:model.hudString hideAfter:model.animationTime ];
            }
        } else if(model.codeType == kHSYHUDModelCodeTypeRequestSuccess) {
            [HSYHUDHelper hideAllHUDView];//清除loading页面
        } else if (model.codeType == kHSYHUDModelCodeTypeRequestFailure) {
            [HSYHUDHelper hideAllHUDView];//清除loading页面
            if (model.showPromptContent) {
                [HSYHUDHelper showHUDViewForShowType:model.showType text:model.hudString hideAfter:model.animationTime];
            }
        } else if (model.codeType == kHSYHUDModelCodeTypeRequestPullUpSuccess) {
            
        } else if (model.codeType == kHSYHUDModelCodeTypeRequestPullDownSuccess) {
            
        }
        return model.codeType;
    }
    return kHSYHUDModelCodeTypeDefault;
}

@end
