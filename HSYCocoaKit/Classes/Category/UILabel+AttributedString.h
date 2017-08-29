//
//  UILabel+AttributedString.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (AttributedString)

/**
 *  富文本
 *
 *  @param attributedDic    富文本设置的相关数据，格式为：@{ NSForegroundColorAttributeName : THEME_COLOR, NSFontAttributeName : TITLE_FONT, }
 *  @param attributedString 重组后的字符串
 *  @param range            实现富文本效果的NSRang位置
 *
 *  @return NSAttributedString
 */
+ (NSMutableAttributedString *)setLabelRTFAttributedDic:(NSDictionary *)attributedDic attributedString:(NSString *)attributedString range:(NSRange)range;


@end
