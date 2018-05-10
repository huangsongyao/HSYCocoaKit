//
//  UIViewController+Runtime.h
//  Pods
//
//  Created by huangsongyao on 2018/4/27.
//
//

#import <UIKit/UIKit.h>

@interface UIViewControllerRuntimeDelegateObject : NSObject

@property (nonatomic, strong) id object;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, copy) NSString *string;

+ (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@protocol UIViewControllerRuntimeDelegate <NSObject>

- (void)hsy_runtimeDelegate:(UIViewControllerRuntimeDelegateObject *)object;

@end

@interface UIViewController (Runtime)

@property (nonatomic, weak) id<UIViewControllerRuntimeDelegate>hsy_runtimeDelegate;

@end
