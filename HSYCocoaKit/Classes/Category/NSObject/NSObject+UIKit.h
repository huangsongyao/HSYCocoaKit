//
//  NSObject+UIKit.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

typedef NSString *HSYCocoaKitUIKitButtonPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonNorBackgroundImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonPreBackgroundImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonNorTitle;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonHighTitle;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonNorImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonHighImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonSelectedImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonTitleColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonTitleFont;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonCornerRadius;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonTextAlignment;
FOUNDATION_EXPORT HSYCocoaKitUIKitButtonPropertyKey const HSYCocoaKitButtonSkipFirst;

//UIButton
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfButtonPropretyType) {
    
    kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName      = 657,  //UIImage
    kHSYCocoaKitOfButtonPropretyTypePreBackgroundImageViewName,             //UIImage
    kHSYCocoaKitOfButtonPropretyTypeNorTitle,                               //NSString
    kHSYCocoaKitOfButtonPropretyTypeHighTitle,                              //NSString
    kHSYCocoaKitOfButtonPropretyTypeNorImageViewName,                       //UIImage
    kHSYCocoaKitOfButtonPropretyTypePreImageViewName,                       //UIImage
    kHSYCocoaKitOfButtonPropretyTypeSelectedImageViewName,                  //UIImage
    kHSYCocoaKitOfButtonPropretyTypeTitleColor,                             //UIColor
    kHSYCocoaKitOfButtonPropretyTypeTitleFont,                              //UIFont
    kHSYCocoaKitOfButtonPropretyTypeCornerRadius,                           //NSNumber\CGFloat
    kHSYCocoaKitOfButtonPropretyTypeTextAlignment,                          //NSNumber\(UIControlContentHorizontalAlignment)
    kHSYCocoaKitOfButtonPropretyTypeSkipFirst,                              //NSNumber
    
};

typedef NSString *HSYCocoaKitUIKitImagePropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitImagePropertyKey const HSYCocoaKitImageNorImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitImagePropertyKey const HSYCocoaKitImagePreImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitImagePropertyKey const HSYCocoaKitImageContentMode;

//UIImageView
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfImageViewPropretyType) {
    
    kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName             = 877,  //UIImage
    kHSYCocoaKitOfImageViewPropretyTypePreImageViewName,                    //UIImage
    kHSYCocoaKitOfImageViewPropretyTypeViewContentMode,                     //NSNumber\(UIViewContentMode)
};

typedef NSString *HSYCocoaKitUIKitLabelPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelText;
FOUNDATION_EXPORT HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelTextColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelFont;
FOUNDATION_EXPORT HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelBackgroundColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelTextAlignment;
FOUNDATION_EXPORT HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelUnline;
FOUNDATION_EXPORT HSYCocoaKitUIKitLabelPropertyKey const HSYCocoaKitLabelComputeSize;

//UILabel
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfLabelPropretyType) {
    
    kHSYCocoaKitOfLabelPropretyTypeText                             = 762,  //NSString
    kHSYCocoaKitOfLabelPropretyTypeTextColor,                               //UIColor
    kHSYCocoaKitOfLabelPropretyTypeTextFont,                                //UIFont
    kHSYCocoaKitOfLabelPropretyTypeBackgroundColor,                         //UIColor
    kHSYCocoaKitOfLabelPropretyTypeTextAlignment,                           //NSNumber\(NSTextAlignment)
    kHSYCocoaKitOfLabelPropretyTypeIsUniline,                               //NSNumber\BOOL
    kHSYCocoaKitOfLabelPropretyTypeFrame,                                   //NSValue\(CGRect)
    kHSYCocoaKitOfLabelPropretyTypeMaxSize,                                 //NSValue\(CGSize)
    
};

typedef NSString *HSYCocoaKitUIKitTextFieldPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledBorderWidth;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledBorderColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledTextAlignment;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledFont;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledReturnKeyType;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledKeyboardType;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledTextColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledBackgroundColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledText;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledPlaceholder;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextFieldPropertyKey const HSYCocoaKitTextFiledSkipFirst;

