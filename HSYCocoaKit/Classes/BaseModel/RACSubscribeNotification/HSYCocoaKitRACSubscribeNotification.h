//
//  HSYCocoaKitRACSubscribeNotification.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitRACSubjectOfNextType) {
    
    kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNative = 1993,         //js调用native
    kHSYCocoaKitRACSubjectOfNextTypeJavaScriptRunNativeForAlert,        //js触发alert、confirm、prompt等方法
    kHSYCocoaKitRACSubjectOfNextTypeDidFinished,                        //web页面加载完成
    kHSYCocoaKitRACSubjectOfNextTypeDidFailed,                          //web页面加载失败
    
    kHSYCocoaKitRACSubjectOfNextTypeTableViewDidSelectRow,              //tableView点击
    kHSYCocoaKitRACSubjectOfNextTypeCollectionViewDidSelectRow,         //collectionView点击
    
    kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess,                    //下拉刷新成功
    kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess,                      //上拉加载更多成功
    kHSYCocoaKitRACSubjectOfNextTypePerformPullDown,                    //执行下拉动作
    kHSYCocoaKitRACSubjectOfNextTypePerformPullUp,                      //执行上拉动作
    
    kHSYCocoaKitRACSubjectOfNextTypeRequestSuccess,                     //一般网络请求加载成功
    kHSYCocoaKitRACSubjectOfNextTypeRequestFailure,                     //一般网络请求加载失败
    
    kHSYCocoaKitRACSubjectOfNextTypeObserverKeyboard,                   //键盘监听
};

@interface HSYCocoaKitRACSubscribeNotification : NSObject

@property (nonatomic, assign) kHSYCocoaKitRACSubjectOfNextType subscribeType;
@property (nonatomic, strong) NSArray<id> *subscribeContents;
@property (nonatomic, assign) BOOL hsy_isFirstRequest;

- (instancetype)initWithSubscribeNotificationType:(kHSYCocoaKitRACSubjectOfNextType)type subscribeContents:(NSArray<id> *)contents;

@end
