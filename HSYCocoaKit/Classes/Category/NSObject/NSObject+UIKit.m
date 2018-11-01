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

+ (UIButton *)createButtonByParam:(NSDictionary <NSNumber *, id>*)param clickedOnSubscribeNext:(void(^)(UIButton *button))next
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = CLEAR_COLOR;
    button.clipsToBounds = YES;
    button.layer.masksToBounds = YES;
    
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName)]) {
        [button setBackgroundImage:param[@(kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName)] forState:UIControlStateNormal];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypePreBackgroundImageViewName)]) {
        [button setBackgroundImage:param[@(kHSYCocoaKitOfButtonPropretyTypePreBackgroundImageViewName)] forState:UIControlStateHighlighted];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeNorTitle)]) {
        [button setTitle:param[@(kHSYCocoaKitOfButtonPropretyTypeNorTitle)] forState:UIControlStateNormal];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeHighTitle)]) {
        [button setTitle:param[@(kHSYCocoaKitOfButtonPropretyTypeHighTitle)] forState:UIControlStateHighlighted];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeNorImageViewName)]) {
        [button setImage:param[@(kHSYCocoaKitOfButtonPropretyTypeNorImageViewName)] forState:UIControlStateNormal];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypePreImageViewName)]) {
        [button setImage:param[@(kHSYCocoaKitOfButtonPropretyTypePreImageViewName)] forState:UIControlStateHighlighted];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeSelectedImageViewName)]) {
        [button setImage:param[@(kHSYCocoaKitOfButtonPropretyTypeSelectedImageViewName)] forState:UIControlStateSelected];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeTitleColor)]) {
        [button setTitleColor:param[@(kHSYCocoaKitOfButtonPropretyTypeTitleColor)] forState:UIControlStateNormal];
        [button setTitleColor:param[@(kHSYCocoaKitOfButtonPropretyTypeTitleColor)] forState:UIControlStateHighlighted];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeTitleFont)]) {
        UIFont *font = param[@(kHSYCocoaKitOfButtonPropretyTypeTitleFont)];
        button.titleLabel.font = font;
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeCornerRadius)]) {
        button.layer.cornerRadius = [param[@(kHSYCocoaKitOfButtonPropretyTypeCornerRadius)] floatValue];
    }
    if (param[@(kHSYCocoaKitOfButtonPropretyTypeTextAlignment)]) {
        button.contentHorizontalAlignment = (UIControlContentHorizontalAlignment)[param[@(kHSYCocoaKitOfButtonPropretyTypeTextAlignment)] integerValue];
    }
    
    [[[button rac_signalForControlEvents:UIControlEventTouchUpInside] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UIButton *btn) {
        if (next) {
            next(btn);
        }
    }];
    
    return button;
}

#pragma mark - Create ImageView

+ (UIImageView *)createImageViewByParam:(NSDictionary <NSNumber *, id>*)param
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.backgroundColor = CLEAR_COLOR;
    imageView.clipsToBounds = YES;
    imageView.layer.masksToBounds = YES;
    if (param[@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName)]) {
        imageView.image = param[@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName)];
    }
    if (param[@(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName)]) {
        imageView.highlightedImage = param[@(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName)];
    }
    UIViewContentMode mode = (param[@(kHSYCocoaKitOfImageViewPropretyTypeViewContentMode)] ? ((UIViewContentMode)[param[@(kHSYCocoaKitOfImageViewPropretyTypeViewContentMode)] integerValue]) : UIViewContentModeScaleToFill);
    imageView.contentMode = mode;
    
    return imageView;
}

#pragma mark - Create Label