//UITextField
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfTextFiledPropretyType) {
    
    kHSYCocoaKitOfTextFiledPropretyTypeBorderWidth                  = 521,  //NSNumber\(CGFloat)
    kHSYCocoaKitOfTextFiledPropretyTypeBorderColor,                         //UIColor
    kHSYCocoaKitOfTextFiledPropretyTypeTextAlignment,                       //NSNumber\(NSTextAlignment)
    kHSYCocoaKitOfTextFiledPropretyTypeFont,                                //UIFont
    kHSYCocoaKitOfTextFiledPropretyTypeReturnKeyType,                       //NSNumber\(UIReturnKeyType)
    kHSYCocoaKitOfTextFiledPropretyTypeKeyboardType,                        //NSNumber\(UIKeyboardType)
    kHSYCocoaKitOfTextFiledPropretyTypeTextColor,                           //UIColor
    kHSYCocoaKitOfTextFiledPropretyTypeBackgroundColor,                     //UIColor
    kHSYCocoaKitOfTextFiledPropretyTypeText,                                //NSString
    kHSYCocoaKitOfTextFiledPropretyTypePlaceholderString,                   //NSString
    kHSYCocoaKitOfTextFiledPropretyTypeSkipFirst,                           //NSNumber
    
};

typedef NSString *HSYCocoaKitUIKitTextViewPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewBorderWidth;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewBorderColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewTextAlignment;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewFont;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewReturnKeyType;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewKeyboardType;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewTextColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewBackgroundColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewText;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewPlaceholder;
FOUNDATION_EXPORT HSYCocoaKitUIKitTextViewPropertyKey const HSYCocoaKitTextViewSkipFirst;

//UITextView
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfTextViewPropretyType) {
    
    kHSYCocoaKitOfTextViewPropretyTypeBorderWidth                   = 408,  //NSNumber\(CGFloat)
    kHSYCocoaKitOfTextViewPropretyTypeBorderColor,                          //UIColor
    kHSYCocoaKitOfTextViewPropretyTypeTextAlignment,                        //NSNumber\(NSTextAlignment)
    kHSYCocoaKitOfTextViewPropretyTypeFont,                                 //UIFont
    kHSYCocoaKitOfTextViewPropretyTypeReturnKeyType,                        //NSNumber\(UIReturnKeyType)
    kHSYCocoaKitOfTextViewPropretyTypeKeyboardType,                         //NSNumber\(UIKeyboardType)
    kHSYCocoaKitOfTextViewPropretyTypeTextColor,                            //UIColor
    kHSYCocoaKitOfTextViewPropretyTypeBackgroundColor,                      //UIColor
    kHSYCocoaKitOfTextViewPropretyTypeText,                                 //NSString
    kHSYCocoaKitOfTextViewPropretyTypePlaceholder,                          //NSString
    kHSYCocoaKitOfTextViewPropretyTypeSkipFirst,                            //NSNumber
    
};

typedef NSString *HSYCocoaKitUIKitTableViewPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewStyle;
FOUNDATION_EXPORT HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewDelegate;
FOUNDATION_EXPORT HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewDataSource;
FOUNDATION_EXPORT HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewScrollEnabled;
FOUNDATION_EXPORT HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewHiddenLine;
FOUNDATION_EXPORT HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewFooterView;
FOUNDATION_EXPORT HSYCocoaKitUIKitTableViewPropertyKey const HSYCocoaKitTableViewRegisterClass;

//UITableView
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfTableViewPropretyType) {
    
    kHSYCocoaKitOfTableViewPropretyTypeTableViewStyle               = 358,  //NSNumber\(UITableViewStyle)
    kHSYCocoaKitOfTableViewPropretyTypeFrame,                               //NSValue\(CGRect)
    kHSYCocoaKitOfTableViewPropretyTypeDelegate,                            //id\(<UITableViewDelegate>)
    kHSYCocoaKitOfTableViewPropretyTypeDataSource,                          //id\(UITableViewDataSource)
    kHSYCocoaKitOfTableViewPropretyTypeScrollEnabled,                       //NSNumber\(BOOL)
    kHSYCocoaKitOfTableViewPropretyTypeHiddenCellLine,                      //NSNumber\(BOOL)
    kHSYCocoaKitOfTableViewPropretyTypeTableFooterView,                     //id\(UIView)
    kHSYCocoaKitOfTableViewPropretyTypeRegisterClass,                       //NSDictionary\(@{@"Class Name" : @"Identifier"})
};

