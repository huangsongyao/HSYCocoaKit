//
//  HSYCocoaKitAttributedLabelManager.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/8/7.
//

#import "HSYCocoaKitAttributedLabelManager.h"
#import "NSString+Replace.h"
#import "UIView+Frame.h"
#import "PublicMacroFile.h"
#import "NSObject+Runtime.h"
#import "NSFileManager+Finder.h"
#import "NSBundle+PrivateFileResource.h"

//********************************************************************************************************

static NSDictionary *hsy_simplified = nil;
static NSDictionary *hsy_emoji = nil;

@implementation NSDictionary (Emoji)

+ (NSDictionary *)toSimplified
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hsy_simplified =  [NSDictionary toSimplifieds];
    });
    return hsy_simplified;
}

+ (NSDictionary *)toEmoji
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hsy_emoji =  [NSDictionary toEmojis];
    });
    return hsy_emoji;
}

+ (NSDictionary *)toSimplifieds
{
    NSDictionary *simplified = @{
                                 @"emoji_001" : @"[微笑]",
                                 @"emoji_002" : @"[撇嘴]",
                                 @"emoji_003" : @"[色]",
                                 @"emoji_004" : @"[发呆]",
                                 @"emoji_005" : @"[得意]",
                                 @"emoji_006" : @"[流泪]",
                                 @"emoji_007" : @"[害羞]",
                                 @"emoji_008" : @"[闭嘴]",
                                 @"emoji_009" : @"[睡]",
                                 @"emoji_010" : @"[大哭]",
                                 @"emoji_011" : @"[尴尬]",
                                 @"emoji_012" : @"[发怒]",
                                 @"emoji_013" : @"[调皮]",
                                 @"emoji_014" : @"[呲牙]",
                                 @"emoji_015" : @"[惊讶]",
                                 @"emoji_016" : @"[难过]",
                                 @"emoji_017" : @"[酷]",
                                 @"emoji_018" : @"[冷汗]",
                                 @"emoji_019" : @"[抓狂]",
                                 @"emoji_020" : @"[吐]",
                                 @"emoji_021" : @"[偷笑]",
                                 @"emoji_022" : @"[愉快]",
                                 @"emoji_023" : @"[白眼]",
                                 @"emoji_024" : @"[傲慢]",
                                 @"emoji_025" : @"[饥饿]",
                                 @"emoji_026" : @"[困]",
                                 @"emoji_027" : @"[惊恐]",
                                 @"emoji_028" : @"[流汗]",
                                 @"emoji_029" : @"[憨笑]",
                                 @"emoji_030" : @"[悠闲]",
                                 @"emoji_031" : @"[奋斗]",
                                 @"emoji_032" : @"[咒骂]",
                                 @"emoji_033" : @"[疑问]",
                                 @"emoji_034" : @"[嘘]",
                                 @"emoji_035" : @"[晕]",
                                 @"emoji_036" : @"[疯了]",
                                 @"emoji_037" : @"[衰]",
                                 @"emoji_038" : @"[骷髅]",
                                 @"emoji_039" : @"[敲打]",
                                 @"emoji_040" : @"[再见]",
                                 @"emoji_041" : @"[擦汗]",
                                 @"emoji_042" : @"[抠鼻]",
                                 @"emoji_043" : @"[鼓掌]",
                                 @"emoji_044" : @"[糗大了]",
                                 @"emoji_045" : @"[坏笑]",
                                 @"emoji_046" : @"[左哼哼]",
                                 @"emoji_047" : @"[右哼哼]",
                                 @"emoji_048" : @"[哈欠]",
                                 @"emoji_049" : @"[鄙视]",
                                 @"emoji_050" : @"[委屈]",
                                 @"emoji_051" : @"[快哭了]",
                                 @"emoji_052" : @"[阴险]",
                                 @"emoji_053" : @"[亲亲]",
                                 @"emoji_054" : @"[吓]",
                                 @"emoji_055" : @"[可怜]",
                                 @"emoji_056" : @"[菜刀]",
                                 @"emoji_057" : @"[西瓜]",
                                 @"emoji_058" : @"[啤酒]",
                                 @"emoji_059" : @"[篮球]",
                                 @"emoji_060" : @"[乒乓]",
                                 @"emoji_061" : @"[咖啡]",
                                 @"emoji_062" : @"[饭]",
                                 @"emoji_063" : @"[猪头]",
                                 @"emoji_064" : @"[玫瑰]",
                                 @"emoji_065" : @"[凋谢]",
                                 @"emoji_066" : @"[嘴唇]",
                                 @"emoji_067" : @"[爱心]",
                                 @"emoji_068" : @"[心碎]",
                                 @"emoji_069" : @"[蛋糕]",
                                 @"emoji_070" : @"[闪电]",
                                 @"emoji_071" : @"[炸弹]",
                                 @"emoji_072" : @"[刀]",
                                 @"emoji_073" : @"[足球]",
                                 @"emoji_074" : @"[瓢虫]",
                                 @"emoji_075" : @"[便便]",
                                 @"emoji_076" : @"[月亮]",
                                 @"emoji_077" : @"[太阳]",
                                 @"emoji_078" : @"[礼物]",
                                 @"emoji_079" : @"[拥抱]",
                                 @"emoji_080" : @"[强]",
                                 @"emoji_081" : @"[弱]",
                                 @"emoji_082" : @"[握手]",
                                 @"emoji_083" : @"[胜利]",
                                 @"emoji_084" : @"[抱拳]",
                                 @"emoji_085" : @"[勾引]",
                                 @"emoji_086" : @"[拳头]",
                                 @"emoji_087" : @"[差劲]",
                                 @"emoji_088" : @"[爱你]",
                                 @"emoji_089" : @"[NO]",
                                 @"emoji_090" : @"[OK]",
                                 @"emoji_091" : @"[双喜]",
                                 @"emoji_092" : @"[鞭炮]",
                                 @"emoji_093" : @"[灯笼]",
                                 @"emoji_094" : @"[发财]",
                                 @"emoji_095" : @"[K歌]",
                                 @"emoji_096" : @"[购物]",
                                 @"emoji_097" : @"[邮件]",
                                 @"emoji_098" : @"[帅]",
                                 @"emoji_099" : @"[喝彩]",
                                 @"emoji_100" : @"[祈祷]",
                                 @"emoji_101" : @"[爆筋]",
                                 @"emoji_102" : @"[棒棒糖]",
                                 @"emoji_103" : @"[喝奶]",
                                 @"emoji_104" : @"[下面]",
                                 @"emoji_105" : @"[香蕉]",
                                 @"emoji_106" : @"[飞机]",
                                 @"emoji_107" : @"[开车]",
                                 @"emoji_108" : @"[高铁左车头]",
                                 @"emoji_109" : @"[车厢]",
                                 @"emoji_110" : @"[高铁右车头]",
                                 @"emoji_111" : @"[多云]",
                                 @"emoji_112" : @"[下雨]",
                                 @"emoji_113" : @"[钞票]",
                                 @"emoji_114" : @"[熊猫]",
                                 @"emoji_115" : @"[灯泡]",
                                 @"emoji_116" : @"[风车]",
                                 @"emoji_117" : @"[闹钟]",
                                 @"emoji_118" : @"[打伞]",
                                 @"emoji_119" : @"[气球]",
                                 @"emoji_120" : @"[戒指]",
                                 @"emoji_121" : @"[沙发]",
                                 @"emoji_122" : @"[纸巾]",
                                 @"emoji_123" : @"[药]",
                                 @"emoji_124" : @"[手枪]",
                                 @"emoji_125" : @"[青蛙]",
                                 };
    return simplified;
}