+ (UILabel *)createLabelByParam:(NSDictionary <NSNumber *, id>*)param
{
    UILabel *label = nil;
    
    NSString *text = (param[@(kHSYCocoaKitOfLabelPropretyTypeText)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeText)] : @"");
    UIFont *font = (param[@(kHSYCocoaKitOfLabelPropretyTypeTextFont)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeTextFont)] : UI_SYSTEM_FONT_16);
    CGRect rect = CGRectZero;
    if (param[@(kHSYCocoaKitOfLabelPropretyTypeFrame)]) {
        NSValue *rectValue = param[@(kHSYCocoaKitOfLabelPropretyTypeFrame)];
        rect = rectValue.CGRectValue;
    }
    if (param[@(kHSYCocoaKitOfLabelPropretyTypeMaxSize)]) {
        NSValue *sizeValue = param[@(kHSYCocoaKitOfLabelPropretyTypeMaxSize)];
        CGFloat width = sizeValue.CGSizeValue.width;
        CGFloat height = sizeValue.CGSizeValue.height;
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
    label.backgroundColor = (param[@(kHSYCocoaKitOfLabelPropretyTypeBackgroundColor)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeBackgroundColor)] : CLEAR_COLOR);
    label.textColor = (param[@(kHSYCocoaKitOfLabelPropretyTypeTextColor)] ? param[@(kHSYCocoaKitOfLabelPropretyTypeTextColor)] : BLACK_COLOR);
    label.textAlignment = (param[@(kHSYCocoaKitOfLabelPropretyTypeTextAlignment)] ? ((NSTextAlignment)[param[@(kHSYCocoaKitOfLabelPropretyTypeTextAlignment)] integerValue]) : NSTextAlignmentLeft);
    
    return label;
}

#pragma mark - Create TextFiled

+ (UITextField *)createTextFiledByParam:(NSDictionary <NSNumber *, id>*)param
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderWidth)]) {
        textField.layer.borderWidth = [param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderWidth)] floatValue];
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderColor)]) {
        textField.layer.borderColor = [param[@(kHSYCocoaKitOfTextFiledPropretyTypeBorderColor)] CGColor];
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeTextAlignment)]) {
        textField.textAlignment = ((NSTextAlignment)[param[@(kHSYCocoaKitOfLabelPropretyTypeTextAlignment)] integerValue]);
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeFont)]) {
        textField.font = param[@(kHSYCocoaKitOfTextFiledPropretyTypeFont)];
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeReturnKeyType)]) {
        textField.returnKeyType = (UIReturnKeyType)[param[@(kHSYCocoaKitOfTextFiledPropretyTypeReturnKeyType)] integerValue];
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeKeyboardType)]) {
        textField.keyboardType = (UIKeyboardType)[param[@(kHSYCocoaKitOfTextFiledPropretyTypeKeyboardType)] integerValue];
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeTextColor)]) {
        textField.textColor = param[@(kHSYCocoaKitOfTextFiledPropretyTypeTextColor)];
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeBackgroundColor)]) {
        textField.backgroundColor = param[@(kHSYCocoaKitOfTextFiledPropretyTypeBackgroundColor)];
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypeText)]) {
        textField.text = param[@(kHSYCocoaKitOfTextFiledPropretyTypeText)];
    }
    if (param[@(kHSYCocoaKitOfTextFiledPropretyTypePlaceholderString)]) {
        textField.placeholder = param[@(kHSYCocoaKitOfTextFiledPropretyTypePlaceholderString)];
    }
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    return textField;
}

+ (UITextField *)createTextFiledByParam:(NSDictionary <NSNumber *, id>*)param didChangeSubscribeNext:(void(^)(NSString *text))next
{
    UITextField *textField = [self.class createTextFiledByParam:param];
    if (next) {
        [[[textField rac_textSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSString *text) {
            next(text);
        }];
    }
    return textField;
}

#pragma mark - Create TextView

+ (UITextView *)createTextViewByParam:(NSDictionary <NSNumber *, id>*)param
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeBorderWidth)]) {
        textView.layer.borderWidth = [param[@(kHSYCocoaKitOfTextViewPropretyTypeBorderWidth)] floatValue];
    }
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeBorderColor)]) {
        textView.layer.borderColor = [param[@(kHSYCocoaKitOfTextViewPropretyTypeBorderColor)] CGColor];
    }
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeTextAlignment)]) {
        textView.textAlignment = ((NSTextAlignment)[param[@(kHSYCocoaKitOfTextViewPropretyTypeTextAlignment)] integerValue]);
    }
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeFont)]) {
        textView.font = param[@(kHSYCocoaKitOfTextViewPropretyTypeFont)];
    }
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeReturnKeyType)]) {
        textView.returnKeyType = (UIReturnKeyType)[param[@(kHSYCocoaKitOfTextViewPropretyTypeReturnKeyType)] integerValue];
    }
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeKeyboardType)]) {
        textView.keyboardType = (UIKeyboardType)[param[@(kHSYCocoaKitOfTextViewPropretyTypeKeyboardType)] integerValue];
    }
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeTextColor)]) {
        textView.textColor = param[@(kHSYCocoaKitOfTextViewPropretyTypeTextColor)];
    }
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeBackgroundColor)]) {
        textView.backgroundColor = param[@(kHSYCocoaKitOfTextViewPropretyTypeBackgroundColor)];
    }
    if (param[@(kHSYCocoaKitOfTextViewPropretyTypeText)]) {
        textView.text = param[@(kHSYCocoaKitOfTextViewPropretyTypeText)];
    }
    if ([param[@(kHSYCocoaKitOfTextViewPropretyTypePlaceholder)] length] > 0) {
        textView.placeholder = param[@(kHSYCocoaKitOfTextViewPropretyTypePlaceholder)];
    }
    return textView;
}