typedef NSString *HSYCocoaKitUIKitScrollViewPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewDelegate;
FOUNDATION_EXPORT HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewContentSize;
FOUNDATION_EXPORT HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewContentOffset;
FOUNDATION_EXPORT HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewPagingEnabled;
FOUNDATION_EXPORT HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewScrollEnabled;
FOUNDATION_EXPORT HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewBounces;
FOUNDATION_EXPORT HSYCocoaKitUIKitScrollViewPropertyKey const HSYCocoaKitScrollViewHiddenScrollIndicator;

//UIScrollView
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfScrollViewPropretyType) {
    
    kHSYCocoaKitOfScrollViewPropretyTypeFrame                       = 233,  //NSValue\(CGRect)
    kHSYCocoaKitOfScrollViewPropretyTypeDelegate,                           //id\(UIScrollViewDelegate)
    kHSYCocoaKitOfScrollViewPropretyTypeContentSize,                        //NSValue\(CGRect)
    kHSYCocoaKitOfScrollViewPropretyTypeContentOffset,                      //NSValue\(CGRect)
    kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled,                      //NSNumber\(BOOL)
    kHSYCocoaKitOfScrollViewPropretyTypeScrollEnabled,                      //NSNumber\(BOOL)
    kHSYCocoaKitOfScrollViewPropretyTypeBounces,                            //NSNumber\(BOOL)
    kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator,              //NSNumber\(BOOL)
    
};

typedef NSString *HSYCocoaKitUIKitCollectionViewPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewFlowLayout;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewDelegate;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewDataSource;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewScrollEnabled;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewBounces;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewHiddenScrollIndicator;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewPropertyKey const HSYCocoaKitCollectionViewRegisterClass;

//UICollectionView
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfCollectionViewPropretyType) {
    
    kHSYCocoaKitOfCollectionViewPropretyTypeFrame                   = 135,  //NSValue\(CGRect)
    kHSYCocoaKitOfCollectionViewPropretyTypeLayout,                         //UICollectionViewFlowLayout
    kHSYCocoaKitOfCollectionViewPropretyTypeDataSource,                     //id\(<UITableViewDelegate>)
    kHSYCocoaKitOfCollectionViewPropretyTypeDelegate,                       //id\(<UITableViewDelegate>)
    kHSYCocoaKitOfCollectionViewPropretyTypeScrollEnabled,                  //NSNumber\(BOOL)
    kHSYCocoaKitOfCollectionViewPropretyTypeBounces,                        //NSNumber\(BOOL)
    kHSYCocoaKitOfCollectionViewPropretyTypeHiddenScrollIndicator,          //NSNumber\(BOOL)
    kHSYCocoaKitOfCollectionViewPropretyTypeRegisterClass,                  //NSArray\NSDictionary\(@{@"Class Name" : @"Identifier"})
};

typedef NSString *HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutDirection;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutSectionInset;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutItemSize;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutLineSpacing;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutInteritemSpacing;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutHeaderReferenceSize;
FOUNDATION_EXPORT HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey const HSYCocoaKitCollectionViewFlowLayoutFooterReferenceSize;

//UICollectionViewFlowLayout
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfCollectionViewFlowLayoutPropretyType) {
    
    kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeDirection     = 36,   //NSNumber\(UICollectionViewScrollDirection)
    kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeSectionInset,         //NSValue\(UIEdgeInsets)
    kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeItemSize,             //NSValue\(CGSize)
    kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeLineSpacing,          //NSNumber
    kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeInteritemSpacing,     //NSNumber
    kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeHeaderReferenceSize,  //NSValue\(CGSize)
    kHSYCocoaKitOfCollectionViewFlowLayoutPropretyTypeFooterReferenceSize,  //NSValue\(CGSize)
    
};

typedef NSString *HSYCocoaKitUIKitSliderPropertyKey;
FOUNDATION_EXPORT HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderNorThumbImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderPreThumbImage;
FOUNDATION_EXPORT HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderNorMinimumTrackTintColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderPreMinimumTrackTintColor;
FOUNDATION_EXPORT HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderMaximumValue;
FOUNDATION_EXPORT HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderMinimumValue;
FOUNDATION_EXPORT HSYCocoaKitUIKitSliderPropertyKey const HSYCocoaKitSliderValue;

