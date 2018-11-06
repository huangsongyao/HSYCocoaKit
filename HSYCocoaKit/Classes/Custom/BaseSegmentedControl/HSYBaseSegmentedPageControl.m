//
//  HSYBaseSegmentedPageControl.m
//  Pods
//
//  Created by huangsongyao on 2018/4/24.
//
//

#import "HSYBaseSegmentedPageControl.h"
#import "UIView+Frame.h"
#import "NSObject+UIKit.h"
#import "PublicMacroFile.h"
#import "UIImage+Canvas.h"
#import "ReactiveCocoa.h"
#import "UIScrollView+Page.h"
#import "Masonry.h"

#define DEFAULT_LINE_SIZE                       CGSizeMake((self.scrollView.contentSizeWidth / self.segmentedButton.count), 1.0f)
#define DEFAULT_LINE_ANIMATION_DURATION         0.35f
#define DEFAULT_SCROLL_OFFSET_X                 50.0f

@interface HSYBaseSegmentedPageControl () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *selectedImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong, readonly) NSArray *pageControls;
@property (nonatomic, strong, readonly) NSDictionary<NSNumber *, id> *paramters;

@end

@implementation HSYBaseSegmentedPageControl

- (instancetype)initWithFrame:(CGRect)frame
                    paramters:(NSDictionary<NSNumber *, id> *)paramters
                 pageControls:(NSArray<NSString *> *)controls
                selectedBlock:(void(^)(HSYBaseCustomButton *button, NSInteger index))block
{
    if (self = [super initWithFrame:frame]) {
        _pageControls = controls;
        _paramters = paramters;
        _segmentedButton = [NSMutableArray arrayWithCapacity:controls.count];
        
        //创建背景图片
        [self hsy_backgroundImageView];
        
        //创建scrollview
        [self hsy_scrollView];
        
        //创建按钮属性集合
        CGFloat x = 0.0f;
        CGFloat w = self.hsy_button_w;
        CGFloat h = self.hsy_button_h;
        CGFloat itemSpacing = self.hsy_button_spacing;
        UIColor *selectedTitleColor = [self hsy_titleColorObjects].allKeys.firstObject;
        UIColor *normalTitleColor = [self hsy_titleColorObjects].allValues.firstObject;
        UIFont *selectedFont = [self hsy_titleFontObjects].allKeys.firstObject;
        UIFont *normalFont = [self hsy_titleFontObjects].allValues.firstObject;
        
        //默认的初始位置
        NSNumber *index = self.hsy_defaultsSelectedIndex;
        _selectedIndex = index.integerValue;
        
        @weakify(self);
        for (NSInteger i = 0; i < controls.count; i ++) {
            CGRect rect = CGRectMake(x, 0, w, h);
            CGRect imageRect = CGRectZero;
            CGRect titleRect = CGRectMake(0, 0, w, h);
            BOOL isSelectedButton = (i == index.integerValue);
            UIColor *titleColor = (isSelectedButton ? selectedTitleColor : normalTitleColor);
            UIFont *font = (isSelectedButton ? selectedFont : normalFont);
            NSString *title = controls[i];
            NSDictionary *dicButton = @{
                                        @(kHSYCocoaKitCustomButtonPropertyTypeTitle) : title,
                                        @(kHSYCocoaKitCustomButtonPropertyTypeFont) : font,
                                        @(kHSYCocoaKitCustomButtonPropertyTypeTextColor) : titleColor,
                                        @(kHSYCocoaKitCustomButtonPropertyTypeHighTextColor) : titleColor,
                                        };
            HSYBaseCustomButton *button = [HSYBaseCustomButton showCustomButtonForFrame:rect imageRect:imageRect titleRect:titleRect propertyEnum:dicButton didSelectedBlock:^(HSYBaseCustomButton *btn) {
                @strongify(self);
                if (block) {
                    [self hsy_scrollToSelected:btn animation:YES];
                    NSInteger index = [self.segmentedButton indexOfObject:btn];
                    block(btn, index);
                }
            }];
            button.selected = isSelectedButton;
            [self.scrollView addSubview:button];
            [self.segmentedButton addObject:button];
            x = button.right + itemSpacing;
        }
        CGFloat contentX = x > 0.0f ? (x - itemSpacing) : x;
        [self.scrollView setContentSize:CGSizeMake(contentX, self.height)];
        
        //底部的横线
        if ([paramters[@(kHSYCocoaKitCustomSegmentedTypeShowBottomLine)] boolValue]) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
            line.backgroundColor = (paramters[@(kHSYCocoaKitCustomSegmentedTypeBottomLineColor)] ? paramters[@(kHSYCocoaKitCustomSegmentedTypeBottomLineColor)] : RGB(204, 204, 204));
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom);
                make.centerX.equalTo(self.mas_centerX);
                CGSize size = CGSizeMake(IPHONE_WIDTH, 0.5f);
                if (paramters[@(kHSYCocoaKitCustomSegmentedTypeBottomLineSize)]) {
                    size = [paramters[@(kHSYCocoaKitCustomSegmentedTypeBottomLineSize)] CGSizeValue];
                }
                make.size.mas_equalTo(size);
            }];
        }
        //创建选中的下划线
        [self hsy_line];
    }
    return self;
}