+ (UITextView *)createTextViewByParam:(NSDictionary <NSNumber *, id>*)param didChangeSubscribeNext:(void(^)(NSString *text))next
{
    UITextView *textView = [self.class createTextViewByParam:param];
    if (next) {
        [[[textView rac_textSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSString *text) {
            next(text);
        }];
    }

    return textView;
}

#pragma mark - Create TableView

+ (UITableView *)createTabelViewByParam:(NSDictionary <NSNumber *, id>*)param
{
    UITableViewStyle style = (param[@(kHSYCocoaKitOfTableViewPropretyTypeTableViewStyle)] ? ((UITableViewStyle)[param[@(kHSYCocoaKitOfTableViewPropretyTypeTableViewStyle)] integerValue]) : UITableViewStylePlain);
    
    CGRect rect = CGRectZero;
    if (param[@(kHSYCocoaKitOfTableViewPropretyTypeFrame)]) {
        NSValue *value = param[@(kHSYCocoaKitOfTableViewPropretyTypeFrame)];
        rect = value.CGRectValue;
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:style];
    tableView.backgroundColor = [UIColor clearColor];
    if (param[@(kHSYCocoaKitOfTableViewPropretyTypeDelegate)]) {
        id<UITableViewDelegate>delegate = param[@(kHSYCocoaKitOfTableViewPropretyTypeDelegate)];
        tableView.delegate = delegate;
    }
    if (param[@(kHSYCocoaKitOfTableViewPropretyTypeDataSource)]) {
        id<UITableViewDataSource>dataSource = param[@(kHSYCocoaKitOfTableViewPropretyTypeDataSource)];
        tableView.dataSource = dataSource;
    }
    
    tableView.clipsToBounds = YES;
    tableView.scrollEnabled = (param[@(kHSYCocoaKitOfTableViewPropretyTypeScrollEnabled)] ? [param[@(kHSYCocoaKitOfTableViewPropretyTypeScrollEnabled)] boolValue] : YES);
    if ([param[@(kHSYCocoaKitOfTableViewPropretyTypeHiddenCellLine)] boolValue]) {
        //去掉单元格的分割线
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    if (param[@(kHSYCocoaKitOfTableViewPropretyTypeTableFooterView)]) {
        tableView.tableFooterView = param[@(kHSYCocoaKitOfTableViewPropretyTypeTableFooterView)];
    }
    if (param[@(kHSYCocoaKitOfTableViewPropretyTypeRegisterClass)]) {
        NSDictionary *registers = param[@(kHSYCocoaKitOfTableViewPropretyTypeRegisterClass)];
        Class class = NSClassFromString(registers.allKeys.firstObject);
        NSString *identifier = registers.allValues.firstObject;
        [tableView registerClass:class forCellReuseIdentifier:identifier];
    }
    
    return tableView;
}

#pragma mark - Create ScrollView

+ (UIScrollView *)createScrollViewByParam:(NSDictionary <NSNumber *, id>*)param
{
    CGRect rect = CGRectZero;
    if (param[@(kHSYCocoaKitOfScrollViewPropretyTypeFrame)]) {
        NSValue *value = param[@(kHSYCocoaKitOfScrollViewPropretyTypeFrame)];
        rect = value.CGRectValue;
    }
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    if (param[@(kHSYCocoaKitOfScrollViewPropretyTypeDelegate)]) {
        id<UIScrollViewDelegate>delegate = param[@(kHSYCocoaKitOfScrollViewPropretyTypeDelegate)];
        scrollView.delegate = delegate;
    }
    if (param[@(kHSYCocoaKitOfScrollViewPropretyTypeContentSize)]) {
        NSValue *sizeValue = param[@(kHSYCocoaKitOfScrollViewPropretyTypeContentSize)];
        scrollView.contentSize = sizeValue.CGSizeValue;
    }
    if (param[@(kHSYCocoaKitOfScrollViewPropretyTypeContentOffset)]) {
        NSValue *offsetValue = param[@(kHSYCocoaKitOfScrollViewPropretyTypeContentOffset)];
        scrollView.contentOffset = offsetValue.CGPointValue;
    }
    if (param[@(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled)]) {
        scrollView.pagingEnabled = [param[@(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled)] boolValue];//整页翻动
    }
    if (param[@(kHSYCocoaKitOfScrollViewPropretyTypeScrollEnabled)]) {
        scrollView.scrollEnabled = [param[@(kHSYCocoaKitOfScrollViewPropretyTypeScrollEnabled)] boolValue];//滚动
    }
    if (param[@(kHSYCocoaKitOfScrollViewPropretyTypeBounces)]) {
        scrollView.bounces = [param[@(kHSYCocoaKitOfScrollViewPropretyTypeBounces)] boolValue];//控制控件遇到边框是否反弹
    }
    
    //隐藏滚动条
    scrollView.showsVerticalScrollIndicator = (param[@(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator)] ? (![param[@(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator)] boolValue]) : TRUE);
    scrollView.showsHorizontalScrollIndicator = (param[@(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator)] ? (![param[@(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator)] boolValue]) : TRUE);
    
    return scrollView;
}

#pragma mark - Create CollectionView

+ (UICollectionView *)createCollectionViewByParam:(NSDictionary <NSNumber *, id>*)param
{
    CGRect rect = CGRectZero;
    if (param[@(kHSYCocoaKitOfCollectionViewPropretyTypeFrame)]) {
        NSValue *value = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeFrame)];
        rect = value.CGRectValue;
    }
    UICollectionViewFlowLayout *flowLayout = nil;
    if (param[@(kHSYCocoaKitOfCollectionViewPropretyTypeLayout)]) {
        flowLayout = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeLayout)];
    } else {
        flowLayout = [NSObject createFlowLayoutByParam:@{
                                                         @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection) : @(UICollectionViewScrollDirectionVertical),
                                                         @(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize) : [NSValue valueWithCGSize:CGSizeMake(IPHONE_WIDTH, 44.0f)],
                                                         
                                                         }];
    }
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    if (param[@(kHSYCocoaKitOfCollectionViewPropretyTypeDelegate)]) {
        id<UICollectionViewDelegate>delegate = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeDelegate)];
        collectionView.delegate = delegate;
    }
    if (param[@(kHSYCocoaKitOfCollectionViewPropretyTypeDataSource)]) {
        id<UICollectionViewDataSource>dataSource = param[@(kHSYCocoaKitOfCollectionViewPropretyTypeDataSource)];
        collectionView.dataSource = dataSource;
    }
    if (param[@(kHSYCocoaKitOfCollectionViewPropretyTypeScrollEnabled)]) {
        collectionView.scrollEnabled = [param[@(kHSYCocoaKitOfCollectionViewPropretyTypeScrollEnabled)] boolValue];
    }
    collectionView.backgroundColor = [UIColor clearColor];
    if (param[@(kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator)]) {
        //控制控件遇到边框是否反弹
        collectionView.showsVerticalScrollIndicator = [param[@(kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator)] boolValue];
        collectionView.showsHorizontalScrollIndicator = [param[@(kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator)] boolValue];
    }
    if (param[@(kHSYCocoaKitOfCollectionViewPropretyTypeBounces)]) {
        collectionView.bounces = [param[@(kHSYCocoaKitOfCollectionViewPropretyTypeBounces)] boolValue];//控制控件遇到边框是否反弹
    }
    //必须注册cell，此处使用建言宏中断，以方便代码检查
    NSParameterAssert(param[@(kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass)]);
    for (NSDictionary *registers in param[@(kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass)]) {
        Class class = NSClassFromString(registers.allKeys.firstObject);
        NSString *identifier = registers.allValues.firstObject;
        [collectionView registerClass:class forCellWithReuseIdentifier:identifier];
    }
    return collectionView;
}

