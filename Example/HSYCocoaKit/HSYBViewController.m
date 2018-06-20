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
#import "HSYCustomWindows.h"

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

@interface HSYBViewController () <TestBaseTableViewCellDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) BOOL toped;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *test;

@end

@implementation HSYBViewController

- (void)viewDidLoad {
    self.showAllReflesh = YES;
    self.pullDownView = [[HSYCustomRefreshView alloc] initWithRefreshDown:YES];
    self.pullUpView = [[HSYCustomRefreshView alloc] initWithRefreshDown:NO];
    self.hsy_viewModel = [[HSYViewControllerModel alloc] init];
    self.registerClasses = @{@"TestBaseTableViewCell" : @"uuuufffff"};
    [super viewDidLoad];
    
    self.tableHeaderView = [self header];
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    @weakify(self);
    UIButton *btn = [NSObject createButtonByParam:@{@(kHSYCocoaKitOfButtonPropretyTypeNorTitle) : @"返回"} clickedOnSubscribeNext:^(UIButton *button) {
        @strongify(self);
        [self update:NO];
    }];
    btn.frame = CGRectMake(0, 0, 50, 35);
    self.headerView = [[UIView alloc] initWithSize:CGSizeMake(IPHONE_WIDTH, 35)];
    self.headerView.y = self.customNavigationBar.bottom;
    self.headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.headerView];
    [self.view bringSubviewToFront:self.headerView];
    self.headerView.hidden = YES;
    [self.headerView addSubview:btn];
    
    [self hsy_rightItemsImages:@[@{@(kHSYCustomBarButtonItemTagBack) : @"nav_back@2x"}] subscribeNext:^(UIButton *button, kHSYCustomBarButtonItemTag tag) {
        NSLog(@"x1=%@", [NSDate date]);
//        UIImageView *imageView = [self.view snapshotImageView];
//        UIViewController *vc = [UIViewController currentViewController];
        NSLog(@"x2=%@", [NSDate date]);
//        NSLog(@"x3=%@", vc);
        HSYCustomWindows *wt = [[HSYCustomWindows alloc] initWithDefaults:^(HSYCustomWindows *view) {
            [[view hsy_rac_removeAlert:YES] subscribeNext:^(UIView *view) {
                view.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMinScale+0.1);
            } completed:^{
                
            }];
        }];
        [[wt hsy_rac_showAlert] subscribeNext:^(UIView *view) {
            @strongify(self);
            view.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMaxScale + 0.1);
            self.test = view;
        } completed:^{
            [UIView animateWithDuration:0.2f animations:^{
                @strongify(self);
                self.test.transform = HSYCOCOAKIT_GGA_TRANSFORM_SCALE(kHSYCocoaKitMaxScale);
            }];
        }];
    }];
    
    
    UIButton *button = [NSObject createButtonByParam:@{} clickedOnSubscribeNext:^(UIButton *button) {
        NSLog(@"5555555555555555555");
    }];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 300, 60, 56);
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
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
    return self.hsy_viewModel.hsy_datas.count;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.toped && (scrollView.contentOffset.y >= (100-35))) {
        [self update:YES];
    } else if (self.tableView.tableHeaderView && (scrollView.contentOffset.y <= (100-35))) {
        self.headerView.hidden = YES;
    }
}

- (void)update:(BOOL)hidden
{
    if (hidden) {
        self.headerView.hidden = NO;
        self.tableView.tableHeaderView = nil;
        self.tableView.y = self.headerView.bottom;
        self.tableView.height = IPHONE_HEIGHT - self.tableView.y;
        [self.tableView setContentOffset:CGPointZero];
        self.toped = YES;
    } else {
        self.tableView.y = self.customNavigationBar.bottom;
        //滚动到顶部的动作不能真正滚动到contentOffset.y == 0.0f,而是应该预留一点位置，这样才会再执行“- scrollViewDidScroll:”的委托时，进入“else if”的判断中
        [self.tableView setContentOffset:CGPointMake(0, 0.5f) animated:YES];
        [CATransaction begin];
        @weakify(self);
        [CATransaction setCompletionBlock:^{
            @strongify(self);
            self.tableView.height = IPHONE_HEIGHT - self.tableView.y;
            self.headerView.hidden = YES;
            self.toped = NO;
        }];
        [self.tableView beginUpdates];
        self.tableView.tableHeaderView = self.tableHeaderView;
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

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