#pragma mark - UI

- (void)hsy_line
{
    if (self.segmentedButton.count == 0) {
        return;
    }
    UIImage *image = [UIImage imageWithFillColor:SEGMENTED_CONTROL_DEFAULT_SELECTED_COLOR];
    if (self.paramters[@(kHSYCocoaKitCustomSegmentedTypeLineColor)]) {
        image = [UIImage imageWithFillColor:self.paramters[@(kHSYCocoaKitCustomSegmentedTypeLineColor)]];
    }
    NSDictionary *dic = @{
                          @(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image,
                          @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image,
                          };
    self.selectedImageView = [NSObject createImageViewByParam:dic];
    CGSize size = [self.paramters[@(kHSYCocoaKitCustomSegmentedTypeLineSize)] CGSizeValue];
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = DEFAULT_LINE_SIZE;
    }
    self.selectedImageView.size = size;
    if ([self.paramters[@(kHSYCocoaKitCustomSegmentedTypeLineRoundedCorners)] boolValue]) {
        self.selectedImageView.layer.cornerRadius = self.selectedImageView.height/2;
    }
    self.selectedImageView.y = (self.height - self.selectedImageView.height);
    NSNumber *index = @(self.selectedIndex);
    if (index.integerValue < self.segmentedButton.count) {
        [self hsy_scrollToSelected:self.segmentedButton[index.integerValue] animation:NO];
    }
    [self.scrollView addSubview:self.selectedImageView];
}

- (NSNumber *)hsy_defaultsSelectedIndex
{
    NSNumber *index = self.paramters[@(kHSYCocoaKitCustomSegmentedTypeSelectedIndex)];
    if (!index) {
        index = @(0);
    }
    return index;
}

- (void)hsy_backgroundImageView
{
    UIImage *image = self.paramters[@(kHSYCocoaKitCustomSegmentedTypeBackgroundImage)];
    if (!image) {
        image = [UIImage imageWithFillColor:WHITE_COLOR];
    }
    NSDictionary *dic = @{
                          @(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image,
                          @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image,
                          };
    self.backgroundImageView = [NSObject createImageViewByParam:dic];
    self.backgroundImageView.frame = self.bounds;
    [self addSubview:self.backgroundImageView];
}

- (void)hsy_scrollView
{
    NSDictionary *dicScroll = @{
                                @(kHSYCocoaKitOfScrollViewPropretyTypeFrame) : [NSValue valueWithCGRect:self.bounds],
                                @(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self,
                                @(kHSYCocoaKitOfScrollViewPropretyTypeBounces) : @(YES),
                                @(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator) : @(YES),
                                };
    _scrollView = [NSObject createScrollViewByParam:dicScroll];
    self.scrollView.backgroundColor = CLEAR_COLOR;
    [self addSubview:self.scrollView];
}

#pragma mark - Width && Height && Spacing

- (CGFloat)hsy_button_w
{
    CGSize size = [self.paramters[@(kHSYCocoaKitCustomSegmentedTypeButtonSize)] CGSizeValue];
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        return size.width;
    }
    return (self.width/self.pageControls.count);
}

- (CGFloat)hsy_button_h
{
    CGSize size = [self.paramters[@(kHSYCocoaKitCustomSegmentedTypeButtonSize)] CGSizeValue];
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        return size.height;
    }
    return self.height;
}

- (CGFloat)hsy_button_spacing
{
    CGFloat itemSpacing = [self.paramters[@(kHSYCocoaKitCustomSegmentedTypeButtonSpacing)] floatValue];
    if (itemSpacing > 0.0f) {
        return itemSpacing;
    }
    return 0.0f;
}

#pragma mark - Scroll Animation

- (void)hsy_scrollToSelected:(HSYBaseCustomButton *)button animation:(BOOL)animation
{
    if (!self.selectedImageView) {
        return;
    }
    NSTimeInterval duration = [self.paramters[@(kHSYCocoaKitCustomSegmentedTypeAnimationDuration)] floatValue];
    if (duration == 0.0f) {
        duration = DEFAULT_LINE_ANIMATION_DURATION;
    }
    for (HSYBaseCustomButton *btn in self.segmentedButton) {
        if ([button isEqual:btn]) {
            _selectedIndex = [self.segmentedButton indexOfObject:btn];
            break;
        }
    }
    [self hsy_scrollToLocation:button];
    CGFloat x = (button.x + self.lineOffsetX);
    if (animation) {
        @weakify(self);
        [UIView animateWithDuration:duration animations:^{
            @strongify(self);
            self.selectedImageView.x = x;
        } completion:^(BOOL finished) {
            @strongify(self);
            [self hsy_setButtonSelectedStatus:button];
        }];
    } else {
        self.selectedImageView.x = x;
        [self hsy_setButtonSelectedStatus:button];
    }
}

