#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HSYBaseCollectionViewCell.h"
#import "HSYBaseHeaderFooterView.h"
#import "HSYBaseTableViewCell.h"
#import "HSYBaseCollectionReusableView.h"
#import "HSYBaseTabBarItemCollectionViewCell.h"
#import "HSYBaseCollectionModel.h"
#import "HSYBaseRefleshModel.h"
#import "HSYBaseSegmentedPageControlModel.h"
#import "HSYBaseTabBarModel.h"
#import "HSYBaseTableModel.h"
#import "HSYBaseModel.h"
#import "HSYBaseWebModel.h"
#import "HSYCocoaKitRACSubscribeNotification.h"
#import "HSYBaseCollectionViewController.h"
#import "HSYBaseLaunchScreenViewController.h"
#import "HSYBaseQRCodeViewController.h"
#import "HSYBaseRefleshViewController.h"
#import "HSYBaseSegmentedPageViewController.h"
#import "HSYBaseTabBarViewController.h"
#import "HSYBaseTableViewController.h"
#import "HSYBaseViewController.h"
#import "HSYBaseWebViewController.h"
#import "CABasicAnimation+Transform.h"
#import "CIDetector+QRCode.h"
#import "NSArray+Finder.h"
#import "NSBundle+CFBundle.h"
#import "NSBundle+PrivateFileResource.h"
#import "NSData+Encrypt.h"
#import "NSDate+Timestamp.h"
#import "NSFileManager+Finder.h"
#import "NSMutableArray+BasicAlgorithm.h"
#import "NSObject+JSONModelForRuntime.h"
#import "NSObject+Property.h"
#import "NSObject+Runtime.h"
#import "NSObject+UIKit.h"
#import "NSString+Regular.h"
#import "NSString+Replace.h"
#import "NSString+Size.h"
#import "UIApplication+Device.h"
#import "UIColor+Hex.h"
#import "UIImage+Canvas.h"
#import "UIImage+Compression.h"
#import "UIImage+PNG.h"
#import "UIImageView+Scale.h"
#import "UIImageView+UrlString.h"
#import "UILabel+AttributedString.h"
#import "UILabel+SuggestSize.h"
#import "UINavigationBar+Background.h"
#import "UINavigationController+Pop.h"
#import "UIResponder+Orientation.h"
#import "UIScrollView+Page.h"
#import "UIView+DrawPictures.h"
#import "UIView+Frame.h"
#import "UIView+Gestures.h"
#import "UIView+RotationAnimated.h"
#import "UIViewController+Alert.h"
#import "UIViewController+Device.h"
#import "UIViewController+Finder.h"
#import "UIViewController+Keyboard.h"
#import "UIViewController+NavigationItem.h"
#import "UIViewController+QRCode.h"
#import "UIViewController+Runtime.h"
#import "UIViewController+Window.h"
#import "HSYCustomGestureView.h"
#import "HSYCustomWindows.h"
#import "HSYCustomBannerView.h"
#import "HSYCustomBannerBaseCell.h"
#import "HSYCustomBannerCell.h"
#import "HSYCustomBannerPageControl.h"
#import "HSYBaseCustomButton.h"
#import "HSYCustomGasbagAlertView.h"
#import "HSYCustomGuideView.h"
#import "HSYCustomLargerImageView.h"
#import "HSYBaseSegmentedPageControl.h"
#import "HSYCustomNavigationBar.h"
#import "HSYBaseCustomNavigationController.h"
#import "HSYBaseViewController+CustomNavigationItem.h"
#import "HSYCustomBackTransitionAnimation.h"
#import "HSYCustomBaseTransitionAnimation.h"
#import "HSYCustomLeftTransitionAnimation.h"
#import "HSYFMDBOperationManager+Operation.h"
#import "HSYFMDBOperationManager.h"
#import "HSYFMDBOperation.h"
#import "HSYFMDBOperationFieldInfo.h"
#import "FMResultSet+Model.h"
#import "HSYFMDBMacro.h"
#import "HSYHUDHelper.h"
#import "HSYHUDModel.h"
#import "HSYBaseSegmentedPageConfig.h"
#import "NSObject+JSONModel.h"
#import "NSObject+JSONObjc.h"
#import "NSObject+JSONWriting.h"
#import "NSString+JSONParsing.h"
#import "HSYCocoaKitLottieAnimationManager.h"
#import "APPPathMacroFile.h"
#import "HSYCocoaKit.h"
#import "PublicMacroFile.h"
#import "HSYCocoaKitAttributedLabelManager.h"
#import "AFHTTPSessionManager+RACSignal.h"
#import "AFURLSessionManager+RACSignal.h"
#import "HSYNetWorkingManager.h"
#import "NSError+Message.h"
#import "RACEXTKeyPathCoding.h"
#import "RACEXTRuntimeExtensions.h"
#import "RACEXTScope.h"
#import "RACmetamacros.h"
#import "MKAnnotationView+RACSignalSupport.h"
#import "NSArray+RACSequenceAdditions.h"
#import "NSData+RACSupport.h"
#import "NSDictionary+RACSequenceAdditions.h"
#import "NSEnumerator+RACSequenceAdditions.h"
#import "NSFileHandle+RACSupport.h"
#import "NSIndexSet+RACSequenceAdditions.h"
#import "NSInvocation+RACTypeParsing.h"
#import "NSNotificationCenter+RACSupport.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACDescription.h"
#import "NSObject+RACKVOWrapper.h"
#import "NSObject+RACLifting.h"
#import "NSObject+RACPropertySubscribing.h"
#import "NSObject+RACSelectorSignal.h"
#import "NSOrderedSet+RACSequenceAdditions.h"
#import "NSSet+RACSequenceAdditions.h"
#import "NSString+RACKeyPathUtilities.h"
#import "NSString+RACSequenceAdditions.h"
#import "NSString+RACSupport.h"
#import "NSURLConnection+RACSupport.h"
#import "NSUserDefaults+RACSupport.h"
#import "RACArraySequence.h"
#import "RACBehaviorSubject.h"
#import "RACBlockTrampoline.h"
#import "RACChannel.h"
#import "RACCommand.h"
#import "RACCompoundDisposable.h"
#import "RACDelegateProxy.h"
#import "RACDisposable.h"
#import "RACDynamicSequence.h"
#import "RACDynamicSignal.h"
#import "RACEagerSequence.h"
#import "RACEmptySequence.h"
#import "RACEmptySignal.h"
#import "RACErrorSignal.h"
#import "RACEvent.h"
#import "RACGroupedSignal.h"
#import "RACImmediateScheduler.h"
#import "RACIndexSetSequence.h"
#import "RACKVOChannel.h"
#import "RACKVOProxy.h"
#import "RACKVOTrampoline.h"
#import "RACMulticastConnection+Private.h"
#import "RACMulticastConnection.h"
#import "RACObjCRuntime.h"
#import "RACPassthroughSubscriber.h"
#import "RACQueueScheduler+Subclass.h"
#import "RACQueueScheduler.h"
#import "RACReplaySubject.h"
#import "RACReturnSignal.h"
#import "RACScheduler+Private.h"
#import "RACScheduler+Subclass.h"
#import "RACScheduler.h"
#import "RACScopedDisposable.h"
#import "RACSequence.h"
#import "RACSerialDisposable.h"
#import "RACSignal+Operations.h"
#import "RACSignal.h"
#import "RACSignalSequence.h"
#import "RACStream+Private.h"
#import "RACStream.h"
#import "RACStringSequence.h"
#import "RACSubject.h"
#import "RACSubscriber+Private.h"
#import "RACSubscriber.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "RACSubscriptionScheduler.h"
#import "RACTargetQueueScheduler.h"
#import "RACTestScheduler.h"
#import "RACTuple.h"
#import "RACTupleSequence.h"
#import "RACUnarySequence.h"
#import "RACUnit.h"
#import "RACValueTransformer.h"
#import "ReactiveCocoa.h"
#import "UIActionSheet+RACSignalSupport.h"
#import "UIAlertView+RACSignalSupport.h"
#import "UIBarButtonItem+RACCommandSupport.h"
#import "UIButton+RACCommandSupport.h"
#import "UICollectionReusableView+RACSignalSupport.h"
#import "UIControl+RACSignalSupport.h"
#import "UIControl+RACSignalSupportPrivate.h"
#import "UIDatePicker+RACSignalSupport.h"
#import "UIGestureRecognizer+RACSignalSupport.h"
#import "UIImagePickerController+RACSignalSupport.h"
#import "UIRefreshControl+RACCommandSupport.h"
#import "UISegmentedControl+RACSignalSupport.h"
#import "UISlider+RACSignalSupport.h"
#import "UIStepper+RACSignalSupport.h"
#import "UISwitch+RACSignalSupport.h"
#import "UITableViewCell+RACSignalSupport.h"
#import "UITableViewHeaderFooterView+RACSignalSupport.h"
#import "UITextField+RACSignalSupport.h"
#import "UITextView+RACSignalSupport.h"
#import "RVMViewModel.h"
#import "HSYCustomRefreshView.h"
#import "SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "HSYCocoaKitManager.h"
#import "NSArray+RACSignal.h"
#import "NSDictionary+RACSignal.h"
#import "NSMapTable+RACSignal.h"
#import "RACSignal+Timer.h"
#import "UIActionSheet+RACSignal.h"
#import "UIAlertController+RACSignal.h"
#import "UIAlertView+RACSignal.h"
#import "HSYCocoaKitSocketManager.h"
#import "GCDAsyncSocket+RACSignal.h"
#import "HSYCocoaKitSocketRACSignal.h"

FOUNDATION_EXPORT double HSYCocoaKitVersionNumber;
FOUNDATION_EXPORT const unsigned char HSYCocoaKitVersionString[];

