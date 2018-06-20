//
//  HSYCustomGasbagAlertView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/19.
//

#import "HSYCustomGasbagAlertView.h"
#import "HSYBaseTableViewCell.h"

//********************************************气囊动画的cell**********************************************

@interface HSYCustomGasbagCell : HSYBaseTableViewCell

@property (nonatomic, strong) UILabel *hsy_label;

@end

@implementation HSYCustomGasbagCell

@end

//********************************************气囊动画的list*********************************************

@interface HSYCustomGasbagView : UIView

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HSYCustomGasbagView

@end

//******************************************气囊动画的windows层********************************************

@interface HSYCustomGasbagAlertView ()

@property (nonatomic, strong) HSYCustomGasbagView *hsy_gasbagView;

@end

@implementation HSYCustomGasbagAlertView

- (instancetype)initWithDefaultBackgroundImage:(UIImage *)backgroundImage
{
    return [self initWithBackgroundImage:backgroundImage anchorType:kHSYCocoaKitGasbagAlertTypeBottom];
}

- (instancetype)initWithBackgroundImage:(UIImage *)backgroundImage anchorType:(kHSYCocoaKitGasbagAlertType)type
{
    CGPoint anchorPoint = [self.class hsy_anchorPoint:type];
    @weakify(self);
    if (self = [super initWithDefaults:anchorPoint position:CGPointMake(100, 300) backgroundImage:backgroundImage remove:^(HSYCustomWindows *view) {
        @strongify(self);
        [self hsy_removeGasbag];
    }]) {
        self.hsy_gasbagView = [[HSYCustomGasbagView alloc] init];
        [self.hsy_wicketView addSubview:self.hsy_gasbagView];
    }
    return self;
}

+ (CGPoint)hsy_anchorPoint:(kHSYCocoaKitGasbagAlertType)type
{
    NSDictionary *dic = @{
                          @(kHSYCocoaKitGasbagAlertTypeTop) : [NSValue valueWithCGPoint:HSYCOCOAKIT_ANCHOR_POINT_X05_Y00],
                          @(kHSYCocoaKitGasbagAlertTypeBottom) : [NSValue valueWithCGPoint:HSYCOCOAKIT_ANCHOR_POINT_X05_Y10],
                          @(kHSYCocoaKitGasbagAlertTypeLeft) : [NSValue valueWithCGPoint:HSYCOCOAKIT_ANCHOR_POINT_X00_Y00],
                          @(kHSYCocoaKitGasbagAlertTypeRight) : [NSValue valueWithCGPoint:HSYCOCOAKIT_ANCHOR_POINT_X10_Y00],
                          };
    return [dic[@(type)] CGPointValue];
}

- (void)hsy_showGasbag
{
    [self hsy_rac_showAlert:^(UIView *view) {
        view.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMaxScale+0.1);
    } completed:^(BOOL finished, UIView *view) {
        __block UIView *viewBlock = view;
        [UIView animateWithDuration:0.2f animations:^{
            viewBlock.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMaxScale);
        }];
    }];
}

- (void)hsy_removeGasbag
{
    [self hsy_rac_removeAlert:^(UIView *view) {
        view.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMaxScale+0.1);
    } completed:^RACSignal *(BOOL finished, UIView *view) {
        __block UIView *viewBlock = view;
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [UIView animateWithDuration:0.2f animations:^{
                viewBlock.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMinScale+0.1);
            } completion:^(BOOL finished) {
                [subscriber sendCompleted];
            }];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"“- hsy_removeGasbag”” methods completed");
            }];
        }];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