+ (NSDictionary *)toEmojis
{
    NSDictionary *emojis = @{
                             @"[微笑]" : @"emoji_001",
                             @"[撇嘴]" : @"emoji_002",
                             @"[色]" : @"emoji_003",
                             @"[发呆]" : @"emoji_004",
                             @"[得意]" : @"emoji_005",
                             @"[流泪]" : @"emoji_006",
                             @"[害羞]" : @"emoji_007",
                             @"[闭嘴]" : @"emoji_008",
                             @"[睡]" : @"emoji_009",
                             @"[大哭]" : @"emoji_010",
                             @"[尴尬]" : @"emoji_011",
                             @"[发怒]" : @"emoji_012",
                             @"[调皮]" : @"emoji_013",
                             @"[呲牙]" : @"emoji_014",
                             @"[惊讶]" : @"emoji_015",
                             @"[难过]" : @"emoji_016",
                             @"[酷]" : @"emoji_017",
                             @"[冷汗]" : @"emoji_018",
                             @"[抓狂]" : @"emoji_019",
                             @"[吐]" : @"emoji_020",
                             @"[偷笑]" : @"emoji_021",
                             @"[愉快]" : @"emoji_022",
                             @"[白眼]" : @"emoji_023",
                             @"[傲慢]" : @"emoji_024",
                             @"[饥饿]" : @"emoji_025",
                             @"[困]" : @"emoji_026",
                             @"[惊恐]" : @"emoji_027",
                             @"[流汗]" : @"emoji_028",
                             @"[憨笑]" : @"emoji_029",
                             @"[悠闲]" : @"emoji_030",
                             @"[奋斗]" : @"emoji_031",
                             @"[咒骂]" : @"emoji_032",
                             @"[疑问]" : @"emoji_033",
                             @"[嘘]" : @"emoji_034",
                             @"[晕]" : @"emoji_035",
                             @"[疯了]" : @"emoji_036",
                             @"[衰]" : @"emoji_037",
                             @"[骷髅]" : @"emoji_038",
                             @"[敲打]" : @"emoji_039",
                             @"[再见]" : @"emoji_040",
                             @"[擦汗]" : @"emoji_041",
                             @"[抠鼻]" : @"emoji_042",
                             @"[鼓掌]" : @"emoji_043",
                             @"[糗大了]" : @"emoji_044",
                             @"[坏笑]" : @"emoji_045",
                             @"[左哼哼]" : @"emoji_046",
                             @"[右哼哼]" : @"emoji_047",
                             @"[哈欠]" : @"emoji_048",
                             @"[鄙视]" : @"emoji_049",
                             @"[委屈]" : @"emoji_050",
                             @"[快哭了]" : @"emoji_051",
                             @"[阴险]" : @"emoji_052",
                             @"[亲亲]" : @"emoji_053",
                             @"[吓]" : @"emoji_054",
                             @"[可怜]" : @"emoji_055",
                             @"[菜刀]" : @"emoji_056",
                             @"[西瓜]" : @"emoji_057",
                             @"[啤酒]" : @"emoji_058",
                             @"[篮球]" : @"emoji_059",
                             @"[乒乓]" : @"emoji_060",
                             @"[咖啡]" : @"emoji_061",
                             @"[饭]" : @"emoji_062",
                             @"[猪头]" : @"emoji_063",
                             @"[玫瑰]" : @"emoji_064",
                             @"[凋谢]" : @"emoji_065",
                             @"[嘴唇]" : @"emoji_066",
                             @"[爱心]" : @"emoji_067",
                             @"[心碎]" : @"emoji_068",
                             @"[蛋糕]" : @"emoji_069",
                             @"[闪电]" : @"emoji_070",
                             @"[炸弹]" : @"emoji_071",
                             @"[刀]" : @"emoji_072",
                             @"[足球]" : @"emoji_073",
                             @"[瓢虫]" : @"emoji_074",
                             @"[便便]" : @"emoji_075",
                             @"[月亮]" : @"emoji_076",
                             @"[太阳]" : @"emoji_077",
                             @"[礼物]" : @"emoji_078",
                             @"[拥抱]" : @"emoji_079",
                             @"[强]" : @"emoji_080",
                             @"[弱]" : @"emoji_081",
                             @"[握手]" : @"emoji_082",
                             @"[胜利]" : @"emoji_083",
                             @"[抱拳]" : @"emoji_084",
                             @"[勾引]" : @"emoji_085",
                             @"[拳头]" : @"emoji_086",
                             @"[差劲]" : @"emoji_087",
                             @"[爱你]" : @"emoji_088",
                             @"[NO]" : @"emoji_089",
                             @"[OK]" : @"emoji_090",
                             @"[双喜]" : @"emoji_091",
                             @"[鞭炮]" : @"emoji_092",
                             @"[灯笼]" : @"emoji_093",
                             @"[发财]" : @"emoji_094",
                             @"[K歌]" : @"emoji_095",
                             @"[购物]" : @"emoji_096",
                             @"[邮件]" : @"emoji_097",
                             @"[帅]" : @"emoji_098",
                             @"[喝彩]" : @"emoji_099",
                             @"[祈祷]" : @"emoji_100",
                             @"[爆筋]" : @"emoji_101",
                             @"[棒棒糖]" : @"emoji_102",
                             @"[喝奶]" : @"emoji_103",
                             @"[下面]" : @"emoji_104",
                             @"[香蕉]" : @"emoji_105",
                             @"[飞机]" : @"emoji_106",
                             @"[开车]" : @"emoji_107",
                             @"[高铁左车头]" : @"emoji_108",
                             @"[车厢]" : @"emoji_109",
                             @"[高铁右车头]" : @"emoji_110",
                             @"[多云]" : @"emoji_111",
                             @"[下雨]" : @"emoji_112",
                             @"[钞票]" : @"emoji_113",
                             @"[熊猫]" : @"emoji_114",
                             @"[灯泡]" : @"emoji_115",
                             @"[风车]" : @"emoji_116",
                             @"[闹钟]" : @"emoji_117",
                             @"[打伞]" : @"emoji_118",
                             @"[气球]" : @"emoji_119",
                             @"[戒指]" : @"emoji_120",
                             @"[沙发]" : @"emoji_121",
                             @"[纸巾]" : @"emoji_122",
                             @"[药]" : @"emoji_123",
                             @"[手枪]" : @"emoji_124",
                             @"[青蛙]" : @"emoji_125",
                             };
    return emojis;
}