+ (UICollectionViewFlowLayout *)createFlowLayoutByParam:(NSDictionary <NSNumber *, id>*)param
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = (param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection)] ? (UICollectionViewScrollDirection)[param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection)] integerValue] : UICollectionViewScrollDirectionVertical);                       //滚动方向
    if (param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset)]) {
        NSValue *insetValue = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset)];
        flowLayout.sectionInset = insetValue.UIEdgeInsetsValue;                         //设置其边界
    }
    if (param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize)]) {
        NSValue *itemValue = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize)];
        flowLayout.itemSize = itemValue.CGSizeValue;                                    //设置每个cell的size
    }
    if (param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing)]) {
        flowLayout.minimumLineSpacing = [param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing)] floatValue];
    }
    if (param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing)]) {
        flowLayout.minimumInteritemSpacing = [param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing)] floatValue];
    }
    if (param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeHeaderReferenceSize)]) {
        NSValue *headerValue = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeHeaderReferenceSize)];
        flowLayout.headerReferenceSize = headerValue.CGSizeValue;
    }
    if (param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeFooterReferenceSize)]) {
        NSValue *footerValue = param[@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeFooterReferenceSize)];
        flowLayout.footerReferenceSize = footerValue.CGSizeValue;
    }
    
    return flowLayout;
}

