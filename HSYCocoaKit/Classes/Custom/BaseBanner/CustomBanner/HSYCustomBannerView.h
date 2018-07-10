//
//  HSYCustomBannerView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
#import "HSYCustomBannerCell.h"

@interface HSYCustomBannerDataSourece : NSObject

@end

//***************************************************************************************

@class HSYCustomBannerView;
@protocol HSYCustomBannerViewDelegate <NSObject>

@optional
- (void)hsy_revisionBannerView:(HSYCustomBannerView *)bannerView didSelectPageAtIndex:(NSInteger)page;
- (void)hsy_revisionBannerView:(HSYCustomBannerView *)bannerView didScrollPage:(NSInteger)page;

@end

@protocol HSYCustomBannerViewDataSource <NSObject>

- (NSInteger)hsy_numberOfPagesInRevisionBannerView:(HSYCustomBannerView *)bannerView;
- (HSYCustomBannerBaseCell *)hsy_revisionBannerView:(HSYCustomBannerView *)bannerView cellForPageAtIndex:(NSInteger)index;
@optional
- (CGFloat)hsy_revisionBannerCellSpacing:(HSYCustomBannerView *)bannerView;

@end

@interface HSYCustomBannerView : UIView

@property (nonatomic, assign, setter=reloadCurrentPage:) NSInteger hsy_currentPage;
@property (nonatomic, strong, readonly) NSArray<HSYCustomBannerDataSourece *> *hsy_pages;
@property (nonatomic, weak, readonly) id<HSYCustomBannerViewDelegate>hsy_delegate;
@property (nonatomic, weak, readonly) id<HSYCustomBannerViewDataSource>hsy_dataSource;

- (instancetype)initWithFrame:(CGRect)frame
                        pages:(NSArray<HSYCustomBannerDataSourece *> *)pages
                     delegate:(id<HSYCustomBannerViewDelegate>)delegate
                   dataSource:(id<HSYCustomBannerViewDataSource>)dataSource;
@end