@end

//********************************************************************************************************

@implementation TYAttributedLabel (Reset)

- (NSMutableDictionary *)reloadAttributed:(id)newAttributed
{
    NSMutableDictionary *textContainerParamter = self.textContainer.toRuntimeMutableDictionary;
    [textContainerParamter removeObjectsForKeys:@[@"text", @"attributedText", ]];
    if ([newAttributed isKindOfClass:[NSAttributedString class]]) {
        textContainerParamter[@"attributedText"] = newAttributed;
    } else {
        textContainerParamter[@"text"] = newAttributed;
    }
    return textContainerParamter;
}

- (void)reloadNewTextContainer:(TYTextContainer *)textContainer
{
    if (textContainer) {
        self.textContainer = textContainer;
        self.height = [self getSizeWithWidth:self.width].height;
    }
}

- (void)reloadAttributed:(id)newAttributed locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter
{
    NSMutableDictionary *textContainerParamter = [self reloadAttributed:newAttributed];
    TYTextContainer *newTextContainer = [HSYCocoaKitAttributedLabelManager hsy_baseTextContainer:textContainerParamter locationSymbolParamter:symbolParamter displayWidth:self.textContainer.textWidth];
    [self reloadNewTextContainer:newTextContainer];
}

- (void)reloadEmojisAttributed:(id)newAttributed
{
    NSMutableDictionary *textContainerParamter = [self reloadAttributed:newAttributed];
    TYTextContainer *newTextContainer = [HSYCocoaKitAttributedLabelManager hsy_emojisTextContainer:textContainerParamter displayWidth:self.textContainer.textWidth];
    [self reloadNewTextContainer:newTextContainer];
}

