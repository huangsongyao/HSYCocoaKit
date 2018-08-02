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
#import "CXACMHomePageJSONModel.h"
#import "NSObject+JSONModel.h"
#import "NSDate+Timestamp.h"
#import "NSString+Size.h"
#import "UIViewController+Runtime.h"

static CGFloat offsetLeft = 22.0f;
static CGFloat top = 39.0f;
static CGFloat imgH = 63.0f;
static CGFloat imgBottom = 11.0f;

#pragma mark - CXAMCHomePageTableHeaderView

@interface CXAMCHomePageTableHeaderView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headerImageView;

@end

@implementation CXAMCHomePageTableHeaderView

- (instancetype)initWithInfo:(CXACMHomePageItemJSONModel *)info
{
    UIFont *tagFont = UI_FONT_SIZE(26);
    CGFloat tagOffsetBottom = 19.0f;
    CGFloat headerOffsetH = 75.0f;
    CGFloat headerOffsetBottom = 13.0f;
    UIFont *titleFont = UI_SYSTEM_FONT_18;
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
                                                         @(kHSYCocoaKitOfLabelPropretyTypeText) : info.tOPIC,
                                                         }];
        [self addSubview:self.titleLabel];
        
        self.sourceLabel = [NSObject createLabelByParam:@{
                                                          @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"999999"),
                                                          @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : sourceFont,
                                                          @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentLeft),
                                                          @(kHSYCocoaKitOfLabelPropretyTypeFrame) : [NSValue valueWithCGRect:CGRectMake(tagLabel.x, self.titleLabel.bottom + titleOffsetBottom , self.headerImageView.width / 2, sourceFont.pointSize)],
                                                          @(kHSYCocoaKitOfLabelPropretyTypeText) : [NSString stringWithFormat:@"来源:%@/%@", info.sOURCE, info.aUTHOR],
                                                          }];
        [self addSubview:self.sourceLabel];
        
        self.timeLabel = [NSObject createLabelByParam:@{
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : HexColorString(@"999999"),
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : sourceFont,
                                                        @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentRight),
                                                        @(kHSYCocoaKitOfLabelPropretyTypeText) : info.sHOW_TIME,
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

#pragma mark - CXAMCHomePageTableCell

@interface CXAMCHomePageTableCell : HSYBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong, setter=setHomePageInfo:) CXACMHomePageItemJSONModel *info;

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
        
        UIFont *titleFont = UI_SYSTEM_FONT_18;
        NSValue *titleValue = [NSValue valueWithCGRect:CGRectMake(offsetLeft, top, (IPHONE_WIDTH - (offsetLeft*2 + imageSize.width + imageOffsetLeft)), 0.0f)];
        self.titleLabel = [NSObject createLabelByParam:@{
                                                         @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : titleFont,
                                                         @(kHSYCocoaKitOfLabelPropretyTypeFrame) : titleValue,
                                                         }];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
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

- (void)setHomePageInfo:(CXACMHomePageItemJSONModel *)info
{
    _info = info;
    self.titleLabel.text = info.tOPIC;
    CGSize size = [self.titleLabel.text contentOfSize:self.titleLabel.font
                                             maxWidth:self.titleLabel.width
                                            maxHeight:(self.titleLabel.font.pointSize * 2)];
    self.titleLabel.height = size.height * 2;
    self.sourceLabel.text = [NSString stringWithFormat:@"来源:%@/%@", info.sOURCE, info.aUTHOR];
    self.timeLabel.text = info.sHOW_TIME;
    [self.headerImageView setImageWithUrlString:info.nEWS_IMG_URL];
}

@end

#pragma mark - HSYNetWorkingManager (HomePage)

@interface HSYNetWorkingManager (HomePage)

- (RACSignal *)rac_newsCent:(NSString *)PRT_BLNTYP page:(NSString *)PAGENO size:(NSString *)RECNUM;

@end

@implementation HSYNetWorkingManager (HomePage)

- (RACSignal *)rac_newsCent:(NSString *)PRT_BLNTYP page:(NSString *)PAGENO size:(NSString *)RECNUM
{
    [[HSYNetWorkingManager shareInstance] hsy_setNetworkBaseUrl:@"https://mobile.zhubaodai.com/zbd-app/"];
    NSDictionary *paramter = @{
                               @"PRT_BLNTYP" : PRT_BLNTYP,
                               @"PAGENO"     : PAGENO,
                               @"RECNUM"     : RECNUM,
                               };
    return [self.httpSessionManager hsy_rac_getRequest:@"News/newsList" parameters:paramter];
}

@end

#pragma mark - CXAMCHomePageModel

@interface CXAMCHomePageModel : HSYBaseTableModel

@property (nonatomic, strong) CXACMHomePageItemJSONModel *headerInfo;

@end

@implementation CXAMCHomePageModel

- (instancetype)init
{
    if (self = [super init]) {
        self.headerInfo = [[CXACMHomePageItemJSONModel alloc] init];
        self.headerInfo.tOPIC = @"公安部提醒：这10种“投资、理财”项目需谨慎！";
        self.headerInfo.sOURCE = @"央广网";
        self.headerInfo.aUTHOR = @"马文静";
        self.headerInfo.sHOW_TIME = [NSDate date].stringyyyyMMddHHmmss;
        self.headerInfo.nEWS_IMG_URL = @"";
        [self hsy_updateSize:15];
    }
    return self;
}

- (RACSignal *)hsy_rac_pullDownMethod
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self hsy_refreshToPullDown:^RACSignal *{
            return [[HSYNetWorkingManager shareInstance] rac_newsCent:@"04" page:[NSString stringWithFormat:@"%ld", self.page] size:[NSString stringWithFormat:@"%ld", self.size]];
        } toMap:^NSMutableArray *(RACTuple *tuple) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            CXACMHomePageJSONModel *model = [NSObject hsy_resultObjectToJSONModelWithClasses:[CXACMHomePageJSONModel class] json:tuple.second];
            for (CXACMHomePageItemJSONModel *obj in model.message.Body.List.Item) {
                [array addObject:obj];
            }
            return array;
        } subscriberNext:^(id x) {
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_rac_pullDownMethod” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

- (RACSignal *)hsy_rac_pullUpMethod
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self hsy_refreshToPullUp:^RACSignal *{
            return [[HSYNetWorkingManager shareInstance] rac_newsCent:@"04" page:[NSString stringWithFormat:@"%ld", self.page] size:[NSString stringWithFormat:@"%ld", self.size]];
        } toMap:^NSMutableArray *(RACTuple *tuple) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            CXACMHomePageJSONModel *model = [NSObject hsy_resultObjectToJSONModelWithClasses:[CXACMHomePageJSONModel class] json:tuple.second];
            for (CXACMHomePageItemJSONModel *obj in model.message.Body.List.Item) {
                [array addObject:obj];
            }
            return array;
        } subscriberNext:^(id x) {
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_rac_pullUpMethod” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

@end

#pragma mark - 

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.hsy_runtimeDelegate) {
        if ([self.hsy_runtimeDelegate respondsToSelector:@selector(hsy_runtimeDelegate:)]) {
            [self.hsy_runtimeDelegate hsy_runtimeDelegate:nil];
        }
    }
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
