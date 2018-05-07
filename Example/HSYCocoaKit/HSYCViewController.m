//
//  HSYCViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/3.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYCViewController.h"
#import "NSObject+UIKit.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"
#import "HSYBaseTableViewCell.h"
#import "Masonry.h"
#import "HSYBaseTableModel.h"
#import "JSONModel.h"
#import "NSObject+Runtime.h"
#import "UIImage+Canvas.h"

static CGFloat textFieldHeight = 43.0f;
static CGFloat textFieldOffsetBottom = 10.0f;
static CGFloat textFieldOffsetLeft = 10.0f;
static CGFloat offset = 30.0f;
static CGFloat titleLeft = 22.0f;

#define BACKGROUND_COLOR    HexColorString(@"ECECEC");

#pragma mark - CXAMCCalculatorInfo

@interface CXAMCCalculatorInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *placeholderString;
@property (nonatomic, strong) NSNumber *hiddenTextField;
@property (nonatomic, strong) NSNumber *showTriangle;

+ (NSArray<CXAMCCalculatorInfo *> *)calculatorDataSource;

@end

@implementation CXAMCCalculatorInfo

+ (NSArray<CXAMCCalculatorInfo *> *)calculatorDataSource
{
    NSArray *array = @[
                       @{@"title" : @"投资金额", @"text" : @"10000", @"unit" : @"元", @"placeholderString" : @"请输入投资金额", @"hiddenTextField" : @(NO), @"showTriangle" : @(NO)},
                       @{@"title" : @"投资期限", @"text" : @"", @"unit" : @"月", @"placeholderString" : @"请输入1-12的数值", @"hiddenTextField" : @(NO), @"showTriangle" : @(YES)},
                       @{@"title" : @"年化利率", @"text" : @"", @"unit" : @"%", @"placeholderString" : @"请输入1-100的数值", @"hiddenTextField" : @(NO), @"showTriangle" : @(NO)},
//                       @{@"title" : @"居间费率", @"text" : @"0", @"unit" : @"%", @"placeholderString" : @"请输入投资金额", @"hiddenTextField" : @(YES), @"showTriangle" : @(NO)},
                       @{@"title" : @"还款方式", @"text" : @"", @"unit" : @"  按月付息，到期还本", @"placeholderString" : @"", @"hiddenTextField" : @(YES), @"showTriangle" : @(NO)},
                       ];
    NSMutableArray *results = [@[] mutableCopy];
    for (NSDictionary *dic in array) {
        CXAMCCalculatorInfo *info = [NSObject objectRuntimeValues:dic classes:[CXAMCCalculatorInfo class]];
        [results addObject:info];
    }
    return [results mutableCopy];
}

@end

#pragma mark - CXAMCCalculatorModel

@interface CXAMCCalculatorModel : HSYBaseTableModel

@end

@implementation CXAMCCalculatorModel

- (instancetype)init
{
    if (self = [super init]) {
        self.hsy_datas = [NSMutableArray arrayWithArray:[CXAMCCalculatorInfo calculatorDataSource]];
    }
    return self;
}

@end

#pragma mark - CXAMCCalculatorTableHeaderView

@interface CXAMCCalculatorTableHeaderView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CXAMCCalculatorTableHeaderView

- (instancetype)init
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, (IPHONE_BAR_HEIGHT + offset))]) {
        self.backgroundColor = WHITE_COLOR;
        self.titleLabel = [NSObject createLabelByParam:@{
                                                         @(kHSYCocoaKitOfLabelPropretyTypeText) : @"收益计算器",
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_BOLD_SYSTEM_FONT_18,
                                                         @(kHSYCocoaKitOfLabelPropretyTypeBackgroundColor) : WHITE_COLOR,
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"212121"),
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter),
                                                         }];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top).offset(IPHONE_STATUS_BAR_HEIGHT*3/2);
            make.height.equalTo(@(UI_BOLD_SYSTEM_FONT_18.pointSize));
        }];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = BACKGROUND_COLOR;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@(offset));
        }];
    }
    return self;
}

@end

