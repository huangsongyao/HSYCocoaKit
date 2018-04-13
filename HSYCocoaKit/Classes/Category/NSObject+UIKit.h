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
    
    kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName      = 657,  //NSString
    kHSYCocoaKitOfButtonPropretyTypePreBackgroundImageViewName,             //NSString
    kHSYCocoaKitOfButtonPropretyTypeNorTitle,                               //NSString
    kHSYCocoaKitOfButtonPropretyTypeHighTitle,                              //NSString
    kHSYCocoaKitOfButtonPropretyTypeNorImageViewName,                       //UIImage
    kHSYCocoaKitOfButtonPropretyTypePreImageViewName,                       //UIImage
    kHSYCocoaKitOfButtonPropretyTypeSelectedImageViewName,                  //NSString
    kHSYCocoaKitOfButtonPropretyTypeTitleColor,                             //UIColor
    kHSYCocoaKitOfButtonPropretyTypeTitleFont,                              //UIFont
    kHSYCocoaKitOfButtonPropretyTypeCornerRadius,                           //NSNumber\CGFloat
    
};

//UIImageView
typedef NS_ENUM(NSUInteger, kHSYCocoaKitOfImageViewPropretyType) {
    
    kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName             = 877,  //NSString
    kHSYCocoaKitOfImageViewPropretyTypePreImageViewName,                    //NSString
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

/**
 UITextView------key:@(kHSYCocoaKitOfTextViewPropretyType枚举)

 @param param 入参属性
 @param next 多行输入框内容改变
 @return UITextView
 */
+ (UITextView *)createTextViewByParam:(NSDictionary <NSNumber *, id>*)param didChangeSubscribeNext:(void(^)(NSString *text))next;

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


@end
