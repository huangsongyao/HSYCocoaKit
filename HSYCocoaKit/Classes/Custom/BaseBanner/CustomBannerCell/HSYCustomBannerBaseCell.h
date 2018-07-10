//
//  HSYCustomBannerBaseCell.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import "HSYCustomGestureView.h"
#import "PublicMacroFile.h"
#import "Masonry.h"

@interface HSYCustomBannerCellContentView : HSYCustomGestureView 

- (instancetype)initWithSubscribeNext:(void(^)(id x))next;

@end

//******************************************************************************************

@class HSYCustomBannerBaseCell;
@protocol HSYCustomBannerBaseCellDelegate <NSObject>

- (void)hsy_customBannerBaseCell:(HSYCustomBannerBaseCell *)cell;

@end

@class HSYCustomBannerDataSourece;
@interface HSYCustomBannerBaseCell : UIView

@property (nonatomic, weak) id<HSYCustomBannerBaseCellDelegate>hsy_delegate;
@property (nonatomic, strong, readonly) HSYCustomBannerDataSourece *hsy_data;
@property (nonatomic, strong, readonly) HSYCustomBannerCellContentView *hsy_contentView;
- (instancetype)initWithData:(HSYCustomBannerDataSourece *)data;

@end