#pragma mark - Create UISlider

+ (UISlider *)createSliderByParam:(NSDictionary <NSNumber *, id>*)param changedValue:(void(^)(CGFloat news))newValue
{
    UISlider *slider = [[UISlider alloc] init];
    if (param[@(kHSYCocoaKitOfSliderPropertyTypeNorThumbImage)]) {
        [slider setThumbImage:param[@(kHSYCocoaKitOfSliderPropertyTypeNorThumbImage)] forState:UIControlStateNormal];
    }
    if (param[@(kHSYCocoaKitOfSliderPropertyTypePreThumbImage)]) {
        [slider setThumbImage:param[@(kHSYCocoaKitOfSliderPropertyTypePreThumbImage)] forState:UIControlStateHighlighted];
    }
    if (param[@(kHSYCocoaKitOfSliderPropertyTypeNorMinimumTrackTintColor)]) {
        [slider setMinimumTrackTintColor:param[@(kHSYCocoaKitOfSliderPropertyTypeNorMinimumTrackTintColor)]];
    }
    if (param[@(kHSYCocoaKitOfSliderPropertyTypePreMinimumTrackTintColor)]) {
        [slider setMaximumTrackTintColor:param[@(kHSYCocoaKitOfSliderPropertyTypePreMinimumTrackTintColor)]];
    }
    if (param[@(kHSYCocoaKitOfSliderPropertyTypeMaximumValue)]) {
        slider.maximumValue = [param[@(kHSYCocoaKitOfSliderPropertyTypeMaximumValue)] floatValue];
    }
    if (param[@(kHSYCocoaKitOfSliderPropertyTypeMinimumValue)]) {
        slider.minimumValue = [param[@(kHSYCocoaKitOfSliderPropertyTypeMinimumValue)] floatValue];
    }
    if (param[@(kHSYCocoaKitOfSliderPropertyTypeValue)]) {
        slider.value = [param[@(kHSYCocoaKitOfSliderPropertyTypeValue)] floatValue];
    }
    [[[slider rac_signalForControlEvents:UIControlEventValueChanged] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UISlider *x) {
        if (newValue) {
            newValue(x.value);
        }
    }];
    return slider;
}

@end