//UISlider
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfSliderPropertyType) {
    
    kHSYCocoaKitOfSliderPropertyTypeNorThumbImage                   = 21,   //UIImage
    kHSYCocoaKitOfSliderPropertyTypePreThumbImage,                          //UIImage
    kHSYCocoaKitOfSliderPropertyTypeNorMinimumTrackTintColor,               //UIColor
    kHSYCocoaKitOfSliderPropertyTypePreMinimumTrackTintColor,               //UIColor
    kHSYCocoaKitOfSliderPropertyTypeMaximumValue,                           //NSNumber\(CGFloat)
    kHSYCocoaKitOfSliderPropertyTypeMinimumValue,                           //NSNumber\(CGFloat)
    kHSYCocoaKitOfSliderPropertyTypeValue,                                  //NSNumber\(CGFloat)
    
};

@interface NSObject (UIKit)

/**
 UIButton-------key:@(kHSYCocoaKitOfButtonPropretyType枚举) --或HSYCocoaKitUIKitButtonPropertyKey

 @param param 入参属性
 @param next 点击回调时间
 @return UIButton
 */
+ (UIButton *)createButtonByParam:(NSDictionary<id, id> *)param clickedOnSubscribeNext:(void(^)(UIButton *button))next;

/**
 UIImageView-------key:@(kHSYCocoaKitOfImageViewPropretyType枚举) --或HSYCocoaKitUIKitImagePropertyKey

 @param param 入参属性
 @return UIImageView
 */
+ (UIImageView *)createImageViewByParam:(NSDictionary<id, id> *)param;

/**
 UILabel-------key:@(kHSYCocoaKitOfLabelPropretyType枚举) --或HSYCocoaKitUIKitLabelPropertyKey

 @param param 入参属性
 @return UILabel
 */
+ (UILabel *)createLabelByParam:(NSDictionary<id, id> *)param;

/**
 UITextField------key:@(kHSYCocoaKitOfTextFiledPropretyType枚举) --或HSYCocoaKitUIKitTextFieldPropertyKey

 @param param 入参属性
 @param next 单行输入框内容改变
 @return UITextField
 */
+ (UITextField *)createTextFiledByParam:(NSDictionary<id, id> *)param didChangeSubscribeNext:(void(^)(NSString *text))next;
+ (UITextField *)createTextFiledByParam:(NSDictionary<id, id> *)param;

/**
 UITextView------key:@(kHSYCocoaKitOfTextViewPropretyType枚举) --或HSYCocoaKitUIKitTextViewPropertyKey

 @param param 入参属性
 @param next 多行输入框内容改变
 @return UITextView
 */
+ (UITextView *)createTextViewByParam:(NSDictionary<id, id> *)param didChangeSubscribeNext:(void(^)(NSString *text))next;
+ (UITextView *)createTextViewByParam:(NSDictionary<id, id> *)param;

/**
 UITableView-------key:@(kHSYCocoaKitOfTableViewPropretyType枚举) --或HSYCocoaKitUIKitTableViewPropertyKey

 @param param 入参属性
 @return UITableView
 */
+ (UITableView *)createTabelViewByParam:(NSDictionary<id, id> *)param;

/**
 UIScrollView-----key:@(kHSYCocoaKitOfScrollViewPropretyType枚举) --或HSYCocoaKitUIKitScrollViewPropertyKey

 @param param 入参属性
 @return UIScrollView
 */
+ (UIScrollView *)createScrollViewByParam:(NSDictionary<id, id> *)param;

/**
 UICollectionView------key:@(kHSYCocoaKitOfCollectionViewPropretyType枚举) --或HSYCocoaKitUIKitCollectionViewPropertyKey

 @param param 入参属性
 @return UICollectionView
 */
+ (UICollectionView *)createCollectionViewByParam:(NSDictionary<id, id> *)param;

/**
 UICollectionViewFlowLayout------key:@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyType枚举) --或HSYCocoaKitUIKitCollectionViewFlowLayoutPropertyKey

 @param param 入参属性
 @return UICollectionViewFlowLayout
 */
+ (UICollectionViewFlowLayout *)createFlowLayoutByParam:(NSDictionary<id, id> *)param;

/**
 UISlider--------key:@(kHSYCocoaKitOfSliderPropertyType) --或HSYCocoaKitUIKitSliderPropertyKey

 @param param 入参属性
 @param newValue 触发changed后改变的值的回调事件
 @return UISlider
 */
+ (UISlider *)createSliderByParam:(NSDictionary<id, id> *)param changedValue:(void(^)(CGFloat news))newValue;

@end