@end

//********************************************************************************************************

@interface TYTextContainer (Reset)

/**
 将特殊字符串动态替换为指定的UIView，实现文字+UIView的动态混排，只支持单一特殊占位符
 
 @param symbolParamter 格式：@{@"特殊占位符" : @[UIView_1, UIView_2, UIView_3, ]}
 */
- (void)resetSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter;

/**
 定制用于通用的001-125号emoji表情符和text的混排
 */
- (void)resetSymbolParamterEmojis;

@end

@implementation TYTextContainer (Reset)

- (void)resetSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter
{
    //遍历并获取字符串中所有用于占位的特殊符号，并将其替换为对应的view，用于只存在一种类型的占位符
    NSString *symbol = symbolParamter.allKeys.firstObject;
    NSArray<NSValue *> *locations = [self.text allSymbolLocations:symbol];
    if (locations.count > 0) {
        NSArray<UIView *> *views = symbolParamter.allValues.firstObject;
        for (NSValue *value in locations) {
            [self addView:views[[locations indexOfObject:value]] range:value.rangeValue];
        }
    }
}

- (void)resetSymbolParamterEmojis
{
    NSDictionary *simplified = NSDictionary.toSimplified;
    NSDictionary *emojis = NSDictionary.toEmoji;
    for (NSString *symbol in simplified.allValues) {
        NSArray<NSValue *> *locations = [self.text allSymbolLocations:symbol];
        if (locations.count > 0) {
            UIImage *image = [NSBundle imageForBundle:emojis[symbol]];
            for (NSValue *value in locations) {
                [self addImage:image range:value.rangeValue size:image.size alignment:TYDrawAlignmentCenter];
            }
        }
    }
}

