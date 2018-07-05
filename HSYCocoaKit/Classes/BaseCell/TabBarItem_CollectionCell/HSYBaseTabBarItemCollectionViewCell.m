//
//  HSYBaseTabBarItemCollectionViewCell.m
//  Pods
//
//  Created by huangsongyao on 2018/5/3.
//
//

#import "HSYBaseTabBarItemCollectionViewCell.h"
#import "HSYBaseTabBarModel.h"
#import "NSObject+UIKit.h"
#import "Masonry.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"
#import "HSYBaseTabBarViewController.h"

CGFloat const kHSYCocoaKitMaxRedPointHeight = 16.0f;
CGFloat const kHSYCocoaKitMinRedPointHeight = 7.0f;

@interface HSYBaseTabBarItemCollectionViewCell ()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, strong) UILabel *redPointLabel;
@property (nonatomic, assign, readonly) CGFloat maxRedPointWidth;

@end

@implementation HSYBaseTabBarItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = CLEAR_COLOR;
        self.contentView.backgroundColor = CLEAR_COLOR;
        
        CGSize imageSize = [HSYBaseTabBarViewController hsy_loadItemImageSize];
        CGFloat imageOffsetTop = [HSYBaseTabBarViewController hsy_loadItemImageOffsetTop];
        CGFloat labelOffsetTop = [HSYBaseTabBarViewController hsy_loadItemLabelOffsetTop];
        CGFloat redPointOffsetTop = [HSYBaseTabBarViewController hsy_loadItemRedPointOffsetTop];
        
        self.itemImageView = [NSObject createImageViewByParam:@{}];
        [self.contentView addSubview:self.itemImageView];
        [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(imageOffsetTop);
            make.size.mas_equalTo(imageSize);
        }];
        
        self.itemTitleLabel = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_SYSTEM_FONT_10, @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter),}];
        [self.contentView addSubview:self.itemTitleLabel];
        [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.itemImageView.mas_bottom).offset(labelOffsetTop);
            make.left.equalTo(self.contentView.mas_left);
            make.size.mas_equalTo(CGSizeMake(self.contentView.width, [HSYBaseTabBarViewController hsy_loadItemLabelHeight]));
        }];
        
        self.redPointLabel = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeBackgroundColor) : [UIColor redColor], @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter), @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_RED_POINT_FONT, @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : WHITE_COLOR}];
        [self.contentView addSubview:self.redPointLabel];
        self.redPointLabel.origin = CGPointMake(self.width/2 + [HSYBaseTabBarViewController hsy_loadItemRedPointCentryRight], redPointOffsetTop);
        self.redPointLabel.size = CGSizeMake(0, kHSYCocoaKitMaxRedPointHeight);
        self.redPointLabel.layer.masksToBounds = YES;
        self.redPointLabel.clipsToBounds = YES;
        
        _maxRedPointWidth = (self.width - self.redPointLabel.x - 15.0f);
    }
    return self;
}

- (void)setTabBarItem:(HSYBaseTabBarConfigItem *)configItem
{
    _configItem = configItem;
    UIImage *image = (configItem.selectedItem ? configItem.selectedImage : configItem.normalImage);
    self.itemImageView.image = image;
    self.itemImageView.highlightedImage = image;
    UIColor *titleColor = (configItem.selectedItem ? configItem.selectedColor : configItem.normalColor);
    self.itemTitleLabel.textColor = titleColor;
    UIFont *titleFont = (configItem.selectedItem ? configItem.normalFont : configItem.selectedFont);
    self.itemTitleLabel.font = titleFont;
    self.itemTitleLabel.text = configItem.title;
    self.redPointLabel.text = configItem.redPointString;
    self.redPointLabel.size = [configItem hsy_redPointWidth:self.maxRedPointWidth];
    self.redPointLabel.layer.cornerRadius = self.redPointLabel.height/2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
