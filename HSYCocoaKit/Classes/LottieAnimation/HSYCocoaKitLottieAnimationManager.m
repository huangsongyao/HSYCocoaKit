//
//  HSYCocoaKitLottieAnimationManager.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "HSYCocoaKitLottieAnimationManager.h"

@implementation HSYCocoaKitLottieAnimationManager

+ (LOTAnimationView *)animationView:(NSString *)fileName
{
    LOTAnimationView *animation = [LOTAnimationView animationNamed:fileName];
    animation.loopAnimation = YES;
    if (!animation.isAnimationPlaying) {
        [animation play];
    }
    return animation;
}

@end