@end

//********************************************************************************************************

@implementation HSYCocoaKitAttributedLabelManager

+ (TYAttributedLabel *)hsy_baseAttributedLabel:(NSDictionary *)textContainerParamter locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter displayWidth:(CGFloat)width
{
    //文本生成器
    TYTextContainer *textContainer = [self.class hsy_baseTextContainer:textContainerParamter locationSymbolParamter:symbolParamter displayWidth:width];
    
    //通过TYTextContainer的方法动态将真正的height计算出来，并更新高度
    TYAttributedLabel *attributedLabel = [[TYAttributedLabel alloc] init];
    attributedLabel.textContainer = textContainer;
    CGSize size = [attributedLabel getSizeWithWidth:width];
    attributedLabel.size = size;
    
    return attributedLabel;
}

+ (TYTextContainer *)hsy_baseTextContainer:(NSDictionary *)textContainerParamter locationSymbolParamter:(NSDictionary<NSString *, NSArray<UIView *> *> *)symbolParamter displayWidth:(CGFloat)width
{
    TYTextContainer *textContainer = [self.class hsy_baseTextContainer:textContainerParamter displayWidth:width];
    //遍历并获取字符串中所有用于占位的特殊符号，并将其替换为对应的view
    [textContainer resetSymbolParamter:symbolParamter];
    return textContainer;
}

+ (TYTextContainer *)hsy_emojisTextContainer:(NSDictionary *)textContainerParamter displayWidth:(CGFloat)width
{
    NSMutableDictionary *realTextContainerParamter = [NSMutableDictionary dictionaryWithDictionary:textContainerParamter];
    if (!textContainerParamter[@"font"]) {
        //如果不设置，则给一个默认适合的文本字号，用于搭配TYDrawAlignmentCenter模式
        realTextContainerParamter[@"font"] = UI_SYSTEM_FONT_16;
    }
    TYTextContainer *textContainer = [self.class hsy_baseTextContainer:realTextContainerParamter displayWidth:width];
    [textContainer resetSymbolParamterEmojis];
    return textContainer;
}

+ (TYTextContainer *)hsy_baseTextContainer:(NSDictionary *)textContainerParamter displayWidth:(CGFloat)width
{
    //利用kvc动态setValue
    TYTextContainer *textContainer = [[TYTextContainer alloc] createTextContainerWithTextWidth:width];
    for (NSString *key in textContainerParamter.allKeys) {
        id value = textContainerParamter[key];
        [textContainer setValue:value forKey:key];
    }
    return textContainer;
}

@end
