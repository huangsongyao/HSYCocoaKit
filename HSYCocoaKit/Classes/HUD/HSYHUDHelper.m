//
//  HSYHUDHelper.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "HSYHUDHelper.h"
#import "UIApplication+Device.h"

static HSYHUDHelper *hsyHUDHelper = nil;

@interface HSYHUDHelper ()<MBProgressHUDDelegate>

@property (nonatomic, strong) NSMutableArray *hudViews;                  //缓存所有创建的hudView
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

+ (MBProgressHUD *)showHUDViewForMessage:(NSString *)message
{
    return [[HSYHUDHelper shareInstance] showHUDViewType:kShowHUDViewTypeText text:message hideAfter:HUD_STRING_DISPLAY_TIME];
}

+ (MBProgressHUD *)showHUDViewForShowType:(kShowHUDViewType)showType text:(NSString *)text hideAfter:(CGFloat)time
{
    return [[HSYHUDHelper shareInstance] showHUDViewType:showType text:text hideAfter:time];
}

- (MBProgressHUD *)showHUDViewType:(kShowHUDViewType)type text:(NSString *)text hideAfter:(CGFloat)time
{
    MBProgressHUD *hudView = [self createHUDViewType:type text:text hideAfter:time];
    self.currentDisplayHud = hudView;
    return hudView;
}

- (MBProgressHUD *)createHUDViewType:(kShowHUDViewType)type text:(NSString *)text hideAfter:(CGFloat)time
{
    if (self.hudViews.count > 0) {
        [HSYHUDHelper hideAllHUDView];
    }
    
    MBProgressHUD *hudView = [[MBProgressHUD alloc] initWithWindow:[UIApplication keyWindows]];
    [[UIApplication keyWindows] addSubview:hudView];
    
    switch (type) {
        case kShowHUDViewTypeDefault: {
            hudView.mode = MBProgressHUDModeIndeterminate;
        }
            break;
        case kShowHUDViewTypeText: {
            hudView.mode = MBProgressHUDModeText;
        }
            break;
        case kShowHUDViewTypeWait: {
            hudView.mode = MBProgressHUDModeIndeterminate;
        }
            break;
        case kShowHUDViewTypeWrong: {
            hudView.mode = 	MBProgressHUDModeCustomView;
        }
            break;
        default:
            break;
    }
    hudView.labelText = text;
    hudView.animationType = self.hudAnimationType;
    hudView.removeFromSuperViewOnHide = YES;
    hudView.delegate = self;
    [hudView show:YES];
    self.currentDisplayHud = hudView;
    
    if (time > 0) {
        [hudView hide:YES afterDelay:time];
    }
    return hudView;
}


- (void)hideHUDView
{
    if (!self.currentDisplayHud) {
        return;
    }
    [self.currentDisplayHud hide:YES];
}

+ (void)hideHUDView
{
    [[HSYHUDHelper shareInstance] hideHUDView];
}

+ (void)setHUDAnimationType:(MBProgressHUDAnimation)animationType
{
    [[HSYHUDHelper shareInstance] setHUDAnimationType:animationType];
}

- (void)setHUDAnimationType:(MBProgressHUDAnimation)animationType
{
    self.hudAnimationType = animationType;
}

+ (void)hideAllHUDView
{
    [[HSYHUDHelper shareInstance] hideAllHUDView];
}

- (void)hideAllHUDView
{
    for (MBProgressHUD *hud in self.hudViews) {
        [hud hide:YES];
    }
}

@end
