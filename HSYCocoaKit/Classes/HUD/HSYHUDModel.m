//
//  HSYHUDModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "HSYHUDModel.h"

@implementation HSYHUDModel

+ (instancetype)initWithCodeType:(kHSYHUDModelCodeType)codeType
{    
    HSYHUDModel *model = nil;
    switch (codeType) {
        case kHSYHUDModelCodeTypeRequestFailure: {
            
            model = [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeText
                                            codeType:kHSYHUDModelCodeTypeRequestFailure
                                                text:HUD_FAILURE
                                       animationTime:HUD_STRING_DISPLAY_TIME];
        }
            break;
        case kHSYHUDModelCodeTypeRequestSuccess: {
            
            model = [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeText
                                            codeType:kHSYHUDModelCodeTypeRequestSuccess
                                                text:HUD_SUCCESS_TEXT
                                       animationTime:HUD_STRING_DISPLAY_TIME];
        }
            break;
        case kHSYHUDModelCodeTypeSaveFileFailure: {
            
            model = [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeText
                                            codeType:kHSYHUDModelCodeTypeSaveFileFailure
                                                text:HUD_FAILURE
                                       animationTime:HUD_STRING_DISPLAY_TIME];
        }
            break;
        case kHSYHUDModelCodeTypeSaveFileSuccess: {
            
            model = [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeText
                                            codeType:kHSYHUDModelCodeTypeSaveFileSuccess
                                                text:HUD_FAILURE
                                       animationTime:HUD_STRING_DISPLAY_TIME];
        }
            break;
        case kHSYHUDModelCodeTypeUpdateLoading: {
            
            model = [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWait
                                            codeType:kHSYHUDModelCodeTypeUpdateLoading
                                                text:HUD_WAIT_TEXT
                                       animationTime:HUD_HIDE_TIME];
            
        }
            break;
        case kHSYHUDModelCodeTypeSaveFileLoading: {
            
            model = [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeWait
                                            codeType:kHSYHUDModelCodeTypeSaveFileLoading
                                                text:HUD_WAIT_TEXT
                                       animationTime:HUD_HIDE_TIME];
        }
            break;
        case kHSYHUDModelCodeTypeRequestPullUpSuccess: {
            
            model = [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeText
                                            codeType:kHSYHUDModelCodeTypeRequestPullUpSuccess
                                                text:HUD_PULL_UP_SUCCESS_TEXT
                                       animationTime:HUD_STRING_DISPLAY_TIME];
        }
            break;
        case kHSYHUDModelCodeTypeRequestPullDownSuccess: {
            
            model = [HSYHUDModel initWithShowHUDType:kShowHUDViewTypeText
                                            codeType:kHSYHUDModelCodeTypeRequestPullDownSuccess
                                                text:HUD_PULL_DOWN_SUCCESS_TEXT
                                       animationTime:HUD_STRING_DISPLAY_TIME];
        }
            break;
        default: {
            model = [[HSYHUDModel alloc] init];
            model.codeType = codeType;
            return model;
        }
            break;
    }
    
    return model;
}

+ (instancetype)initWithShowHUDType:(kShowHUDViewType)showType
                           codeType:(kHSYHUDModelCodeType)codeType
                               text:(NSString *)text
                      animationTime:(CGFloat)animationTime
{
    HSYHUDModel *model = [[HSYHUDModel alloc] init];
    model.showType = showType;
    model.hudString = text;
    model.animationTime = animationTime;
    model.codeType = codeType;
    model.showPromptContent = YES;
    
    return model;
}

@end