#pragma mark - CXAMCCalculatorTableFooterView

@interface CXAMCCalculatorTableFooterView : UIView

@end

@implementation CXAMCCalculatorTableFooterView

- (instancetype)initWithCalculator:(void(^)(UIButton *button))calculator reset:(void(^)(UIButton *button))reset
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, (offset + textFieldHeight*2))]) {
        self.backgroundColor = CLEAR_COLOR;
        NSDictionary *calculatorDic = @{
                                        @(kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName) : [UIImage imageWithFillColor:HexColorString(@"ca4526")],
                                        @(kHSYCocoaKitOfButtonPropretyTypeNorTitle) : @"计算",
                                        @(kHSYCocoaKitOfButtonPropretyTypeHighTitle) : @"计算",
                                        @(kHSYCocoaKitOfButtonPropretyTypeTitleFont) : UI_SYSTEM_FONT_18,
                                        @(kHSYCocoaKitOfButtonPropretyTypeTitleColor) : WHITE_COLOR,
                                        @(kHSYCocoaKitOfButtonPropretyTypeCornerRadius) : @(2.0f),
                                        };
        UIButton *calculatorButton = [NSObject createButtonByParam:calculatorDic clickedOnSubscribeNext:calculator];
        [self addSubview:calculatorButton];
        [calculatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(titleLeft);
            make.right.equalTo(self.mas_right).offset(-titleLeft);
            make.height.equalTo(@(textFieldHeight));
            make.top.equalTo(self.mas_top).offset(offset - textFieldOffsetBottom);
        }];
        
        NSDictionary *resetDic = @{
                                   @(kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName) : [UIImage imageWithFillColor:WHITE_COLOR],
                                   @(kHSYCocoaKitOfButtonPropretyTypeNorTitle) : @"重置",
                                   @(kHSYCocoaKitOfButtonPropretyTypeHighTitle) : @"重置",
                                   @(kHSYCocoaKitOfButtonPropretyTypeTitleFont) : UI_SYSTEM_FONT_18,
                                   @(kHSYCocoaKitOfButtonPropretyTypeTitleColor) : HexColorString(@"ca4526"),
                                   @(kHSYCocoaKitOfButtonPropretyTypeCornerRadius) : @(2.0f),
                                   };
        UIButton *resetButton = [NSObject createButtonByParam:resetDic clickedOnSubscribeNext:reset];
        resetButton.layer.borderWidth = 1.0f;
        resetButton.layer.borderColor = HexColorString(@"ca4526").CGColor;
        [self addSubview:resetButton];
        [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(calculatorButton.mas_bottom).offset(textFieldOffsetBottom);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(calculatorButton.mas_left);
            make.right.equalTo(calculatorButton.mas_right);
        }];
    }
    return self;
}

@end

#pragma mark - CXAMCCalculatorTableComponentView

@interface CXAMCCalculatorTableComponentView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CXAMCCalculatorTableComponentView

- (instancetype)initWithDataSource:(CXAMCCalculatorInfo *)data masLeft:(CGFloat)left changedText:(void(^)(NSString *text))changed
{
    if (self = [super initWithSize:CGSizeMake((IPHONE_WIDTH - left - titleLeft), textFieldHeight)]) {
        self.origin = CGPointMake(left, 0);
        self.layer.borderColor = HexColorString(@"dddddd").CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 2.0f;
        
        self.contentLabel = [NSObject createLabelByParam:@{
                                                           @(kHSYCocoaKitOfLabelPropretyTypeText) : data.unit,
                                                           @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"666666"),
                                                           @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_SYSTEM_FONT_17,
                                                           @(kHSYCocoaKitOfLabelPropretyTypeBackgroundColor) : HexColorString(@"eeeeee"),
                                                           }];
        self.contentLabel.layer.cornerRadius = self.layer.cornerRadius;
        self.contentLabel.layer.borderWidth = self.layer.borderWidth;
        self.contentLabel.layer.borderColor = self.layer.borderColor;
        self.contentLabel.layer.masksToBounds = YES;
        self.contentLabel.frame = self.bounds;
        [self addSubview:self.contentLabel];
        if (data.showTriangle) {
            
        }
        
        if (!data.hiddenTextField.boolValue) {
            self.contentLabel.frame = CGRectMake(self.width - textFieldHeight, 0, textFieldHeight, textFieldHeight);
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            self.textField = [NSObject createTextFiledByParam:@{
                                                                @(kHSYCocoaKitOfTextFiledPropretyTypeFont) : UI_SYSTEM_FONT_17,
                                                                @(kHSYCocoaKitOfTextFiledPropretyTypeTextColor) : HexColorString(@"333333"),
                                                                @(kHSYCocoaKitOfTextFiledPropretyTypeText) : data.text,
                                                                @(kHSYCocoaKitOfTextFiledPropretyTypePlaceholderString) : data.placeholderString,
                                                                } didChangeSubscribeNext:changed];
            self.textField.frame = CGRectMake(textFieldOffsetLeft, 0, (self.width - textFieldOffsetLeft - self.contentLabel.width), self.height);
            [self addSubview:self.textField];
        }
        
        
    }
    return self;
}

