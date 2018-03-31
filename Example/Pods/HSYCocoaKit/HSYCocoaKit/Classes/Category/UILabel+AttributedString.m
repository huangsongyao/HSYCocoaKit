//
//  UILabel+AttributedString.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "UILabel+AttributedString.h"

@implementation UILabel (AttributedString)

+ (NSMutableAttributedString *)setLabelRTFAttributedDic:(NSDictionary *)attributedDic attributedString:(NSString *)attributedString range:(NSRange)range
{
    if (!attributedDic || !attributedString || range.length == 0) {
        return nil;
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:attributedString];
    for (int i = 0; i < attributedDic.allKeys.count; i ++) {
        NSString *key = attributedDic.allKeys[i];
        NSString *value = attributedDic[key];
        [attributedStr addAttribute:key
                              value:value
                              range:range];
    }
    
    
    return attributedStr;
}

@end
