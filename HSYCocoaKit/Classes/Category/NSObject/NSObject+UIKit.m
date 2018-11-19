//
//  NSObject+UIKit.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "NSObject+UIKit.h"
#import "ReactiveCocoa.h"
#import "UILabel+SuggestSize.h"
#import "UILabel+AttributedString.h"
#import "PublicMacroFile.h"
#import "UITextView+Placeholder.h"

//UIButton Key
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonNorBackgroundImage = @"kHSYCocoaKitButtonNorBackgroundImage";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonPreBackgroundImage = @"kHSYCocoaKitButtonPreBackgroundImage";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonNorTitle = @"kHSYCocoaKitButtonNorTitle";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonHighTitle = @"kHSYCocoaKitButtonHighTitle";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonNorImage = @"kHSYCocoaKitButtonNorImage";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonHighImage = @"kHSYCocoaKitButtonHighImage";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonSelectedImage = @"kHSYCocoaKitButtonSelectedImage";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonTitleColor = @"kHSYCocoaKitButtonTitleColor";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonTitleFont = @"kHSYCocoaKitButtonTitleFont";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonCornerRadius = @"kHSYCocoaKitButtonCornerRadius";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonTextAlignment = @"kHSYCocoaKitButtonTextAlignment";
HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonSkipFirst = @"kHSYCocoaKitButtonSkipFirst";

//UIImageView Key
HSYCocoaKitUIKitImagePropertyKey const HSYCocoaKitImageNorImage = @"kHSYCocoaKitImageNorImage";
HSYCocoaKitUIKitImagePropertyKey const HSYCocoaKitImagePreImage = @"kHSYCocoaKitImagePreImage";
HSYCocoaKitUIKitImagePropertyKey const HSYCocoaKitImageContentMode = @"kHSYCocoaKitImageContentMode";

//UILabel Key
HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelText = @"kHSYCocoaKitLabelText";
HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelTextColor = @"kHSYCocoaKitLabelTextColor";
HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelFont = @"kHSYCocoaKitLabelFont";
HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelBackgroundColor = @"kHSYCocoaKitLabelBackgroundColor";
HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelTextAlignment = @"kHSYCocoaKitLabelTextAlignment";
HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelUnline = @"kHSYCocoaKitLabelUnline";
HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelComputeSize = @"kHSYCocoaKitLabelComputeSize";

//UITextField Key
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledBorderWidth = @"kHSYCocoaKitTextFiledBorderWidth";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledBorderColor = @"kHSYCocoaKitTextFiledBorderColor";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledTextAlignment = @"kHSYCocoaKitTextFiledTextAlignment";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledFont = @"kHSYCocoaKitTextFiledFont";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledReturnKeyType = @"kHSYCocoaKitTextFiledReturnKeyType";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledKeyboardType = @"kHSYCocoaKitTextFiledKeyboardType";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledTextColor = @"kHSYCocoaKitTextFiledTextColor";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledBackgroundColor = @"kHSYCocoaKitTextFiledBackgroundColor";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledText = @"kHSYCocoaKitTextFiledText";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledPlaceholder = @"kHSYCocoaKitTextFiledPlaceholder";
HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledSkipFirst = @"kHSYCocoaKitTextFiledSkipFirst";

//UITextView Key
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewBorderWidth = @"kHSYCocoaKitTextViewBorderWidth";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewBorderColor = @"kHSYCocoaKitTextViewBorderColor";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewTextAlignment = @"kHSYCocoaKitTextViewTextAlignment";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewFont = @"kHSYCocoaKitTextViewFont";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewReturnKeyType = @"kHSYCocoaKitTextViewReturnKeyType";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewKeyboardType = @"kHSYCocoaKitTextViewKeyboardType";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewTextColor = @"kHSYCocoaKitTextViewTextColor";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewBackgroundColor = @"kHSYCocoaKitTextViewBackgroundColor";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewText = @"kHSYCocoaKitTextViewText";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewPlaceholder = @"kHSYCocoaKitTextViewPlaceholder";
HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewSkipFirst = @"kHSYCocoaKitTextViewSkipFirst";

//UITableView Key
HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewStyle = @"kHSYCocoaKitTableViewStyle";
HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewDelegate = @"kHSYCocoaKitTableViewDelegate";
HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewDataSource = @"kHSYCocoaKitTableViewDataSource";
HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewScrollEnabled = @"kHSYCocoaKitTableViewScrollEnabled";
HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewHiddenLine = @"kHSYCocoaKitTableViewHiddenLine";
HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewFooterView = @"kHSYCocoaKitTableViewFooterView";
HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewRegisterClass = @"kHSYCocoaKitTableViewRegisterClass";