@end

#pragma mark - CXAMCCalculatorTableCellDelegate

@protocol CXAMCCalculatorTableCellDelegate <NSObject>

- (void)changedDidText:(NSString *)text;

@end

@interface CXAMCCalculatorTableCell : HSYBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CXAMCCalculatorTableComponentView *textField;
@property (nonatomic, weak) id<CXAMCCalculatorTableCellDelegate>delegate;

@end

@implementation CXAMCCalculatorTableCell

- (instancetype)initWithInfo:(CXAMCCalculatorInfo *)info
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CXAMCCalculatorReuseIdentifier"]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEAR_COLOR;
        self.contentView.backgroundColor = CLEAR_COLOR;
        self.titleLabel = [NSObject createLabelByParam:@{
                                                         @(kHSYCocoaKitOfLabelPropretyTypeText) : info.title,
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_FONT_SIZE(17),
                                                         @(kHSYCocoaKitOfLabelPropretyTypeBackgroundColor) : WHITE_COLOR,
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"212121"),
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter),
                                                         @(kHSYCocoaKitOfLabelPropretyTypeMaxSize) : [NSValue valueWithCGSize:CGSizeMake(IPHONE_WIDTH, UI_FONT_SIZE(17).pointSize)],
                                                         }];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = CLEAR_COLOR;
        self.titleLabel.origin = CGPointMake(titleLeft, (self.height - self.titleLabel.height)/2);
        
        @weakify(self);
        self.textField = [[CXAMCCalculatorTableComponentView alloc] initWithDataSource:info masLeft:(self.titleLabel.right + textFieldOffsetLeft) changedText:^(NSString *text) {
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(changedDidText:)]) {
                [self.delegate changedDidText:text];
            }
        }];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

+ (CGFloat)realHeight
{
    return (textFieldHeight + textFieldOffsetBottom);
}

@end

#pragma mark - CXAMCCalculatorViewController

@interface HSYCViewController () <CXAMCCalculatorTableCellDelegate>

@end

@implementation HSYCViewController

- (void)viewDidLoad {
    self.hsy_viewModel = [[CXAMCCalculatorModel alloc] init];
    self.hsy_addEndEditedKeyboard = YES;
    self.lineHidden = @(YES);
    self.scrollEnabled = @(NO);
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.tableView.tableHeaderView = [[CXAMCCalculatorTableHeaderView alloc] init];
    self.tableView.tableFooterView = [[CXAMCCalculatorTableFooterView alloc] initWithCalculator:^(UIButton *button) {
        
    } reset:^(UIButton *button) {
        
    }];
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
    CXAMCCalculatorTableCell *cell = [[CXAMCCalculatorTableCell alloc] initWithInfo:[(CXAMCCalculatorModel *)self.hsy_viewModel hsy_datas][indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CXAMCCalculatorTableCell realHeight];
}

#pragma mark - CXAMCCalculatorTableCellDelegate

- (void)changedDidText:(NSString *)text
{
    
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
