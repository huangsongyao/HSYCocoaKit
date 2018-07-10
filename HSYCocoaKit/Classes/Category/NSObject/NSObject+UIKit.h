//
//  NSObject+UIKit.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

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
    kHSYCocoaKitOfButtonPropretyTypeTextAlignment,                          //NSNumber\(NSTextAlignment)
    
};

//UIImageView
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfImageViewPropretyType) {
    
    kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName             = 877,  //UIImage
    kHSYCocoaKitOfImageViewPropretyTypePreImageViewName,                    //UIImage
    kHSYCocoaKitOfImageViewPropretyTypeViewContentMode,                     //NSNumber\(UIViewContentMode)
};

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
};

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
    
};

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

//WKWebView
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfWKWebViewPropretypType) {
    
    kHSYCocoaKitOfWKWebViewPropretypType_a,
};

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
 UIButton-------key:@(kHSYCocoaKitOfButtonPropretyType枚举)

 @param param 入参属性
 @param next 点击回调时间
 @return UIButton
 */
+ (UIButton *)createButtonByParam:(NSDictionary <NSNumber *, id>*)param clickedOnSubscribeNext:(void(^)(UIButton *button))next;

/**
 UIImageView-------key:@(kHSYCocoaKitOfImageViewPropretyType枚举)

 @param param 入参属性
 @return UIImageView
 */
+ (UIImageView *)createImageViewByParam:(NSDictionary <NSNumber *, id>*)param;

/**
 UILabel-------key:@(kHSYCocoaKitOfLabelPropretyType枚举)

 @param param 入参属性
 @return UILabel
 */
+ (UILabel *)createLabelByParam:(NSDictionary <NSNumber *, id>*)param;

/**
 UITextField------key:@(kHSYCocoaKitOfTextFiledPropretyType枚举)

 @param param 入参属性
 @param next 单行输入框内容改变
 @return UITextField
 */
+ (UITextField *)createTextFiledByParam:(NSDictionary <NSNumber *, id>*)param didChangeSubscribeNext:(void(^)(NSString *text))next;
+ (UITextField *)createTextFiledByParam:(NSDictionary <NSNumber *, id>*)param;

/**
 UITextView------key:@(kHSYCocoaKitOfTextViewPropretyType枚举)

 @param param 入参属性
 @param next 多行输入框内容改变
 @return UITextView
 */
+ (UITextView *)createTextViewByParam:(NSDictionary <NSNumber *, id>*)param didChangeSubscribeNext:(void(^)(NSString *text))next;
+ (UITextView *)createTextViewByParam:(NSDictionary <NSNumber *, id>*)param;

/**
 UITableView-------key:@(kHSYCocoaKitOfTableViewPropretyType枚举)

 @param param 入参属性
 @return UITableView
 */
+ (UITableView *)createTabelViewByParam:(NSDictionary <NSNumber *, id>*)param;

/**
 UIScrollView-----key:@(kHSYCocoaKitOfScrollViewPropretyType枚举)

 @param param 入参属性
 @return UIScrollView
 */
+ (UIScrollView *)createScrollViewByParam:(NSDictionary <NSNumber *, id>*)param;

/**
 UICollectionView------key:@(kHSYCocoaKitOfCollectionViewPropretyType枚举)

 @param param 入参属性
 @return UICollectionView
 */
+ (UICollectionView *)createCollectionViewByParam:(NSDictionary <NSNumber *, id>*)param;

/**
 UICollectionViewFlowLayout------key:@(kHSYCocoaKitOfCollectionViewFlowLayoutPropretyType枚举)

 @param param 入参属性
 @return UICollectionViewFlowLayout
 */
+ (UICollectionViewFlowLayout *)createFlowLayoutByParam:(NSDictionary <NSNumber *, id>*)param;

/**
 UISlider--------key:@(kHSYCocoaKitOfSliderPropertyType)

 @param param 入参属性
 @param newValue 触发changed后改变的值的回调事件
 @return UISlider
 */
+ (UISlider *)createSliderByParam:(NSDictionary <NSNumber *, id>*)param changedValue:(void(^)(CGFloat news))newValue;

@end
