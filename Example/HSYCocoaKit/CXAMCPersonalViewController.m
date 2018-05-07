//
//  CXAMCPersonalViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/7.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "CXAMCPersonalViewController.h"
#import "HSYBaseTableModel.h"
#import "NSObject+UIKit.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "HSYBaseTableViewCell.h"
#import "NSObject+Runtime.h"
#import "UIImageView+UrlString.h"

@interface CXAMCPersonalHeaderInfo : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userImageUrl;
@property (nonatomic, copy) NSString *userMemberState;
@property (nonatomic, copy) NSString *userCer;
@property (nonatomic, strong) NSNumber *userCerState;
@property (nonatomic, copy) NSString *userMeasurement;
@property (nonatomic, strong) NSNumber *userMeasurementState;

+ (CXAMCPersonalHeaderInfo *)persionalHeaderDataSource;

@end

@implementation CXAMCPersonalHeaderInfo

+ (CXAMCPersonalHeaderInfo *)persionalHeaderDataSource
{
    NSDictionary *dic = @{@"userName" : @"未登录", @"userImageUrl" : @"", @"userMemberState" : @"", @"userCer" : @"未验证", @"userCerState" : @(NO), @"userMeasurement" : @"未测评", @"userMeasurementState" : @(NO),};
    CXAMCPersonalHeaderInfo *info = [NSObject objectRuntimeValues:dic classes:[CXAMCPersonalHeaderInfo class]];
    return info;
}

@end

@interface CXAMCPersonalBodyInfo : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *state;

+ (NSArray<CXAMCPersonalBodyInfo *> *)persionalBodyDataSource;

@end

@implementation CXAMCPersonalBodyInfo

+ (NSArray<CXAMCPersonalBodyInfo *> *)persionalBodyDataSource
{
    NSArray *array = @[
                        @{@"title" : @"风险测评", @"icon" : @"mine_icon_evaluation", @"state" : @"稳健型"},
                        @{@"title" : @"安全设置", @"icon" : @"mine_icon_safe", @"state" : @""},
                        @{@"title" : @"个人信息", @"icon" : @"mine_icon_personal", @"state" : @""},
                        ];
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        CXAMCPersonalBodyInfo *body = [NSObject objectRuntimeValues:dic classes:[CXAMCPersonalBodyInfo class]];
        [results addObject:body];
    }
    return [results mutableCopy];
}

@end


@interface CXAMCPersonalHeaderComponentView : UIView

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation CXAMCPersonalHeaderComponentView

- (instancetype)initWithComponentTitle:(NSString *)title componentState:(BOOL)state
{
    if (self = [super initWithSize:CGSizeZero]) {
        UIImage *image = [UIImage imageNamed:state ? @"mine_icon_selected" : @"mine_icon_default"];
        self.iconImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image}];
        [self addSubview:self.iconImageView];
        self.iconImageView.size = CGSizeMake(UI_SYSTEM_FONT_13.pointSize, UI_SYSTEM_FONT_13.pointSize);
        
        self.contentLabel = [NSObject createLabelByParam:@{
                                                           @(kHSYCocoaKitOfLabelPropretyTypeText) : title,
                                                           @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : (state ? WHITE_COLOR : [WHITE_COLOR colorWithAlphaComponent:0.6]),
                                                           @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_SYSTEM_FONT_13,
                                                           @(kHSYCocoaKitOfLabelPropretyTypeMaxSize) : [NSValue valueWithCGSize:CGSizeMake(IPHONE_WIDTH/2, UI_SYSTEM_FONT_13.pointSize)],
                                                           }];
        self.contentLabel.origin = CGPointMake(self.iconImageView.right + 5.0f, 0);
        [self addSubview:self.contentLabel];
        
        self.size = CGSizeMake(self.contentLabel.right, self.contentLabel.height);
    }
    return self;
}

@end

@interface CXAMCPersonalTableHeaderView : UIView

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *userMemberImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) CXAMCPersonalHeaderComponentView *certification;
@property (nonatomic, strong) CXAMCPersonalHeaderComponentView *measurement;

@end

@implementation CXAMCPersonalTableHeaderView

