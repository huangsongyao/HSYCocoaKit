//
//  HSYHUDHelper.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "HSYHUDHelper.h"
#import "UIApplication+Device.h"
#import "MBProgressHUD.h"
#import "PublicMacroFile.h"

static HSYHUDHelper *hsyHUDHelper = nil;

@interface HSYHUDHelper ()<MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *currentDisplayHud;          //hudView
@property (nonatomic, assign) MBProgressHUDAnimation hudAnimationType;   //hudView动画类型

@end

@implementation HSYHUDHelper

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hsyHUDHelper = [HSYHUDHelper new];
    });
    return hsyHUDHelper;
}

#pragma mark - HUD----Text Model

+ (MBProgressHUD *)hsy_showHUDViewForMessage:(NSString *)message
{
    return [HSYHUDHelper hsy_showHUDViewForMessage:message hideAfter:HUD_STRING_DISPLAY_TIME];
}

+ (MBProgressHUD *)hsy_showHUDViewForMessage:(NSString *)message hideAfter:(CGFloat)time
{
    return [HSYHUDHelper hsy_showHUDViewForShowType:kShowHUDViewTypeText text:message hideAfter:time];
}

#pragma mark - HUD----Custom View Model

+ (MBProgressHUD *)hsy_showHUDViewForCustomView:(UIView *)view
{
    return [HSYHUDHelper hsy_showHUDViewForCustomView:view hideAfter:HUD_STRING_DISPLAY_TIME];
}

+ (MBProgressHUD *)hsy_showHUDViewForCustomView:(UIView *)view hideAfter:(CGFloat)time
{
    MBProgressHUD *progressHUD = [HSYHUDHelper hsy_showHUDViewForShowType:kShowHUDViewTypeCustom text:nil hideAfter:time];
    progressHUD.customView = view;
    return progressHUD;
}

#pragma mark - Create HUD

+ (MBProgressHUD *)hsy_showHUDViewForShowType:(kShowHUDViewType)showType text:(NSString *)text hideAfter:(CGFloat)time
{
    return [[HSYHUDHelper shareInstance] hsy_createHUDViewType:showType text:text hideAfter:time];
}

- (MBProgressHUD *)hsy_createHUDViewType:(kShowHUDViewType)type text:(NSString *)text hideAfter:(CGFloat)time
{
    [self hsy_hideHUDView];
    UIWindow *window = [UIApplication keyWindows];
    if (!window) {
        NSLog(@"\n ---get window failure !----");
    }
    MBProgressHUD *hudView = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hudView];
    NSDictionary *modelParamter = @{
                                    @(kShowHUDViewTypeDefault) : @(MBProgressHUDModeIndeterminate),
                                    @(kShowHUDViewTypeText) : @(MBProgressHUDModeText),
                                    @(kShowHUDViewTypeWait) : @(MBProgressHUDModeIndeterminate),
                                    @(kShowHUDViewTypeCustom) : @(MBProgressHUDModeCustomView),
                                    };
    hudView.mode = (MBProgressHUDMode)[modelParamter[@(type)] integerValue];
    if (text.length > 0) {
        hudView.detailsLabelText = text;
    }
    hudView.animationType = self.hudAnimationType;
    hudView.removeFromSuperViewOnHide = YES;
    hudView.delegate = self;
    hudView.detailsLabelFont = UI_SYSTEM_FONT_16;
    [hudView show:YES];
    self.currentDisplayHud = hudView;
    
    if (time > 0) {
        [hudView hide:YES afterDelay:time];
    }
    return hudView;
}

#pragma mark - Hidden HUD

- (void)hsy_hideHUDView
{
    if (!self.currentDisplayHud) {
        return;
    }
    [self.currentDisplayHud hide:YES];
}

+ (void)hsy_hideHUDView
{
    [[HSYHUDHelper shareInstance] hsy_hideHUDView];
}

#pragma mark - Set Paramter

- (void)hsy_setParamter:(NSDictionary<NSString *, id> *)paramter
{
    if (self.currentDisplayHud) {
        for (NSString *key in paramter.allKeys) {
            if ([self.currentDisplayHud respondsToSelector:NSSelectorFromString(key)]) {
                [self.currentDisplayHud setValue:paramter[key] forKey:key];
            }
        }
    }
}


@end
