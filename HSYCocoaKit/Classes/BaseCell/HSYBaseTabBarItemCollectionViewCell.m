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

@interface HSYBaseTabBarItemCollectionViewCell ()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;

@end

@implementation HSYBaseTabBarItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.itemImageView = [NSObject createImageViewByParam:@{}];
        [self.contentView addSubview:self.itemImageView];
        [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(2.0f);
            make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        }];
        self.itemTitleLabel = [NSObject createLabelByParam:@{@(kHSYCocoaKitOfLabelPropretyTypeTextFont) : UI_SYSTEM_FONT_10, @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter),}];
        [self.contentView addSubview:self.itemTitleLabel];
        [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.itemImageView.mas_bottom).offset(2.0f);
            make.left.equalTo(self.contentView.mas_left);
            make.size.mas_equalTo(CGSizeMake(self.contentView.width, UI_SYSTEM_FONT_10.pointSize));
        }];
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
    self.itemTitleLabel.text = configItem.title;
    self.itemTitleLabel.textColor = titleColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
