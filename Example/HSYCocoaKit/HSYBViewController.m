//
//  HSYBViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/4/8.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYBViewController.h"
#import "HSYViewControllerModel.h"
#import "HSYBaseTableViewCell.h"
#import "NSObject+UIKit.h"
#import "NSString+Size.h"
#import "UIView+DrawPictures.h"
#import "HSYCustomLargerImageView.h"
#import "HSYCustomGasbagAlertView.h"
#import "HSYBaseQRCodeViewController.h"
#import "HSYCustomBannerView.h"
#import "HSYGuideViewController.h"

@protocol TestBaseTableViewCellDelegate <NSObject>

- (void)callBack:(UIImage *)image values:(NSMutableArray *)values index:(NSInteger)index callMapSuperView:(UIView *)callMapSuperView;

@end

@interface TestBaseTableViewCell : HSYBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, weak) id<TestBaseTableViewCellDelegate>delegate;

- (void)setTestContent:(NSString *)content;

@end

@implementation TestBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.hsy_useFDTmplateLayout = YES;
        
        self.values = [[NSMutableArray alloc] init];
        @weakify(self);
        self.button = [NSObject createButtonByParam:@{@(kHSYCocoaKitOfButtonPropretyTypeNorTitle) : @"888", @(kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName) : [UIImage imageNamed:@"mine_bg_jf"]} clickedOnSubscribeNext:^(UIButton *button) {
            @strongify(self);
            NSLog(@"0000000000000000099990000");
            if (self.delegate && [self.delegate respondsToSelector:@selector(callBack:values:index:callMapSuperView:)]) {
                [self.delegate callBack:button.currentBackgroundImage values:self.values index:0 callMapSuperView:self.contentView];
            }
        }];
        self.button.frame = CGRectMake(0, 0, IPHONE_WIDTH/3, 100);
        [self.values addObject:[NSValue valueWithCGRect:self.button.frame]];
        [self.contentView addSubview:self.button];
        for (NSInteger i = 0; i < 2; i ++) {
            UIButton *button = [NSObject createButtonByParam:@{@(kHSYCocoaKitOfButtonPropretyTypeNorTitle) : @"888", @(kHSYCocoaKitOfButtonPropretyTypeNorBackgroundImageViewName) : [UIImage imageNamed:(i == 0 ? @"v" : @"v1")]} clickedOnSubscribeNext:^(UIButton *button) {
                @strongify(self);
                if (self.delegate && [self.delegate respondsToSelector:@selector(callBack:values:index:callMapSuperView:)]) {
                    [self.delegate callBack:button.currentBackgroundImage values:self.values index:button.tag callMapSuperView:self.contentView];
                }
            }];
            button.frame = CGRectMake((i == 0 ? self.button.right : self.button.right *2), 0, IPHONE_WIDTH/3, 100);
            button.tag = i+1;
            [self.values addObject:[NSValue valueWithCGRect:button.frame]];
            [self.contentView addSubview:button];
        }
        self.titleLabel = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeMaxSize) : [NSValue valueWithCGSize:CGSizeMake(IPHONE_WIDTH, MAXFLOAT)],}];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}

- (void)setTestContent:(NSString *)content
{
    self.titleLabel.text = content;
    self.titleLabel.size = [self.titleLabel.text
                            contentOfSize:self.titleLabel.font
                            maxWidth:IPHONE_WIDTH];
    self.titleLabel.y = self.button.bottom;
    self.height = self.titleLabel.bottom;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [super sizeThatFits:size];
}

@end

@interface HSYBViewController () <TestBaseTableViewCellDelegate, HSYCustomBannerViewDelegate, HSYCustomBannerViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) BOOL toped;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *test;

@property (nonatomic, strong) NSArray *testBanners;


@end

@implementation HSYBViewController

- (void)viewDidLoad {
//    self.showAllReflesh = YES;
    self.showPullDown = YES;
    self.pullDownView = [[HSYCustomRefreshView alloc] initWithRefreshDown:YES];
    self.pullUpView = [[HSYCustomRefreshView alloc] initWithRefreshDown:NO];
    self.hsy_viewModel = [[HSYViewControllerModel alloc] init];
    self.registerClasses = @{@"TestBaseTableViewCell" : @"uuuufffff"};
    [super viewDidLoad];
    
//    self.hsy_showLoading = YES;
//    self.tableView.hidden = YES;
//    @weakify(self);
    [self hsy_rightItemsImages:@[@{@(kHSYCocoaKitDefaultCustomBarItemTag) : @"nav_back@2x"}] subscribeNext:^(UIButton *button, NSInteger tag) {
//        @strongify(self);
        NSLog(@"x1=%@", [NSDate date]);
//        UIImageView *imageView = [self.view snapshotImageView];
//        UIViewController *vc = [UIViewController currentViewController];
        NSLog(@"x2=%@", [NSDate date]);
//        NSLog(@"x3=%@", vc);
        
        HSYCustomGasbagObject *obj_1 = [[HSYCustomGasbagObject alloc] init];
        obj_1.hsy_title = @"test_1";
        HSYCustomGasbagObject *obj_2 = [[HSYCustomGasbagObject alloc] init];
        obj_2.hsy_title = @"test_2";
        [HSYCustomGasbagAlertView hsy_showGasbagAlert:@[obj_1, obj_2] backgroundImage:nil position:CGPointMake(200, 100) anchorType:kHSYCocoaKitGasbagAlertTypeTop didSelectedRowBlock:^(HSYCustomGasbagObject *x) {
            
        } completedGasbag:^(BOOL finished, HSYCustomGasbagObject *gasbagObject) {
            NSLog(@"");
        }];
        
//        HSYBaseQRCodeViewController *vc = [[HSYBaseQRCodeViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
        [HSYGuideViewController test];
//        [[[UIViewController hsy_rac_showSheetViewController:self title:@"test" message:@"" sheetActionTitles:@[@"确定"]] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//            
//        }];
    }];
    
    
//    UIButton *button = [NSObject createButtonByParam:@{} clickedOnSubscribeNext:^(UIButton *button) {
//        NSLog(@"5555555555555555555");
//    }];
//    button.backgroundColor = [UIColor redColor];
//    button.frame = CGRectMake(100, 300, 60, 56);
//    [self.view addSubview:button];
//
//
//    NSMutableArray *banners = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < 10; i ++) {
////        HSYCustomBannerDataSourece *data = [[HSYCustomBannerDataSourece alloc] init];
//        [banners addObject:[NSString stringWithFormat:@"%@", @(i)]];
//    }
//    _testBanners = [banners mutableCopy];
    
    
    [self firstRequest];
    self.hsy_refreshResult = ^RACSignal *(HSYCocoaKitRACSubscribeNotification *signal) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:signal];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{}];
        }];
    };
    self.hsy_viewModel.hsy_showPromptContent = NO;
    self.pullUpStatus = kHSYCocoaKitRefreshForPullUpCompletedStatusNorMore;
    
    
