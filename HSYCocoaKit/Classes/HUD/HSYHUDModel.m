//
//  HSYHUDModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "HSYHUDModel.h"
#import "PublicMacroFile.h"

static NSString *const kHSYCocoaKitHUDShowTypeKey           = @"mfow3iofwaf3ioawoienawf";
static NSString *const kHSYCocoaKitHUDTextKey               = @"f0wo3fapwofwpafwefawf3a";
static NSString *const kHSYCocoaKitHUDDuraTiemKey           = @"09w39jfa0wf3f90ak3okaw3fok";

@implementation HSYHUDModel

+ (NSDictionary *)defaultsConfig
{
    return @{
             @(kHSYHUDModelCodeTypeRequestFailure) : @{
                        kHSYCocoaKitHUDShowTypeKey : @(kShowHUDViewTypeText),
                        kHSYCocoaKitHUDTextKey : HSYLOCALIZED(HUD_REQUEST_FAILURE),
                        kHSYCocoaKitHUDDuraTiemKey : @(HUD_STRING_DISPLAY_TIME),
                     },
             @(kHSYHUDModelCodeTypeSaveFileFailure) : @{
                        kHSYCocoaKitHUDShowTypeKey : @(kShowHUDViewTypeText),
                        kHSYCocoaKitHUDTextKey : HSYLOCALIZED(HUD_SAVE_FAILURE),
                        kHSYCocoaKitHUDDuraTiemKey : @(HUD_STRING_DISPLAY_TIME),
                        },
             @(kHSYHUDModelCodeTypeSaveFileSuccess) : @{
                        kHSYCocoaKitHUDShowTypeKey : @(kShowHUDViewTypeText),
                        kHSYCocoaKitHUDTextKey : HSYLOCALIZED(HUD_SAVE_SUCCESS),
                        kHSYCocoaKitHUDDuraTiemKey : @(HUD_STRING_DISPLAY_TIME),
                        },
             @(kHSYHUDModelCodeTypeUpdateLoading) : @{
                        kHSYCocoaKitHUDShowTypeKey : @(kShowHUDViewTypeWait),
                        kHSYCocoaKitHUDTextKey : HSYLOCALIZED(HUD_LOADING_DATA),
                        kHSYCocoaKitHUDDuraTiemKey : @(HUD_STRING_DISPLAY_TIME),
                        },
             @(kHSYHUDModelCodeTypeSaveFileLoading) : @{
                        kHSYCocoaKitHUDShowTypeKey : @(kShowHUDViewTypeWait),
                        kHSYCocoaKitHUDTextKey : HSYLOCALIZED(HUD_LOADING_FILE),
                        kHSYCocoaKitHUDDuraTiemKey : @(HUD_STRING_DISPLAY_TIME)
                        },
             @(kHSYHUDModelCodeTypeRequestPullUpSuccess) : @{
                        kHSYCocoaKitHUDShowTypeKey : @(kShowHUDViewTypeText),
                        kHSYCocoaKitHUDTextKey : HSYLOCALIZED(HUD_PULL_UP_SUCCESS_TEXT),
                        kHSYCocoaKitHUDDuraTiemKey : @(HUD_STRING_DISPLAY_TIME)
                        },
             @(kHSYHUDModelCodeTypeRequestPullDownSuccess) : @{
                        kHSYCocoaKitHUDShowTypeKey : @(kShowHUDViewTypeText),
                        kHSYCocoaKitHUDTextKey : HSYLOCALIZED(HUD_PULL_DOWN_SUCCESS_TEXT),
                        kHSYCocoaKitHUDDuraTiemKey : @(HUD_STRING_DISPLAY_TIME),
                        },
             };
}

+ (instancetype)initWithCodeType:(kHSYHUDModelCodeType)codeType
{
    NSDictionary *subParamter = self.class.defaultsConfig[@(codeType)];
    kShowHUDViewType type = (kShowHUDViewType)[subParamter[kHSYCocoaKitHUDShowTypeKey] integerValue];
    HSYHUDModel *model = [HSYHUDModel initWithShowHUDType:type
                                                 codeType:codeType text:subParamter[kHSYCocoaKitHUDTextKey]
                                            animationTime:[subParamter[kHSYCocoaKitHUDDuraTiemKey] floatValue]];
    return model;
}

+ (instancetype)initWithShowHUDType:(kShowHUDViewType)showType
                           codeType:(kHSYHUDModelCodeType)codeType
                               text:(NSString *)text
                      animationTime:(CGFloat)animationTime
{
    HSYHUDModel *model = [[HSYHUDModel alloc] init];
    model.hsy_showType = showType;
    model.hsy_hudString = text;
    model.hsy_animationTime = animationTime;
    model.hsy_codeType = codeType;
    model.hsy_showPromptContent = YES;
    
    return model;
}

@end