//UIScrollView Key
HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewDelegate = @"kHSYCocoaKitScrollViewDelegate";
HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewContentSize = @"kHSYCocoaKitScrollViewContentSize";
HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewContentOffset = @"kHSYCocoaKitScrollViewContentOffset";
HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewPagingEnabled = @"kHSYCocoaKitScrollViewPagingEnabled";
HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewScrollEnabled = @"kHSYCocoaKitScrollViewScrollEnabled";
HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewBounces = @"kHSYCocoaKitScrollViewBounces";
HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewHiddenScrollIndicator = @"kHSYCocoaKitScrollViewHiddenScrollIndicator";

//UICollectionView Key
HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewFlowLayout = @"kHSYCocoaKitCollectionViewFlowLayout";
HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewDelegate = @"kHSYCocoaKitCollectionViewDelegate";
HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewDataSource = @"kHSYCocoaKitCollectionViewDataSource";
HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewScrollEnabled = @"kHSYCocoaKitCollectionViewScrollEnabled";
HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewBounces = @"kHSYCocoaKitCollectionViewBounces";
HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewHiddenScrollIndicator = @"kHSYCocoaKitCollectionViewHiddenScrollIndicator";
HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewRegisterClass = @"kHSYCocoaKitCollectionViewRegisterClass";

//UICollectionViewFlowLayout Key
HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutDirection = @"kHSYCocoaKitCollectionViewFlowLayoutDirection";
HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutSectionInset = @"kHSYCocoaKitCollectionViewFlowLayoutSectionInset";
HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutItemSize = @"kHSYCocoaKitCollectionViewFlowLayoutItemSize";
HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutLineSpacing = @"kHSYCocoaKitCollectionViewFlowLayoutLineSpacing";
HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutInteritemSpacing = @"kHSYCocoaKitCollectionViewFlowLayoutInteritemSpacing";
HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutHeaderReferenceSize = @"kHSYCocoaKitCollectionViewFlowLayoutHeaderReferenceSize";
HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutFooterReferenceSize = @"kHSYCocoaKitCollectionViewFlowLayoutFooterReferenceSize";

//UISlider Key
HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderNorThumbImage = @"kHSYCocoaKitSliderNorThumbImage";
HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderPreThumbImage = @"kHSYCocoaKitSliderPreThumbImage";
HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderNorMinimumTrackTintColor = @"kHSYCocoaKitSliderNorMinimumTrackTintColor";
HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderPreMinimumTrackTintColor = @"kHSYCocoaKitSliderPreMinimumTrackTintColor";
HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderMaximumValue = @"kHSYCocoaKitSliderMaximumValue";
HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderMinimumValue = @"kHSYCocoaKitSliderMinimumValue";
HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderValue = @"kHSYCocoaKitSliderValue";

@implementation NSObject (UIKit)

#pragma mark - Create Button

