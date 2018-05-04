//
//  HSYDViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/3.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYDViewController.h"
#import "NSObject+UIKit.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"
#import "HSYBaseTableViewCell.h"
#import "Masonry.h"
#import "HSYBaseTableModel.h"
#import "JSONModel.h"
#import "UIImageView+UrlString.h"
#import "HSYNetWorkingManager.h"

static CGFloat offsetLeft = 22.0f;
static CGFloat top = 39.0f;
static CGFloat imgH = 63.0f;
static CGFloat imgBottom = 11.0f;

@interface CXAMCHomePageInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *timesmpe;
@property (nonatomic, strong) NSString<Optional> *source;
@property (nonatomic, strong) NSString<Optional> *imageUrl;

@end

@implementation CXAMCHomePageInfo

@end

@interface CXAMCHomePageTableTitleLabel : UILabel

@end

@implementation CXAMCHomePageTableTitleLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = bounds.origin.y;
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect
{
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end

@interface CXAMCHomePageTableHeaderView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headerImageView;

@end

@implementation CXAMCHomePageTableHeaderView

- (instancetype)initWithInfo:(CXAMCHomePageInfo *)info
{
    UIFont *tagFont = UI_FONT_SIZE(26);
    CGFloat tagOffsetBottom = 19.0f;
    CGFloat headerOffsetH = 75.0f;
    CGFloat headerOffsetBottom = 13.0f;
    UIFont *titleFont = UI_FONT_SIZE(18);
    CGFloat titleOffsetBottom = 11.0f;
    UIFont *sourceFont = UI_SYSTEM_FONT_11;
    
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, 0)]) {
        
        self.backgroundColor = WHITE_COLOR;
        UILabel *tagLabel = [NSObject createLabelByParam:@{
                                                           @(kHSYCocoaKitOfLabelPropretyTypeText) : @"首页推荐",
                                                           @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"212121"),
                                                           @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : tagFont,
                                                           @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentLeft),
                                                           @(kHSYCocoaKitOfLabelPropretyTypeFrame) : [NSValue valueWithCGRect:CGRectMake(offsetLeft, top, (IPHONE_WIDTH - offsetLeft*2), tagFont.pointSize)],
                                                           }];
        [self addSubview:tagLabel];
        
        UIImage *img = [UIImage imageNamed:@"search_icon_invite"];
        self.headerImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : img, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : img, @(kHSYCocoaKitOfImageViewPropretyTypeViewContentMode) : @(UIViewContentModeScaleAspectFill)}];
        self.headerImageView.frame = CGRectMake(offsetLeft, tagLabel.bottom + tagOffsetBottom, tagLabel.width, headerOffsetH);
        self.headerImageView.layer.cornerRadius = 2.0f;
        [self addSubview:self.headerImageView];
        
        self.titleLabel = [NSObject createLabelByParam:@{
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"212121"),
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : titleFont,
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentLeft),
                                                         @(kHSYCocoaKitOfLabelPropretyTypeFrame) : [NSValue valueWithCGRect:CGRectMake(tagLabel.x, self.headerImageView.bottom + headerOffsetBottom , self.headerImageView.width, titleFont.pointSize)],
                                                         @(kHSYCocoaKitOfLabelPropretyTypeText) : info.title,
                                                         }];
        [self addSubview:self.titleLabel];
        
        self.sourceLabel = [NSObject createLabelByParam:@{
                                                          @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"999999"),
                                                          @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : sourceFont,
                                                          @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentLeft),
                                                          @(kHSYCocoaKitOfLabelPropretyTypeFrame) : [NSValue valueWithCGRect:CGRectMake(tagLabel.x, self.titleLabel.bottom + titleOffsetBottom , self.headerImageView.width / 2, sourceFont.pointSize)],
                                                          @(kHSYCocoaKitOfLabelPropretyTypeText) : info.source,
                                                          }];
        [self addSubview:self.sourceLabel];
        
        self.timeLabel = [NSObject createLabelByParam:@{
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"999999"),
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : sourceFont,
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentRight),
                                                        @(kHSYCocoaKitOfLabelPropretyTypeText) : info.timesmpe.stringValue,
                                                        }];
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-tagLabel.x);
            make.left.equalTo(self.sourceLabel.mas_right).offset(10.0f);
            make.top.equalTo(self.sourceLabel.mas_top);
            make.height.equalTo(self.sourceLabel.mas_height);
        }];
        self.height = self.sourceLabel.bottom;
        
    }
    return self;
}

@end

@interface CXAMCHomePageTableCell : HSYBaseTableViewCell

@property (nonatomic, strong) CXAMCHomePageTableTitleLabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong, setter=setHomePageInfo:) CXAMCHomePageInfo *info;

+ (CGFloat)realHeight;

@end