- (instancetype)initWithHeaderData:(CXAMCPersonalHeaderInfo *)info
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, 265.0f)]) {
        CGFloat top = 67.0f;
        CGFloat size = 86.0f;
        
        UIImage *bgImage = [UIImage imageNamed:@"mine_bg_jf"];
        UIImageView *backgroundImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : bgImage, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : bgImage}];
        backgroundImageView.frame = self.bounds;
        [self addSubview:backgroundImageView];
        
        self.headerImageView = [NSObject createImageViewByParam:@{}];
        [self addSubview:self.headerImageView];
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(top);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(size, size));
        }];
        [self.headerImageView setImageWithUrlString:info.userImageUrl];
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"v%@", info.userMemberState]];
        self.userMemberImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image}];
        [self addSubview:self.userMemberImageView];
        [self.userMemberImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headerImageView.mas_centerX);
            make.top.equalTo(self.headerImageView.mas_bottom).offset(-8.0f);
            make.size.mas_equalTo(CGSizeMake(size, 16.0f));
        }];
        
        self.userNameLabel = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeText) : info.userName, @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : WHITE_COLOR, @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_BOLD_SYSTEM_FONT_18, @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter),}];
        [self addSubview:self.userNameLabel];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userMemberImageView.mas_bottom).offset(12.0f);
            make.left.equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(self.width, UI_BOLD_SYSTEM_FONT_18.pointSize));
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = WHITE_COLOR;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.userNameLabel.mas_bottom).offset(24.0f);
            make.size.mas_equalTo(CGSizeMake(1.0f, UI_SYSTEM_FONT_13.pointSize));
        }];
        
        self.certification = [[CXAMCPersonalHeaderComponentView alloc] initWithComponentTitle:info.userCer componentState:info.userCerState.boolValue];
        [self addSubview:self.certification];
        [self.certification mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_top);
            make.right.equalTo(line.mas_left).offset(-16.0f);
            make.size.mas_equalTo(self.certification.size);
        }];
        
        self.measurement = [[CXAMCPersonalHeaderComponentView alloc] initWithComponentTitle:info.userMeasurement componentState:info.userMeasurementState.boolValue];
        [self addSubview:self.measurement];
        [self.measurement mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_top);
            make.left.equalTo(line.mas_right).offset(16.0f);
            make.size.mas_equalTo(self.measurement.size);
        }];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.headerImageView.layer.cornerRadius = self.headerImageView.height/2;
}

@end

@interface CXAMCPersonalTableCell : HSYBaseTableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *allowImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation CXAMCPersonalTableCell

- (instancetype)initWithData:(CXAMCPersonalBodyInfo *)data
{
    if (self = [super init]) {
        CGFloat left = 22.0f;
        UIImage *allow = [UIImage imageNamed:@"autobid_icon_right"];
        self.allowImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : allow, @(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : allow}];
        [self.contentView addSubview:self.allowImageView];
        [self.allowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-left);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(allow.size);
        }];
        
        self.stateLabel = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"999999"), @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_SYSTEM_FONT_11, @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentRight), @(kHSYCocoaKitOfLabelPropretyTypeText) : (data.state ? data.state : @"")}];
        [self.contentView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.allowImageView.mas_left).offset(-10.0f);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_offset(CGSizeMake((IPHONE_WIDTH-left*2)/3, self.contentView.height));
        }];
        
        UIImage *iconImage = [UIImage imageNamed:data.icon];
        self.iconImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : iconImage, @(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : iconImage}];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(left);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(left, left));
        }];
        
        self.contentLabel = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"212121"), @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_BOLD_SYSTEM_FONT_15, @(kHSYCocoaKitOfLabelPropretyTypeText) : data.title,}];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(14.0f);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.stateLabel.mas_left).offset(-14.0f);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = HexColorString(@"f7f7f7");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.equalTo(@(0.6));
            make.left.equalTo(self.iconImageView.mas_left);
        }];
    }
    return self;
}

@end

@interface CXAMCPersonalTableModel : HSYBaseTableModel

@property (nonatomic, strong) CXAMCPersonalHeaderInfo *headerInfo;

@end

@implementation CXAMCPersonalTableModel

- (instancetype)init
{
    if (self = [super init]) {
        self.headerInfo = [CXAMCPersonalHeaderInfo persionalHeaderDataSource];
        self.hsy_datas = [NSMutableArray arrayWithArray:[CXAMCPersonalBodyInfo persionalBodyDataSource]];
    }
    return self;
}

@end

@interface CXAMCPersonalViewController ()

@end

@implementation CXAMCPersonalViewController

- (void)viewDidLoad {
    self.tableViewStyle = UITableViewStyleGrouped;
    self.hsy_viewModel = [[CXAMCPersonalTableModel alloc] init];
    self.lineHidden = @(YES);
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[CXAMCPersonalTableHeaderView alloc] initWithHeaderData:[(CXAMCPersonalTableModel *)self.hsy_viewModel headerInfo]];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hsy_viewModel.hsy_datas.count > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hsy_viewModel.hsy_datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXAMCPersonalTableCell *cell = [[CXAMCPersonalTableCell alloc] initWithData:[(CXAMCPersonalTableModel *)self.hsy_viewModel hsy_datas][indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = WHITE_COLOR;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