+ (UIButton *)createButtonByParam:(NSDictionary<id, id> *)param clickedOnSubscribeNext:(void(^)(UIButton *button))next
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = CLEAR_COLOR;
    button.clipsToBounds = YES;
    button.layer.masksToBounds = YES;
    
    UIImage *norBackgroundImage = param[@(kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName)] : param[HSYCocoaKitButtonNorBackgroundImage];
    if (norBackgroundImage) {
        [button setBackgroundImage:norBackgroundImage forState:UIControlStateNormal];
    }
    
    UIImage *preBackgroundImage = param[@(kHSYCocoaKitOfButtonPropretyTypePreBackgroundImageViewName)] ? param[@(kHSYCocoaKitOfButtonPropretyTypePreBackgroundImageViewName)] : param[HSYCocoaKitButtonPreBackgroundImage];
    if (preBackgroundImage) {
        [button setBackgroundImage:preBackgroundImage forState:UIControlStateHighlighted];
    }
    
    NSString *norTitle = param[@(kHSYCocoaKitOfButtonPropretyTypeNorTitle)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeNorTitle)] : param[HSYCocoaKitButtonNorTitle];
    if (norTitle) {
        [button setTitle:norTitle forState:UIControlStateNormal];
    }
    
    NSString *preTitle = param[@(kHSYCocoaKitOfButtonPropretyTypeHighTitle)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeHighTitle)] : param[HSYCocoaKitButtonHighTitle];
    if (preTitle) {
        [button setTitle:preTitle forState:UIControlStateHighlighted];
    }
    
    UIImage *norImage = param[@(kHSYCocoaKitOfButtonPropretyTypeNorImageViewName)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeNorImageViewName)] : param[HSYCocoaKitButtonNorImage];
    if (norImage) {
        [button setImage:norImage forState:UIControlStateNormal];
    }
    
    UIImage *highImage = param[@(kHSYCocoaKitOfButtonPropretyTypePreImageViewName)] ? param[@(kHSYCocoaKitOfButtonPropretyTypePreImageViewName)] : param[HSYCocoaKitButtonHighImage];
    if (highImage) {
        [button setImage:highImage forState:UIControlStateHighlighted];
    }
    
    UIImage *selImage = param[@(kHSYCocoaKitOfButtonPropretyTypeSelectedImageViewName)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeSelectedImageViewName)] : param[HSYCocoaKitButtonSelectedImage];
    if (selImage) {
        [button setImage:selImage forState:UIControlStateSelected];
    }
    
    UIColor *titleColor = param[@(kHSYCocoaKitOfButtonPropretyTypeTitleColor)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeTitleColor)] : param[HSYCocoaKitButtonTitleColor];
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeTitleColor)]) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    }
    
    UIFont *font = param[@(kHSYCocoaKitOfButtonPropretyTypeTitleFont)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeTitleFont)] : param[HSYCocoaKitButtonTitleFont];
    if (font) {
        button.titleLabel.font = font;
    }
    
    NSNumber *radius = param[@(kHSYCocoaKitOfButtonPropretyTypeCornerRadius)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeCornerRadius)] : param[HSYCocoaKitButtonCornerRadius];
    if (radius) {
        button.layer.cornerRadius = [radius floatValue];
    }
    
    NSNumber *horizontalAlignment = param[@(kHSYCocoaKitOfButtonPropretyTypeTextAlignment)] ? param[@(kHSYCocoaKitOfButtonPropretyTypeTextAlignment)] : param[HSYCocoaKitButtonTextAlignment];
    if (horizontalAlignment) {
        button.contentHorizontalAlignment = (UIControlContentHorizontalAlignment)[horizontalAlignment integerValue];
    }
    
    NSInteger skip = param[@(kHSYCocoaKitOfButtonPropretyTypeSkipFirst)] ? ([param[@(kHSYCocoaKitOfButtonPropretyTypeSkipFirst)] boolValue] ? 1 : 0) : (param[HSYCocoaKitButtonSkipFirst] ? ([param[HSYCocoaKitButtonSkipFirst] boolValue] ? 1 : 0) : 0);
    [[[[button rac_signalForControlEvents:UIControlEventTouchUpInside] skip:skip] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UIButton *btn) {
        if (next) {
            next(btn);
        }
    }];
    
    return button;
}

#pragma mark - Create ImageView

+ (UIImageView *)createImageViewByParam:(NSDictionary<id, id> *)param
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.backgroundColor = CLEAR_COLOR;
    imageView.clipsToBounds = YES;
    imageView.layer.masksToBounds = YES;
    
    UIImage *norImage = param[@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName)] ? param[@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName)] : param[HSYCocoaKitImageNorImage];
    if (norImage) {
        imageView.image = norImage;
    }
    
    UIImage *highImage = param[@(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName)] ? param[@(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName)] : param[HSYCocoaKitImagePreImage];
    if (highImage) {
        imageView.highlightedImage = highImage;
    }
    
    NSNumber *contentMode = param[@(kHSYCocoaKitOfImageViewPropretyTypeViewContentMode)] ? param[@(kHSYCocoaKitOfImageViewPropretyTypeViewContentMode)] : param[HSYCocoaKitImageContentMode];
    UIViewContentMode mode = (contentMode ? ((UIViewContentMode)[contentMode integerValue]) : UIViewContentModeScaleToFill);
    imageView.contentMode = mode;
    
    return imageView;
}

#pragma mark - Create Label

