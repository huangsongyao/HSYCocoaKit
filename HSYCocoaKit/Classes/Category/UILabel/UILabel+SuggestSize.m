//
//  UILabel+SuggestSize.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "UILabel+SuggestSize.h"
#import "NSString+Size.h"
#import "UIView+Frame.h"
#import "PublicMacroFile.h"

@implementation UILabel (SuggestSize)

+ (UILabel *)initWithText:(NSString *)text
            numberOfLines:(NSInteger)numberOfLines
                     font:(UIFont *)font
                 maxWidth:(CGFloat)width
                maxHeight:(CGFloat)height
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.font = font;
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.numberOfLines = numberOfLines;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSString *string = text;
    if (label.numberOfLines == 1) {
        if (string.length == 0) {
            string = HSYLOCALIZED(@"单行");
        }
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    label.size = [string contentOfSize:label.font
                              maxWidth:width
                             maxHeight:height];
    
    return label;
}

+ (UILabel *)initWithText:(NSString *)text
                     font:(UIFont *)font
                 maxWidth:(CGFloat)width
                maxHeight:(CGFloat)height
{
    return [self.class initWithText:text
                      numberOfLines:0
                               font:font
                           maxWidth:width
                          maxHeight:height];
}

+ (UILabel *)initWithUnilineText:(NSString *)text
                            font:(UIFont *)font
                        maxWidth:(CGFloat)width
                       maxHeight:(CGFloat)height
{
    return [self.class initWithText:text
                      numberOfLines:1
                               font:font
                           maxWidth:width
                          maxHeight:height];
}

@end