//    [[self.hsy_viewModel.subject deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitRACSubscribeNotification *x) {
//        if (x.subscribeType == kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess) {
//            HSYHUDModel *hudModel = x.subscribeContents.firstObject;
//            if (hudModel.pullUpSize == 0) {
//                [self hsy_notMorePullUp:self.tableView];
//            }
//        }
//    }];
    
//    HSYCustomBannerView *banner = [[HSYCustomBannerView alloc] initWithFrame:CGRectMake(30, self.customNavigationBar.bottom+100, self.view.width - 60, 300) pages:self.testBanners delegate:self dataSource:self];
//    [self.view addSubview:banner];
    // Do any additional setup after loading the view.
}

#pragma mark - HSYCustomBannerViewDelegate, HSYCustomBannerViewDataSource

- (NSInteger)hsy_numberOfPagesInRevisionBannerView:(HSYCustomBannerView *)bannerView
{
    return self.testBanners.count;
}

- (HSYCustomBannerBaseCell *)hsy_revisionBannerView:(HSYCustomBannerView *)bannerView cellForPageAtIndex:(NSInteger)index
{
    HSYCustomBannerCell *cell = [[HSYCustomBannerCell alloc] initWithData:self.testBanners[index]];
    cell.label.text = self.testBanners[index];
    return cell;
}









- (UIView *)header
{
    UIView *view = [[UIView alloc] initWithSize:CGSizeMake(IPHONE_WIDTH, 100)];
    view.backgroundColor = [UIColor greenColor];
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, (100-35), IPHONE_WIDTH, 35)];
    sectionView.backgroundColor = [UIColor redColor];
    [view addSubview:sectionView];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger i = self.hsy_viewModel.hsy_datas.count;
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uuuufffff"];
    [cell setTestContent:self.hsy_viewModel.hsy_datas[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self hsy_heightForCellWithCacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        TestBaseTableViewCell *realCell = (TestBaseTableViewCell *)cell;
        [realCell setTestContent:self.hsy_viewModel.hsy_datas[indexPath.row]];
    }];
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (!self.toped && (scrollView.contentOffset.y >= (100-35))) {
//        [self update:YES];
//    } else if (self.tableView.tableHeaderView && (scrollView.contentOffset.y <= (100-35))) {
//        self.headerView.hidden = YES;
//    }
//}
//
//- (void)update:(BOOL)hidden
//{
//    if (hidden) {
//        self.headerView.hidden = NO;
//        self.tableView.tableHeaderView = nil;
//        self.tableView.y = self.headerView.bottom;
//        self.tableView.height = IPHONE_HEIGHT - self.tableView.y;
//        [self.tableView setContentOffset:CGPointZero];
//        self.toped = YES;
//    } else {
//        self.tableView.y = self.customNavigationBar.bottom;
//        //滚动到顶部的动作不能真正滚动到contentOffset.y == 0.0f,而是应该预留一点位置，这样才会再执行“- scrollViewDidScroll:”的委托时，进入“else if”的判断中
//        [self.tableView setContentOffset:CGPointMake(0, 0.5f) animated:YES];
//        [CATransaction begin];
//        @weakify(self);
//        [CATransaction setCompletionBlock:^{
//            @strongify(self);
//            self.tableView.height = IPHONE_HEIGHT - self.tableView.y;
//            self.headerView.hidden = YES;
//            self.toped = NO;
//        }];
//        [self.tableView beginUpdates];
//        self.tableView.tableHeaderView = self.tableHeaderView;
//        [self.tableView endUpdates];
//        [CATransaction commit];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TestBaseTableViewCellDelegate

- (void)callBack:(UIImage *)image values:(NSMutableArray *)values index:(NSInteger)index callMapSuperView:(UIView *)callMapSuperView
{
    [HSYCustomLargerImageView showLargerImageViewSelectedImage:image
                                                imagesParamter:@{@(index) : @[[UIImage imageNamed:@"mine_bg_jf"], [UIImage imageNamed:@"v"], [UIImage imageNamed:@"v1"],]}
                                                  imageCGRects:values
                                              callMapSuperView:callMapSuperView];
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