+ (UILabel *)createLabelByParam:(NSDictionary<id, id> *)param
{
    UILabel *label = nil;
    
    NSString *text = (param[@(kHSYCocoaKitOfLabelPropretyTypeText)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeText)] : (param[HSYCocoaKitLabelText] ? param[HSYCocoaKitLabelText] : @""));
    UIFont *font = (param[@(kHSYCocoaKitOfLabelPropretyTypeTextFont)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeTextFont)] : (param[HSYCocoaKitLabelFont] ? param[HSYCocoaKitLabelFont] : UI_SYSTEM_FONT_16));
    CGRect rect = CGRectZero;
    if (param[@(kHSYCocoaKitOfLabelPropretyTypeFrame)]) {
        NSValue *rectValue = param[@(kHSYCocoaKitOfLabelPropretyTypeFrame)];
        rect = rectValue.CGRectValue;
    }
    
    NSValue *valueCGSize = param[@(kHSYCocoaKitOfLabelPropretyTypeMaxSize)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeMaxSize)] : param[HSYCocoaKitLabelComputeSize];
    if (valueCGSize) {
        CGFloat width = valueCGSize.CGSizeValue.width;
        CGFloat height = valueCGSize.CGSizeValue.height;
        if ([param[@(kHSYCocoaKitOfLabelPropretyTypeIsUniline)] boolValue]) {
            label = [UILabel initWithUnilineText:text
                                            font:font
                                        maxWidth:width
                                       maxHeight:height];
        } else {
            label = [UILabel initWithText:text
                                     font:font
                                 maxWidth:width
                                maxHeight:height];
        }
    } else {
        label = [[UILabel alloc] initWithFrame:rect];
        label.text = text;
        label.font = font;
    }
    
    UIColor *backgroundColor = param[@(kHSYCocoaKitOfLabelPropretyTypeBackgroundColor)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeBackgroundColor)] : param[HSYCocoaKitLabelBackgroundColor];
    label.backgroundColor = (backgroundColor ? backgroundColor : CLEAR_COLOR);
    
    UIColor *textColor = param[@(kHSYCocoaKitOfLabelPropretyTypeTextColor)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeTextColor)] : param[HSYCocoaKitLabelTextColor];
    label.textColor = (textColor ? textColor : BLACK_COLOR);
    
    NSNumber *alignment = param[@(kHSYCocoaKitOfLabelPropretyTypeTextAlignment)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeTextAlignment)] : param[HSYCocoaKitLabelTextAlignment];
    label.textAlignment = (alignment ? ((NSTextAlignment)[alignment integerValue]) : NSTextAlignmentLeft);
    
    return label;
}

#pragma mark - Create TextFiled

+ (UITextField *)createTextFiledByParam:(NSDictionary<id, id> *)param
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    NSNumber *borderWidth = param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderWidth)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderWidth)] : param[HSYCocoaKitTextFiledBorderWidth];
    if (borderWidth) {
        textField.layer.borderWidth = [borderWidth floatValue];
    }
    
    UIColor *borderColor = param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderColor)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderColor)] : param[HSYCocoaKitTextFiledBorderColor];
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderColor)]) {
        textField.layer.borderColor = [borderColor CGColor];
    }
    
    NSNumber *alignment = param[@(kHSYCocoaKitOfTextFiledPropretyTypeTextAlignment)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeTextAlignment)] : param[HSYCocoaKitTextFiledTextAlignment];
    if (alignment) {
        textField.textAlignment = ((NSTextAlignment)[alignment integerValue]);
    }
    
    UIFont *font = param[@(kHSYCocoaKitOfTextFiledPropretyTypeFont)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeFont)] : param[HSYCocoaKitTextFiledFont];
    if (font) {
        textField.font = font;
    }
    
    NSNumber *returnKey = param[@(kHSYCocoaKitOfTextFiledPropretyTypeReturnKeyType)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeReturnKeyType)] : param[HSYCocoaKitTextFiledReturnKeyType];
    if (returnKey) {
        textField.returnKeyType = (UIReturnKeyType)[returnKey integerValue];
    }
    
    NSNumber *keyboard = param[@(kHSYCocoaKitOfTextFiledPropretyTypeKeyboardType)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeKeyboardType)] : param[HSYCocoaKitTextFiledKeyboardType];
    if (keyboard) {
        textField.keyboardType = (UIKeyboardType)[keyboard integerValue];
    }
    
    UIColor *textColor = param[@(kHSYCocoaKitOfTextFiledPropretyTypeTextColor)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeTextColor)] : param[HSYCocoaKitTextFiledTextColor];
    if (textColor) {
        textField.textColor = textColor;
    }
    
    UIColor *backgroundColor = param[@(kHSYCocoaKitOfTextFiledPropretyTypeBackgroundColor)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeBackgroundColor)] : param[HSYCocoaKitTextFiledBackgroundColor];
    if (backgroundColor) {
        textField.backgroundColor = backgroundColor;
    }
    
    NSString *text = param[@(kHSYCocoaKitOfTextFiledPropretyTypeText)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypeText)] : param[HSYCocoaKitTextFiledText];
    if (text) {
        textField.text = text;
    }
    
    NSString *placeholder = param[@(kHSYCocoaKitOfTextFiledPropretyTypePlaceholderString)] ? param[@(kHSYCocoaKitOfTextFiledPropretyTypePlaceholderString)] : param[HSYCocoaKitTextFiledPlaceholder];
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    return textField;
}

+ (UITextField *)createTextFiledByParam:(NSDictionary <NSNumber *, id>*)param didChangeSubscribeNext:(void(^)(NSString *text))next
{
    UITextField *textField = [self.class createTextFiledByParam:param];
    if (next) {
        NSInteger skip = param[@(kHSYCocoaKitOfTextFiledPropretyTypeSkipFirst)] ? ([param[@(kHSYCocoaKitOfTextFiledPropretyTypeSkipFirst)] boolValue] ? 1 : 0) : (param[HSYCocoaKitTextFiledSkipFirst] ? ([param[HSYCocoaKitTextFiledSkipFirst] boolValue] ? 1 : 0) : 0);
        [[[[textField rac_textSignal] skip:skip] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSString *text) {
            next(text);
        }];
    }
    return textField;
}

