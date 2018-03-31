//
//  NSString+Size.m
//  Pods
//
//  Created by huangsongyao on 2017/8/24.
//
//

#import "NSString+Size.h"
#import "PublicMacroFile.h"

@implementation NSString (Size)

+ (CGSize)contentOfSize:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height
{
    if (text.length == 0 || !font) {
        return CGSizeZero;
    }
    
    if (height == 0) {
        height = MAXFLOAT;
    }
    if (width == 0) {
        width = IPHONE_WIDTH;
    }
    NSDictionary * dic = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:CGSizeMake(width, height)
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:dic
                              context:nil].size;
}

- (CGSize)contentOfSize:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height
{
    return [self.class contentOfSize:self
                                font:font
                            maxWidth:width
                           maxHeight:height];
}

@end
