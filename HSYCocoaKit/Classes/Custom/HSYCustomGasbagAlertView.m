//
//  HSYCustomGasbagAlertView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/19.
//

#import "HSYCustomGasbagAlertView.h"
#import "HSYBaseTableViewCell.h"
#import "NSObject+UIKit.h"
#import "Masonry.h"
#import "NSBundle+PrivateFileResource.h"

//********************************************气囊list数据格式********************************************

@implementation HSYCustomGasbagObject

@end

//********************************************气囊动画的cell**********************************************

@interface HSYCustomGasbagCell : HSYBaseTableViewCell

@property (nonatomic, strong) UILabel *hsy_label;
@property (nonatomic, strong, setter=gasbagObject:) HSYCustomGasbagObject *hsy_object;

@end

@implementation HSYCustomGasbagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.hsy_label = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_SYSTEM_FONT_15, @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter), }];
        [self.contentView addSubview:self.hsy_label];
        [self.hsy_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = HexColorString(@"E1E1E1");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10.0f);
            make.right.equalTo(self.contentView.mas_right).offset(-10.0f);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.equalTo(@(0.5f));
        }];
    }
    return self;
}

- (void)gasbagObject:(HSYCustomGasbagObject *)hsy_object
{
    _hsy_object = hsy_object;
    self.hsy_label.text = hsy_object.hsy_title;
}

@end

//********************************************气囊动画的list*********************************************

@protocol HSYCustomGasbagViewDelegate <NSObject>

- (void)hsy_selectRow:(HSYCustomGasbagObject *)object;

@end

@interface HSYCustomGasbagView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *hsy_tableView;
@property (nonatomic, strong, readonly) NSArray<HSYCustomGasbagObject *> *hsy_dataSources;
@property (nonatomic, weak) id<HSYCustomGasbagViewDelegate>hsy_delgate;

@end

@implementation HSYCustomGasbagView

- (instancetype)initWithDataSources:(NSArray<HSYCustomGasbagObject *> *)dataSources
{
    if (self = [super initWithFrame:CGRectZero]) {
        _hsy_dataSources = dataSources;
        self.hsy_tableView = [NSObject createTabelViewByParam:@{@(kHSYCocoaKitOfTableViewPropretyTypeDelegate) : self, @(kHSYCocoaKitOfTableViewPropretyTypeDataSource) : self, @(kHSYCocoaKitOfTableViewPropretyTypeHiddenCellLine) : @(YES), }];
        [self addSubview:self.hsy_tableView];
        CGFloat landscape = 64.0f;
        CGFloat lengthways = 79.0f;
        [self.hsy_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(lengthways/2);
            make.bottom.equalTo(self.mas_bottom).offset(-lengthways/2);
            make.left.equalTo(self.mas_left).offset(landscape/2);
            make.right.equalTo(self.mas_right).offset(-landscape/2);
        }];
    }
    return self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hsy_dataSources.count > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hsy_dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kHSYCocoaKitGasbagIdentifier = @"HSYCocoaKitGasbagIdentifier";
    HSYCustomGasbagCell *cell = [tableView dequeueReusableCellWithIdentifier:kHSYCocoaKitGasbagIdentifier];
    if (!cell) {
        cell = [[HSYCustomGasbagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHSYCocoaKitGasbagIdentifier];
    }
    cell.hsy_object = self.hsy_dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.hsy_delgate && [self.hsy_delgate respondsToSelector:@selector(hsy_selectRow:)]) {
        [self.hsy_delgate hsy_selectRow:self.hsy_dataSources[indexPath.row]];
    }
}

@end

//******************************************气囊动画的windows层********************************************

@interface HSYCustomGasbagAlertView () <HSYCustomGasbagViewDelegate>

@property (nonatomic, strong) HSYCustomGasbagView *hsy_gasbagView;

@end

@implementation HSYCustomGasbagAlertView

- (instancetype)initWithDefaultBackgroundImage:(UIImage *)backgroundImage position:(CGPoint)position
{
    return [self initWithBackgroundImage:backgroundImage position:position anchorType:kHSYCocoaKitGasbagAlertTypeLeft];
}

- (instancetype)initWithBackgroundImage:(UIImage *)backgroundImage position:(CGPoint)position anchorType:(kHSYCocoaKitGasbagAlertType)type
{
    return [self initWithBackgroundImage:backgroundImage position:position anchorType:type dataSources:@[]];
}

- (instancetype)initWithBackgroundImage:(UIImage *)backgroundImage position:(CGPoint)position anchorType:(kHSYCocoaKitGasbagAlertType)type dataSources:(NSArray *)dataSources
{
    CGPoint anchorPoint = [self.class hsy_anchorPoint:type];
    @weakify(self);
    if (self = [super initWithDefaults:anchorPoint position:position backgroundImage:backgroundImage remove:^(HSYCustomWindows *view) {
        @strongify(self);
        [self hsy_removeGasbag];
    }]) {
        self.hsy_gasbagView = [[HSYCustomGasbagView alloc] initWithDataSources:dataSources];
        self.hsy_gasbagView.frame = self.hsy_wicketView.bounds;
        self.hsy_gasbagView.hsy_delgate = self;
        [self.hsy_wicketView addSubview:self.hsy_gasbagView];
        self.hsy_blackMaskMaxAlpha = kHSYCocoaKitMinScale;
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

#pragma mark - HSYCustomGasbagViewDelegate

- (void)hsy_selectRow:(HSYCustomGasbagObject *)object
{
    if (self.hsy_didSelectedRow) {
        self.hsy_didSelectedRow(object);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation HSYCustomGasbagAlertView (HSYCocoaKit)

+ (HSYCustomGasbagAlertView *)hsy_showGasbagAlert:(NSArray *)dataSources backgroundImage:(UIImage *)backgroundImage position:(CGPoint)position anchorType:(kHSYCocoaKitGasbagAlertType)type didSelectedRowBlock:(void(^)(HSYCustomGasbagObject *x))block
{
    if (!backgroundImage) {
        backgroundImage = [NSBundle imageForBundle:@"pop_xiala"];
    }
    HSYCustomGasbagAlertView *alertView = [[HSYCustomGasbagAlertView alloc] initWithBackgroundImage:backgroundImage position:position anchorType:type dataSources:dataSources];
    [alertView hsy_showGasbag];
    @weakify(alertView);
    alertView.hsy_didSelectedRow = ^(HSYCustomGasbagObject *x) {
        @strongify(alertView);
        if (block) {
            block(x);
        }
        [alertView hsy_removeGasbag];
    };
    return alertView;
}

@end