#pragma mark - Create TextView

+ (UITextView *)createTextViewByParam:(NSDictionary<id, id> *)param
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    
    NSNumber *borderWidth = param[@(kHSYCocoaKitOfTextViewPropretyTypeBorderWidth)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeBorderWidth)] : param[HSYCocoaKitTextViewBorderWidth];
    if (borderWidth) {
        textView.layer.borderWidth = [borderWidth floatValue];
    }
    
    UIColor *borderColor = param[@(kHSYCocoaKitOfTextViewPropretyTypeBorderColor)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeBorderColor)] : param[HSYCocoaKitTextViewBorderColor];
    if (borderColor) {
        textView.layer.borderColor = [borderColor CGColor];
    }
    
    NSNumber *alignment = param[@(kHSYCocoaKitOfTextViewPropretyTypeTextAlignment)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeTextAlignment)] : param[HSYCocoaKitTextViewTextAlignment];
    if (alignment) {
        textView.textAlignment = ((NSTextAlignment)[alignment integerValue]);
    }
    
    UIFont *font = param[@(kHSYCocoaKitOfTextViewPropretyTypeFont)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeFont)] : param[HSYCocoaKitTextViewFont];
    if (font) {
        textView.font = font;
    }
    
    NSNumber *returnKey = param[@(kHSYCocoaKitOfTextViewPropretyTypeReturnKeyType)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeReturnKeyType)] : param[HSYCocoaKitTextViewReturnKeyType];
    if (returnKey) {
        textView.returnKeyType = (UIReturnKeyType)[returnKey integerValue];
    }
    
    NSNumber *keyboard = param[@(kHSYCocoaKitOfTextViewPropretyTypeKeyboardType)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeKeyboardType)] : param[HSYCocoaKitTextViewKeyboardType];
    if (keyboard) {
        textView.keyboardType = (UIKeyboardType)[keyboard integerValue];
    }
    
    UIColor *textColor = param[@(kHSYCocoaKitOfTextViewPropretyTypeTextColor)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeTextColor)] : param[HSYCocoaKitTextViewTextColor];
    if (textColor) {
        textView.textColor = textColor;
    }
    
    UIColor *backgroundColor = param[@(kHSYCocoaKitOfTextViewPropretyTypeBackgroundColor)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeBackgroundColor)] : param[HSYCocoaKitTextViewBackgroundColor];
    if (backgroundColor) {
        textView.backgroundColor = backgroundColor;
    }
    
    NSString *text = param[@(kHSYCocoaKitOfTextViewPropretyTypeText)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypeText)] : param[HSYCocoaKitTextViewText];
    if (text) {
        textView.text = text;
    }
    
    NSString *placeholder = param[@(kHSYCocoaKitOfTextViewPropretyTypePlaceholder)] ? param[@(kHSYCocoaKitOfTextViewPropretyTypePlaceholder)] : param[HSYCocoaKitTextViewPlaceholder];
    if ([placeholder length] > 0) {
        textView.placeholder = placeholder;
    }
    return textView;
}

+ (UITextView *)createTextViewByParam:(NSDictionary<id, id> *)param didChangeSubscribeNext:(void(^)(NSString *text))next
{
    UITextView *textView = [self.class createTextViewByParam:param];
    if (next) {
        NSInteger skip = param[@(kHSYCocoaKitOfTextViewPropretyTypeSkipFirst)] ? ([param[@(kHSYCocoaKitOfTextViewPropretyTypeSkipFirst)] boolValue] ? 1 : 0) : (param[HSYCocoaKitTextViewSkipFirst] ? ([param[HSYCocoaKitTextViewSkipFirst] boolValue] ? 1 : 0) : 0);
        [[[[textView rac_textSignal] skip:skip] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSString *text) {
            next(text);
        }];
    }

    return textView;
}

#pragma mark - Create TableView

