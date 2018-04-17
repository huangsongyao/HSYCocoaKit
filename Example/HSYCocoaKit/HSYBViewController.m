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

@interface TestBaseTableViewCell : HSYBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
- (void)setTestContent:(NSString *)content;

@end

@implementation TestBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.hsy_useFDTmplateLayout = YES;
        self.titleLabel = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeFrame) : [NSValue valueWithCGRect:self.contentView.bounds], @(kHSYCocoaKitOfLabelPropretyTypeMaxSize) : [NSValue valueWithCGSize:CGSizeMake(IPHONE_WIDTH, MAXFLOAT)],}];
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
    self.height = self.titleLabel.height;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [super sizeThatFits:size];
}

@end

@interface HSYBViewController ()

@end

@implementation HSYBViewController

- (void)viewDidLoad {
    self.hsy_viewModel = [[HSYViewControllerModel alloc] init];
    self.registerClasses = @{@"TestBaseTableViewCell" : @"uuuufffff"};
    [super viewDidLoad];
    
    [self hsy_rightItemsImages:@[@{@(kHSYCustomBarButtonItemTagBack) : @"nav_back@2x"}] subscribeNext:^(UIButton *button, kHSYCustomBarButtonItemTag tag) {
        
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UINavigationItem *view in self.customNavigationBar.items) {
        NSLog(@"view = %@, leftBarButtonItems = %@, backIndicatorImage = %@", view, view.leftBarButtonItems, self.customNavigationBar.backIndicatorImage);
    }
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self hsy_heightForCellWithCacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        TestBaseTableViewCell *realCell = (TestBaseTableViewCell *)cell;
        [realCell setTestContent:self.hsy_viewModel.hsy_datas[indexPath.row]];
    }];
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