#pragma mark -Update Button Status

- (void)hsy_setButtonSelectedStatus:(HSYBaseCustomButton *)button
{
    UIColor *selectedTitleColor = [self hsy_titleColorObjects].allKeys.firstObject;
    UIColor *normalTitleColor = [self hsy_titleColorObjects].allValues.firstObject;
    
    UIFont *selectedFont = [self hsy_titleFontObjects].allKeys.firstObject;
    UIFont *normalFont = [self hsy_titleFontObjects].allValues.firstObject;
    
    for (HSYBaseCustomButton *btn in self.segmentedButton) {
        BOOL isButton = [btn isEqual:button];
        UIColor *titleColor = (isButton ? selectedTitleColor : normalTitleColor);
        UIFont *font = (isButton ? selectedFont : normalFont);
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitleColor:titleColor forState:UIControlStateHighlighted];
        btn.titleLabel.font = font;
        btn.selected = isButton;
    }
}

- (NSDictionary *)hsy_titleColorObjects
{
    UIColor *selectedTitleColor = self.paramters[@(kHSYCocoaKitCustomSegmentedTypeSelTitleColor)];
    if (!selectedTitleColor) {
        selectedTitleColor = SEGMENTED_CONTROL_DEFAULT_SELECTED_COLOR;
    }
    UIColor *normalTitleColor = self.paramters[@(kHSYCocoaKitCustomSegmentedTypeNorTitleColor)];
    if (!normalTitleColor) {
        normalTitleColor = BLACK_COLOR;
    }
    return @{selectedTitleColor : normalTitleColor};
}

- (NSDictionary *)hsy_titleFontObjects
{
    UIFont *normalFont = self.paramters[@(kHSYCocoaKitCustomSegmentedTypeTitleFont)];
    if (!normalFont) {
        normalFont = UI_SYSTEM_FONT_15;
    }
    UIFont *selectedFont = self.paramters[@(kHSYCocoaKitCustomSegmentedTypeSelectedTitleFont)];
    if (!selectedFont) {
        selectedFont = UI_SYSTEM_FONT_16;
    }
    return @{selectedFont : normalFont};
}

- (void)hsy_scrollToLocation:(HSYBaseCustomButton *)button
{
    CGFloat x = 0;
    if ((button.x - self.scrollView.contentOffset.x) < self.width/2) {
        if (self.selectedIndex > 0) {
            UIButton *preButton = self.segmentedButton[self.selectedIndex - 1];
            x = preButton.x;
            if (x > self.scrollView.contentOffset.x) {
                return;
            }
        } else {
            x = -DEFAULT_SCROLL_OFFSET_X;
        }
    } else {
        if ((self.selectedIndex + 1) < self.segmentedButton.count) {
            UIButton *nextButton = self.segmentedButton[(self.selectedIndex + 1)];
            x = nextButton.right - self.width;
            if (x < self.scrollView.contentOffset.x) {
                return;
            }
        } else {
            x = button.right;
        }
    }
    [self.scrollView scrollRectToVisible:CGRectMake(x, 0, self.scrollView.width, self.height) animated:YES];
}

#pragma mark - Observer UIScrollViewDelegate

- (void)hsy_setContentOffsetFromScale:(CGFloat)scale
{
    if (self.selectedImageView && scale < 0 && scale > 1.0f) {
        return;
    }
    CGFloat offsetX = self.lineOffsetX;
    CGFloat sumOffset = (self.scrollView.contentSizeWidth - offsetX*2 - self.selectedImageView.width);
    CGFloat x = offsetX + (sumOffset * scale);
    self.selectedImageView.x = x;
}

- (CGFloat)lineOffsetX
{
    CGFloat offsetX = ((self.scrollView.contentSizeWidth / self.segmentedButton.count) - self.selectedImageView.width)/2;
    return offsetX;
}

#pragma mark - Setting

- (void)setCurrentSelectedItem:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    if ((selectedIndex <= self.segmentedButton.count - 1) && selectedIndex >= 0) {
        [self hsy_scrollToSelected:self.segmentedButton[selectedIndex] animation:YES];
    }
}

#pragma mark - Load

- (CGSize)intrinsicContentSize
{
    if (@available(iOS 11.0, *)) {
        return UILayoutFittingExpandedSize;
    }
    return [super intrinsicContentSize];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@implementation HSYBaseSegmentedPageControl (Show)

+ (HSYBaseSegmentedPageControl *)hsy_showSegmentedPageControlFrame:(CGRect)frame
                                                         paramters:(NSDictionary<NSNumber *, id> *)paramters
                                                      pageControls:(NSArray<NSString *> *)controls
                                                     selectedBlock:(void(^)(HSYBaseCustomButton *button, NSInteger index))block
{
    HSYBaseSegmentedPageControl *control = [[HSYBaseSegmentedPageControl alloc] initWithFrame:frame paramters:paramters pageControls:controls selectedBlock:block];
    return control;
}

@end