+ (UITableView *)createTabelViewByParam:(NSDictionary<id, id> *)param
{
    NSNumber *styleNumber = param[@(kHSYCocoaKitOfTableViewPropretyTypeTableViewStyle)] ? param[@(kHSYCocoaKitOfTableViewPropretyTypeTableViewStyle)] : param[HSYCocoaKitTableViewStyle];
    UITableViewStyle style = (styleNumber ? (UITableViewStyle)styleNumber.integerValue : UITableViewStylePlain);
    
    CGRect rect = CGRectZero;
    if (param[@(kHSYCocoaKitOfTableViewPropretyTypeFrame)]) {
        NSValue *value = param[@(kHSYCocoaKitOfTableViewPropretyTypeFrame)];
        rect = value.CGRectValue;
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:style];
    tableView.backgroundColor = [UIColor clearColor];
    
    id<UITableViewDelegate>delegate = param[@(kHSYCocoaKitOfTableViewPropretyTypeDelegate)] ? param[@(kHSYCocoaKitOfTableViewPropretyTypeDelegate)] : param[HSYCocoaKitTableViewDelegate];
    if (delegate) {
        tableView.delegate = delegate;
    }
    
    id<UITableViewDataSource>dataSource = param[@(kHSYCocoaKitOfTableViewPropretyTypeDataSource)] ? param[@(kHSYCocoaKitOfTableViewPropretyTypeDataSource)] : param[HSYCocoaKitTableViewDataSource];
    if (dataSource) {
        tableView.dataSource = dataSource;
    }
    
    tableView.clipsToBounds = YES;
    NSNumber *scrollEnabled = param[@(kHSYCocoaKitOfTableViewPropretyTypeScrollEnabled)] ? param[@(kHSYCocoaKitOfTableViewPropretyTypeScrollEnabled)] : param[HSYCocoaKitTableViewScrollEnabled];
    tableView.scrollEnabled = (scrollEnabled ? [scrollEnabled boolValue] : YES);
    
    NSNumber *hiddenCellLine = param[@(kHSYCocoaKitOfTableViewPropretyTypeHiddenCellLine)] ? param[@(kHSYCocoaKitOfTableViewPropretyTypeHiddenCellLine)] : param[HSYCocoaKitTableViewHiddenLine];
    if ([hiddenCellLine boolValue]) {
        //去掉单元格的分割线
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIView *tableFooterView = param[@(kHSYCocoaKitOfTableViewPropretyTypeTableFooterView)] ? param[@(kHSYCocoaKitOfTableViewPropretyTypeTableFooterView)] : param[HSYCocoaKitTableViewFooterView];
    if (tableFooterView) {
        tableView.tableFooterView = tableFooterView;
    }
    
    NSDictionary *registers = param[@(kHSYCocoaKitOfTableViewPropretyTypeRegisterClass)] ? param[@(kHSYCocoaKitOfTableViewPropretyTypeRegisterClass)] : param[HSYCocoaKitTableViewRegisterClass];
    if (registers) {
        Class class = NSClassFromString(registers.allKeys.firstObject);
        NSString *identifier = registers.allValues.firstObject;
        [tableView registerClass:class forCellReuseIdentifier:identifier];
    }
    
    return tableView;
}

#pragma mark - Create ScrollView

+ (UIScrollView *)createScrollViewByParam:(NSDictionary<id, id> *)param
{
    CGRect rect = CGRectZero;
    if (param[@(kHSYCocoaKitOfScrollViewPropretyTypeFrame)]) {
        NSValue *value = param[@(kHSYCocoaKitOfScrollViewPropretyTypeFrame)];
        rect = value.CGRectValue;
    }
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    
    id<UIScrollViewDelegate>delegate = param[@(kHSYCocoaKitOfScrollViewPropretyTypeDelegate)] ? param[@(kHSYCocoaKitOfScrollViewPropretyTypeDelegate)] : param[HSYCocoaKitScrollViewDelegate];
    if (delegate) {
        scrollView.delegate = delegate;
    }
    
    NSValue *valueCGSize = param[@(kHSYCocoaKitOfScrollViewPropretyTypeContentSize)] ? param[@(kHSYCocoaKitOfScrollViewPropretyTypeContentSize)] : param[HSYCocoaKitScrollViewContentSize];
    if (valueCGSize) {
        scrollView.contentSize = valueCGSize.CGSizeValue;
    }
    
    NSValue *offsetValue = param[@(kHSYCocoaKitOfScrollViewPropretyTypeContentOffset)] ? param[@(kHSYCocoaKitOfScrollViewPropretyTypeContentOffset)] : param[HSYCocoaKitScrollViewContentOffset];
    if (offsetValue) {
        scrollView.contentOffset = offsetValue.CGPointValue;
    }
    
    NSNumber *pagingEnabled = param[@(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled)] ? param[@(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled)] : param[HSYCocoaKitScrollViewPagingEnabled];
    if (pagingEnabled) {
        scrollView.pagingEnabled = [pagingEnabled boolValue];//整页翻动
    }
    
    NSNumber *scrollEnabled = param[@(kHSYCocoaKitOfScrollViewPropretyTypeScrollEnabled)] ? param[@(kHSYCocoaKitOfScrollViewPropretyTypeScrollEnabled)] : param[HSYCocoaKitScrollViewScrollEnabled];
    if (scrollEnabled) {
        scrollView.scrollEnabled = [scrollEnabled boolValue];//滚动
    }
    
    NSNumber *bounces = param[@(kHSYCocoaKitOfScrollViewPropretyTypeBounces)] ? param[@(kHSYCocoaKitOfScrollViewPropretyTypeBounces)] : param[HSYCocoaKitScrollViewBounces];
    if (bounces) {
        scrollView.bounces = [bounces boolValue];//控制控件遇到边框是否反弹
    }
    
    //隐藏滚动条
    scrollView.showsVerticalScrollIndicator = (param[@(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator)] ? (![param[@(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator)] boolValue]) : TRUE);
    scrollView.showsHorizontalScrollIndicator = (param[@(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator)] ? (![param[@(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator)] boolValue]) : TRUE);
    
    return scrollView;
}

#pragma mark - Create CollectionView

+ (UICollectionView *)createCollectionViewByParam:(NSDictionary<id, id> *)param
{
    CGRect rect = CGRectZero;
    if (param[@(kHSYCocoaKitOfCollectionViewPropretyTypeFrame)]) {
        NSValue *value = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeFrame)];
        rect = value.CGRectValue;
    }
    
    UICollectionViewFlowLayout *flowLayout = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeLayout)] ? param[@(kHSYCocoaKitOfCollectionViewPropretyTypeLayout)] : param[HSYCocoaKitCollectionViewFlowLayout];
    if (!flowLayout) {
        flowLayout = [NSObject createFlowLayoutByParam:@{@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection) : @(UICollectionViewScrollDirectionVertical), @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize) : [NSValue valueWithCGSize:CGSizeMake(IPHONE_WIDTH, 44.0f)], }];
    }
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    
    id<UICollectionViewDelegate>delegate = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeDelegate)] ? param[@(kHSYCocoaKitOfCollectionViewPropretyTypeDelegate)] : param[HSYCocoaKitCollectionViewDelegate];
    if (delegate) {
        collectionView.delegate = delegate;
    }
    
    id<UICollectionViewDataSource>dataSource = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeDataSource)] ? param[@(kHSYCocoaKitOfCollectionViewPropretyTypeDataSource)] : param[HSYCocoaKitCollectionViewDataSource];
    if (dataSource) {
        collectionView.dataSource = dataSource;
    }
    
    NSNumber *scrollEnabled = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeScrollEnabled)] ? param[@(kHSYCocoaKitOfCollectionViewPropretyTypeScrollEnabled)] : param[HSYCocoaKitCollectionViewScrollEnabled];
    if (scrollEnabled) {
        collectionView.scrollEnabled = [scrollEnabled boolValue];
    }
    
    collectionView.backgroundColor = [UIColor clearColor];
    
    NSNumber *hiddenScrollIndicator = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator)] ? param[@(kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator)] : param[HSYCocoaKitCollectionViewHiddenScrollIndicator];
    if (hiddenScrollIndicator) {
        //控制控件遇到边框是否反弹
        collectionView.showsVerticalScrollIndicator = [hiddenScrollIndicator boolValue];
        collectionView.showsHorizontalScrollIndicator = [hiddenScrollIndicator boolValue];
    }
    
    NSNumber *bounces = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeBounces)] ? param[@(kHSYCocoaKitOfCollectionViewPropretyTypeBounces)] : param[HSYCocoaKitCollectionViewBounces];
    if (bounces) {
        collectionView.bounces = [bounces boolValue];//控制控件遇到边框是否反弹
    }
    
    //必须注册cell，此处使用建言宏中断，以方便代码检查
    NSArray<NSDictionary *> *registerClasses = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass)] ? param[@(kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass)] : param[HSYCocoaKitCollectionViewRegisterClass];
    NSParameterAssert(registerClasses);
    for (NSDictionary *registers in registerClasses) {
        Class class = NSClassFromString(registers.allKeys.firstObject);
        NSString *identifier = registers.allValues.firstObject;
        [collectionView registerClass:class forCellWithReuseIdentifier:identifier];
    }
    return collectionView;
}

