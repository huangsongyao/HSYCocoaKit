//
//  HSYBaseCustomButton.m
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseCustomButton.h"
#import "UIView+Frame.h"
#import "ReactiveCocoa.h"

@interface HSYBaseCustomButton ()

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect imageRect;

@end

@implementation HSYBaseCustomButton

+ (instancetype)initWithParamters:(NSDictionary<NSNumber *,id> *)paramters frame:(CGRect)frame
{
    HSYBaseCustomButton *button = [HSYBaseCustomButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    UIImage *image = paramters[@(kHSYCocoaKitCustomButtonPropertyTypeImage)];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    UIImage *hImage = paramters[@(kHSYCocoaKitCustomButtonPropertyTypeHighImage)];
    if (hImage) {
        [button setImage:hImage forState:UIControlStateHighlighted];
    }
    
    NSString *title = paramters[@(kHSYCocoaKitCustomButtonPropertyTypeTitle)];
    if (title.length > 0) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
    }
    
    UIFont *font = paramters[@(kHSYCocoaKitCustomButtonPropertyTypeFont)];
    if (font) {
        button.titleLabel.font = font;
    }
    
    UIColor *color = paramters[@(kHSYCocoaKitCustomButtonPropertyTypeTextColor)];
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
    UIColor *hColor = paramters[@(kHSYCocoaKitCustomButtonPropertyTypeHighTextColor)];
    if (hColor) {
        [button setTitleColor:hColor forState:UIControlStateHighlighted];
    }
    
    return button;
}

#pragma mark - Update ButtonImageView && ButtonTitle Frame

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.imageRect.size.width == 0) {
        return [super imageRectForContentRect:contentRect];
    }
    return self.imageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (self.titleRect.size.width == 0) {
        return [super titleRectForContentRect:contentRect];
    }
    return self.titleRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation HSYBaseCustomButton (Show)

+ (HSYBaseCustomButton *)showCustomButtonForFrame:(CGRect)frame
                                        imageRect:(CGRect)imageRect
                                        titleRect:(CGRect)titleRect
                                     propertyEnum:(NSDictionary<NSNumber *,id> *)propertyEnum
                                 didSelectedBlock:(void (^)(HSYBaseCustomButton *btn))block
{
    HSYBaseCustomButton *button = [HSYBaseCustomButton initWithParamters:propertyEnum frame:frame];
    button.titleRect = titleRect;
    button.imageRect = imageRect;
    [[[button rac_signalForControlEvents:UIControlEventTouchUpInside] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYBaseCustomButton *btn) {
        if (block) {
            block(btn);
        }
    }];
    return button;
}

@end
