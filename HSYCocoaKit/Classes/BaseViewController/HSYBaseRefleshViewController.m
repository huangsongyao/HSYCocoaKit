//
//  HSYBaseRefleshViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "HSYBaseRefleshViewController.h"
#import "HSYBaseRefleshModel.h"
#import "HSYHUDModel.h"
#import "PublicMacroFile.h"

@interface HSYBaseRefleshViewController ()

@property (nonatomic, strong) HSYBaseRefleshModel *refleshViewModel;

@end

@implementation HSYBaseRefleshViewController

- (instancetype)init
{
    if (self = [super init]) {
        _refleshViewModel = [[HSYBaseRefleshModel alloc] init];
        _showAllReflesh = NO;
        _showPullDown = NO;
        _showPullUp = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self);
    [[RACObserve(self, self.refleshViewModel.errorStatusCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        //监听请求失败允许做处理
        @strongify(self);
        switch ([self requestStateCodeWithStateCode:x]) {
            case kHSYHUDModelCodeTypeRequestFailure:
                [HSYHUDHelper showHUDViewForMessage:HSYLOCALIZED(@"请求失败")];
                break;
            case kHSYHUDModelCodeTypeSaveFileFailure:
                [HSYHUDHelper showHUDViewForMessage:HSYLOCALIZED(@"上传失败")];
                break;
                
            default:
                break;
        }
    }];
    if (self.showAllReflesh) {
        [self observePullDown];
        [self observePullUp];
    } else {
        if (self.showPullDown) {
            [self observePullDown];
        }
        if (self.showPullUp) {
            [self observePullUp];
        }
    }
}

- (void)observePullDown
{
    @weakify(self);
    [[RACObserve(self, self.refleshViewModel.pullDownStateCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        //监听下拉刷新
        @strongify(self);
        if ([self requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeRequestSuccess ||
            [self requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeSaveFileSuccess) {
            if (self.observeRefleshPullDown) {
                self.observeRefleshPullDown(x);
            }
        }
    }];
}

- (void)observePullUp
{
    @weakify(self);
    [[RACObserve(self, self.refleshViewModel.pullUpStateCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        //监听上拉刷新
        @strongify(self);
        if ([self requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeRequestSuccess ||
            [self requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeSaveFileSuccess) {
            if (self.observeRefleshPullUp) {
                self.observeRefleshPullUp(x);
            }
        }
    }];
}


@end