+ (UICollectionViewFlowLayout *)createFlowLayoutByParam:(NSDictionary<id, id> *)param
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //滚动方向
    NSNumber *scrollDirection = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection)] ? param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection)] : (param[HSYCocoaKitCollectionViewFlowLayoutDirection] ? param[HSYCocoaKitCollectionViewFlowLayoutDirection] : UICollectionViewScrollDirectionVertical);
    flowLayout.scrollDirection = (UICollectionViewScrollDirection)scrollDirection.integerValue;
    
    //设置其边界
    NSValue *insetValue = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset)] ? param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset)] : param[HSYCocoaKitCollectionViewFlowLayoutSectionInset];
    if (insetValue) {
        flowLayout.sectionInset = insetValue.UIEdgeInsetsValue;
    }
    
    //设置每个cell的size
    NSValue *itemValue = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize)] ? param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize)] : param[HSYCocoaKitCollectionViewFlowLayoutItemSize];
    if (itemValue) {
        flowLayout.itemSize = itemValue.CGSizeValue;                                    //设置每个cell的size
    }
    
    NSNumber *minimumLineSpacing = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing)] ? param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing)] : param[HSYCocoaKitCollectionViewFlowLayoutLineSpacing];
    if (minimumLineSpacing) {
        flowLayout.minimumLineSpacing = [minimumLineSpacing floatValue];
    }
    
    NSNumber *minimumInteritemSpacing = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing)] ? param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing)] : param[HSYCocoaKitCollectionViewFlowLayoutInteritemSpacing];
    if (minimumInteritemSpacing) {
        flowLayout.minimumInteritemSpacing = [minimumInteritemSpacing floatValue];
    }
    
    NSValue *headerValue = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeHeaderReferenceSize)] ? param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeHeaderReferenceSize)] : param[HSYCocoaKitCollectionViewFlowLayoutHeaderReferenceSize];
    if (headerValue) {
        flowLayout.headerReferenceSize = headerValue.CGSizeValue;
    }
    
    NSValue *footerValue = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeFooterReferenceSize)] ? param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeFooterReferenceSize)] : param[HSYCocoaKitCollectionViewFlowLayoutFooterReferenceSize];
    if (footerValue) {
        flowLayout.footerReferenceSize = footerValue.CGSizeValue;
    }
    
    return flowLayout;
}