@implementation CXAMCHomePageTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat imageOffsetLeft = 17.0f;
    CGSize imageSize = CGSizeMake(112.0f, imgH);
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.headerImageView = [NSObject createImageViewByParam:@{}];
        [self.contentView addSubview:self.headerImageView];
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-offsetLeft);
            make.top.equalTo(self.contentView.mas_top).offset(top);
            make.size.mas_equalTo(imageSize);
        }];
        
        self.titleLabel = [[CXAMCHomePageTableTitleLabel alloc] initWithFrame:CGRectMake(offsetLeft, top, (IPHONE_WIDTH - (offsetLeft*2 + imageSize.width + imageOffsetLeft)), UI_SYSTEM_FONT_14.pointSize * 2)];
        self.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:self.titleLabel];
        
        self.timeLabel = [NSObject createLabelByParam:@{
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"999999"),
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_SYSTEM_FONT_11,
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentRight),
                                                        }];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-offsetLeft);
            make.top.equalTo(self.headerImageView.mas_bottom).offset(imgBottom);
            make.size.mas_equalTo(CGSizeMake((IPHONE_WIDTH - offsetLeft*2)/2, UI_SYSTEM_FONT_11.pointSize));
        }];
        
        self.sourceLabel = [NSObject createLabelByParam:@{
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"999999"),
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_SYSTEM_FONT_11,
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentLeft),
                                                        }];
        [self.contentView addSubview:self.sourceLabel];
        [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left);
            make.top.equalTo(self.timeLabel.mas_top);
            make.size.mas_equalTo(CGSizeMake((IPHONE_WIDTH - offsetLeft*2)/2-10.0f, UI_SYSTEM_FONT_11.pointSize));
        }];
        
    }
    return self;
}

+ (CGFloat)realHeight
{
    return (top + imgH + imgBottom + UI_SYSTEM_FONT_11.pointSize);
}

- (void)setHomePageInfo:(CXAMCHomePageInfo *)info
{
    _info = info;
    self.titleLabel.text = info.title;
    self.sourceLabel.text = info.source;
    self.timeLabel.text = info.timesmpe.stringValue;
    [self.headerImageView setImageWithUrlString:info.imageUrl];
}

@end

@interface HSYNetWorkingManager (HomePage)

- (RACSignal *)rac_newsCent:(NSString *)PRT_BLNTYP page:(NSString *)PAGENO;

@end

@implementation HSYNetWorkingManager (HomePage)

- (RACSignal *)rac_newsCent:(NSString *)PRT_BLNTYP page:(NSString *)PAGENO
{
    NSDictionary *paramter = @{
                               @"PRT_BLNTYP" : PRT_BLNTYP,
                               @"PAGENO"     : PAGENO,
                               };
    return [self.httpSessionManager hsy_rac_postRequest:@"News/newsCent" parameters:paramter];
}

@end

@interface CXAMCHomePageModel : HSYBaseTableModel

@property (nonatomic, strong) CXAMCHomePageInfo *headerInfo;

@end

@implementation CXAMCHomePageModel

- (instancetype)init
{
    if (self = [super init]) {
        self.headerInfo = [[CXAMCHomePageInfo alloc] init];
        self.headerInfo.title = @"公安部提醒：这10种“投资、理财”项目需谨慎！";
        self.headerInfo.source = @"来源：央广网/马文静";
        self.headerInfo.timesmpe = @(2921024090);
        self.headerInfo.imageUrl = @"";
        
        for (NSInteger i = 0; i < 10; i ++) {
            CXAMCHomePageInfo *info = [[CXAMCHomePageInfo alloc] init];
            info.title = [NSString stringWithFormat:@"%ld--%d", i , arc4random()%100000];
            info.source = [NSString stringWithFormat:@"来源%ld--%d", i , arc4random()%100000];
            info.timesmpe = @(arc4random()%100000);
            info.imageUrl = @"";
            [self.hsy_datas addObject:info];
        }
    }
    return self;
}

- (RACSignal *)hsy_rac_pullDownMethod
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self hsy_refreshToPullDown:^RACSignal *{
            return [[HSYNetWorkingManager shareInstance] rac_newsCent:@"04" page:[NSString stringWithFormat:@"%ld", self.page]];
        } toMap:^NSMutableArray *(RACTuple *tuple) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            return array;
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

- (RACSignal *)hsy_rac_pullUpMethod
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self hsy_refreshToPullUp:^RACSignal *{
            return [[HSYNetWorkingManager shareInstance] rac_newsCent:@"04" page:[NSString stringWithFormat:@"%ld", self.page]];
        } toMap:^NSMutableArray *(RACTuple *tuple) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            return array;
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

@end

@interface HSYDViewController ()

@end

@implementation HSYDViewController

- (void)viewDidLoad {
    self.hsy_viewModel = [[CXAMCHomePageModel alloc] init];
    self.pullDownView = [[HSYCustomRefreshView alloc] initWithRefreshDown:YES];
    self.pullUpView = [[HSYCustomRefreshView alloc] initWithRefreshDown:NO];
    self.showAllReflesh = YES;
    self.lineHidden = @(YES);
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = [[CXAMCHomePageTableHeaderView alloc] initWithInfo:[(CXAMCHomePageModel *)self.hsy_viewModel headerInfo]];
    [self firstRequest];
    // Do any additional setup after loading the view.
}

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
    static NSString *CXAMCHomePageIdentifier = @"kCXAMCHomePageIdentifier";
    CXAMCHomePageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CXAMCHomePageIdentifier];
    if (!cell) {
        cell = [[CXAMCHomePageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CXAMCHomePageIdentifier];
    }
    cell.info = self.hsy_viewModel.hsy_datas[indexPath.item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CXAMCHomePageTableCell realHeight];
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