#pragma mark - Create UISlider

+ (UISlider *)createSliderByParam:(NSDictionary<id, id> *)param changedValue:(void(^)(CGFloat news))newValue
{
    UISlider *slider = [[UISlider alloc] init];
    UIImage *norThumbImage = param[@(kHSYCocoaKitOfSliderPropertyTypeNorThumbImage)] ? param[@(kHSYCocoaKitOfSliderPropertyTypeNorThumbImage)] : param[HSYCocoaKitSliderNorThumbImage];
    if (norThumbImage) {
        [slider setThumbImage:norThumbImage forState:UIControlStateNormal];
    }
    
    UIImage *preThumbImage = param[@(kHSYCocoaKitOfSliderPropertyTypePreThumbImage)] ? param[@(kHSYCocoaKitOfSliderPropertyTypePreThumbImage)] : param[HSYCocoaKitSliderPreThumbImage];
    if (param[@(kHSYCocoaKitOfSliderPropertyTypePreThumbImage)]) {
        [slider setThumbImage:preThumbImage forState:UIControlStateHighlighted];
    }
    
    UIColor *minimumTrackTintColor = param[@(kHSYCocoaKitOfSliderPropertyTypeNorMinimumTrackTintColor)] ? param[@(kHSYCocoaKitOfSliderPropertyTypeNorMinimumTrackTintColor)] : param[HSYCocoaKitSliderNorMinimumTrackTintColor];
    if (minimumTrackTintColor) {
        [slider setMinimumTrackTintColor:minimumTrackTintColor];
    }
    
    UIColor *maximumTrackTintColor = param[@(kHSYCocoaKitOfSliderPropertyTypePreMinimumTrackTintColor)] ? param[@(kHSYCocoaKitOfSliderPropertyTypePreMinimumTrackTintColor)] : param[HSYCocoaKitSliderPreMinimumTrackTintColor];
    if (maximumTrackTintColor) {
        [slider setMaximumTrackTintColor:maximumTrackTintColor];
    }
    
    NSNumber *maximumValue = param[@(kHSYCocoaKitOfSliderPropertyTypeMaximumValue)] ? param[@(kHSYCocoaKitOfSliderPropertyTypeMaximumValue)] : param[HSYCocoaKitSliderMaximumValue];
    if (maximumValue) {
        slider.maximumValue = [maximumValue floatValue];
    }
    
    NSNumber *minimumValue = param[@(kHSYCocoaKitOfSliderPropertyTypeMinimumValue)] ? param[@(kHSYCocoaKitOfSliderPropertyTypeMinimumValue)] : param[HSYCocoaKitSliderMinimumValue];
    if (minimumValue) {
        slider.minimumValue = [minimumValue floatValue];
    }
    
    NSNumber *values = param[@(kHSYCocoaKitOfSliderPropertyTypeValue)] ? param[@(kHSYCocoaKitOfSliderPropertyTypeValue)] : param[HSYCocoaKitSliderValue];
    if (values) {
        slider.value = [values floatValue];
    }
    
    [[[slider rac_signalForControlEvents:UIControlEventValueChanged] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UISlider *x) {
        if (newValue) {
            newValue(x.value);
        }
    }];
    return slider;
}

@end

