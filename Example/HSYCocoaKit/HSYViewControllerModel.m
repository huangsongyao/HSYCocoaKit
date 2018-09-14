//
//  HSYViewControllerModel.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/4/2.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYViewControllerModel.h"
#import "HSYCocoaKitSocketManager.h"
#import "HSYBaseLaunchScreenViewController.h"

@implementation TestJ_SubModel


@end

@implementation TestJ_Model


@end


@implementation HSYNetWorkingManager (test)

- (RACSignal *)test:(NSString *)path
{
    return [self.httpSessionManager hsy_rac_getRequest:path parameters:nil];
}

@end


@implementation HSYViewControllerModel

- (instancetype)init
{
    if (self = [super init]) {
        
        [[[self testRequest] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            
        }];
//        @weakify(self);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            @strongify(self);
//            NSString *urlStr = @"http://study.scho.com/front/task/getTasks?companyId=0&userId=1&page=1&pageSize=10";
////            NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
//            [self hsy_requestNetwork:^RACSignal *{
//                return [[HSYNetWorkingManager shareInstance] test:urlStr];
//            } toMap:^id(RACTuple *tuple) {
//                id json = tuple.second;
//                return [NSObject hsy_resultObjectToJSONModelWithClasses:[TestJ_Model class] json:json];
//            } subscriberNext:^BOOL(id x) {
//                NSLog(@"x = %@", x);
//                return YES;
//            }];
//        });
        
    
//        NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
//        [self updateNext:^RACSignal *{
//            return [[HSYNetWorkingManager shareInstance] test:urlStr];
//        } toMap:^NSMutableArray *(RACTuple *tuple) {
//            NSMutableArray *array = [[NSMutableArray alloc] init];
//            id json = tuple.second;
//            [array addObject:[NSObject resultObjectToJSONModelWithClasses:[TestJ_Model class] json:json]];
//            return array;
//        } pullDown:kHSYReflesStatusTypePullDown];
        
        
//        [self.subject subscribeNext:^(id x) {
//            NSLog(@"");
//        }];
//        [self.subject subscribeNext:^(id x) {
//            NSLog(@"");
//        }];
//        
//        [self.subject sendNext:@"1"];
        
        
//        [self test];
    }
    return self;
}

- (void)sendObjectComplted:(id)x
{
    
}

- (RACSignal *)testRequest
{
    NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self hsy_requestNetwork:^RACSignal *{
            RACSignal *signal = [[HSYNetWorkingManager shareInstance] test:urlStr];
            return signal;
        } toMap:^id(RACTuple *tuple) {
            id json = tuple.second;
            return [NSObject hsy_resultObjectToJSONModelWithClasses:[TestJ_Model class] json:json];
        } subscriberNext:^BOOL(id x) {
            NSLog(@"\n x1 = %@", x);
            return YES;
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
//    NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"image/jpeg", @"text/plain", nil];
//    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObject = %@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error = %@", error);
//    }];
}

- (RACSignal *)hsy_rac_pullDownMethod
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
        [self hsy_pullRefresh:kHSYReflesStatusTypePullDown updateNext:^RACSignal *{
            return [[HSYNetWorkingManager shareInstance] test:urlStr];
        } toMap:^NSMutableArray *(RACTuple *tuple) {
            return [self datas];
        } subscriberNext:^(id x, NSError *error) {
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

- (RACSignal *)hsy_rac_pullUpMethod
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *urlStr = @"http://api.artvoice.com.cn:8080/driver/get_last_driver?hardware=100";
        [self hsy_refreshToPullUp:^RACSignal *{
            return [[HSYNetWorkingManager shareInstance] test:urlStr];
        } toMap:^NSMutableArray *(RACTuple *tuple) {
            if (self.hsy_datas.count > 0) {
                return [@[] mutableCopy];
            }
            return [self datas];
        } subscriberNext:^(NSMutableArray *x, NSError *error) {
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}


- (NSMutableArray *)datas
{
    return [@[
              @"1",
              @"2",
              @"3",
              @"4",
              @"5",
              @"6",
              @"7",
              @"8",
              @"9",
              @"10",
              @"11",
              @"12",
              @"13",
              ] mutableCopy];
    
//    return [@[
//              @"庆历四年春，滕子京谪守巴陵郡。越明年，政通人和，百废具兴，乃重修岳阳楼，增其旧制，刻唐贤今人诗赋于其上。属（zhǔ）予(yǔ)作文以记之。予观夫fú）巴陵胜状，在洞庭一湖。衔远山，吞长江，浩浩汤汤(shāng）（shang），横无际涯朝晖夕阴，气象万千；此则岳阳楼之大观也，前人之述备矣。然则北通巫峡，南极潇湘，迁客骚人，多会于此，览物之情，得无异乎？若夫淫(yín)雨霏霏，连月不开；阴风怒号，浊浪排空；日星隐曜，山岳潜形；商旅不行，樯（qiáng）倾楫摧；薄(bó)暮冥冥，虎啸猿啼。登斯楼也，则有去国怀乡，忧谗畏讥，满目萧然，感极而悲者矣！至若春和景明，波澜不惊，上下天光，一碧万顷(qǐng)；沙鸥翔集，锦鳞游泳，岸芷汀（tīng）兰，郁郁青青。而或长烟一空，皓月千里，浮光跃金，静影沉璧，渔歌互答，此乐何极！登斯楼也，则有心旷神怡，宠辱偕(xié)忘，把酒临风，其喜洋洋者矣。嗟(jiē)夫！予(yú)尝求古仁人之心，或异二者之为，何哉？　不以物喜，不以己悲。居庙堂之高则忧其民，处（chǔ）江湖之远则忧其君。是进亦忧，退亦忧。然则何时而乐耶（yé）？其必曰：“先天下之忧而忧，后天下之乐而乐”乎！噫（yī）！微斯人， 吾谁与归？",
//              @"晋人葛洪《西京杂记》载:“司马相如将聘茂陵人女为妾,卓文君作《白头吟》以自绝,相如乃止。”但《宋书·乐志》言《白头吟》等“并汉世街陌谣讴”,即民歌。《玉台新咏》载此诗,题作《皑如山上雪》,则连题目亦与卓氏无关了。《西京杂记》乃小说家言,且相如、文君关系亦未尝至此,故云文君作,显系附会。此诗当属民歌,以女子口吻写其因见弃于用情不专的丈夫而表示出的决绝之辞。首二句是一篇起兴,言男女爱情应该是纯洁无瑕的,犹如高山的白雪那样一尘不染；应该是光明永恒的,好似云间的月亮皎皎长在。这不仅是一般人情物理的美好象征,也当是女主人公与其丈夫当初信誓旦旦的见证吧。诚如清人王尧衢云:“如雪之洁,如月之明,喻昔日信誓之明也。”(《古诗合解》)但也有解为“以‘山上雪’,‘云间月’之易消易蔽,比起有两意人。”(张玉谷《古诗赏析》)意亦可通。细玩诗意,解为反面起兴,欲抑先扬,似更觉有味。故“闻君”二句突转:既然你对我的爱情已掺上杂质,既然你已心怀二心而不专一持恒,所以我特来同你告别分手,永远断绝我们的关系。“有两意”,既与首二句“雪”“月”相乖,构成转折,又与下文“一心人”相反,形成对比,前后照应自然,而谴责之意亦彰,揭示出全诗的决绝之旨。“今日”四句,承上正面写决绝之辞:今天喝杯诀别酒,是我们最后一次聚会,明晨就将在御沟(环绕宫墙的水渠)旁边徘徊(躞蹀)分手,就像御沟中的流水一样分道扬镳了。“东西流”以渠水分岔而流喻各奔东西；或解作偏义复词,形容爱情如沟水东流,一去不复返了,义亦可通。",
//              @"啊；搜if啊搜if票我封IP无法哈珀违法哈珀我if哈珀文化节啊破瓦是否好玩死或发哦奥斯维分红安委会上",
//              @"这是一首怀人词。上片写登高望远，离愁油然而生。“伫倚危楼风细细”，“危楼”，暗示抒情主人公立足既高，游目必远。“伫倚”，则见出主人公凭栏之久与怀想之深。但始料未及，“伫倚”的结果却是“望极春愁，黯黯生天际”。“春愁”，即怀远盼归之离愁。不说“春愁”潜滋暗长于心田，反说它从遥远的天际生出，一方面是力避庸常，试图化无形为有形，变抽象为具象，增加画面的视觉性与流动感；另一方面也是因为其“春愁”是由天际景物所触发。　接着，“草色烟光”句便展示主人公望断天涯时所见之景。而“无言谁会”句既是徒自凭栏、希望成空的感喟，也是不见伊人、心曲难诉的慨叹。“无言”二字，若有万千思绪。　下片写主人公为消释离愁，决意痛饮狂歌：“拟把疏狂图一醉”。但强颜为欢，终觉“无味”。从“拟把”到“无味”，笔势开阖动荡，颇具波澜。结穴“衣带渐宽”二句以健笔写柔情，自誓甘愿为思念伊人而日渐消瘦与憔悴。“终不悔”，即“之死无靡它”之意，表现了主人公的坚毅性格与执着的态度，词境也因此得以升华。　贺裳《皱水轩词筌》认为韦庄《思帝乡》中的“陌上谁家年少足风流，妾疑将身嫁与一生休。纵被无情弃，不能羞”诸句，是“作决绝语而妙”者；而此词的末二句乃本乎韦词，不过“气加婉矣”。其实，冯延已《鹊踏枝》中的“日日花前常病酒，镜里不辞朱颜瘦”，虽然语较颓唐，亦属其类。后来，王国维在《人间词话》中谈到“古今之成大事业、大学问者，必经过三种境界”，被他借用来形容“第二境”的便是“衣带渐宽终不悔，为伊消得人憔悴”。这大概正是柳永的这两句词概括了一种锲而不舍的坚毅性格和执着态度",
//              @"第3段以“若夫”起笔，意味深长。这是一个引发议论的词，又表明了虚拟的情调，而这种虚拟又是对无数实境的浓缩、提炼和升华，颇有典型意义。“若夫”以下描写了一种悲凉的情境，由天气的恶劣写到人心的凄楚。这里用四字短句，层层渲染，渐次铺叙。霪雨、阴风、浊浪构成了主景，不但使日星无光，山岳藏形，也使商旅不前；或又值暮色沉沉、“虎啸猿啼”之际，怎能不令过往的“迁客骚人”有“去国怀乡”之慨、“忧谗畏讥”之惧、“感极而悲”之情呢？第4段以“至若”领起，打开了一个阳光灿烂的画面。“至若”尽管也是列举性的语气，但从音节上已变得高亢嘹亮，格调上已变得明快有力。下面的描写，虽然仍为四字短句，色调却为之一变，绘出春风和畅、景色明丽、水天一碧的良辰美景。更有鸥鸟在自由翱翔，鱼儿在欢快游荡，连无知的水草兰花也充满活力。作者以极为简练的笔墨，描摹出一幅湖光春色图，读之如在眼前。值得注意的是，这一段的句式、节奏与上一段大体相仿，却也另有变奏。“而或”一句就进一步扩展了意境，增强了叠加咏叹的意味，把“喜洋洋”的气氛推向高潮，而“登斯楼也”的心境也变成了“宠辱偕忘”的超脱和“把酒临风”的挥洒自如。第5段是全篇的重心，以“嗟夫”开启，兼有抒情和议论的意味。作者在列举了悲喜两种情境后，笔调突然激扬，道出了超乎这两者之上的一种更高的理想境界，那就是“不以物喜，不以己悲”!感物而动，因物悲喜虽然是人之常情，但并不是做人的最高境界。古代的仁人，就有坚定的意志，不为外界条件的变化动摇。无论是“居庙堂之高”还是“处江湖之远”，忧国忧民之心不改，“进亦忧，退亦忧”。这似乎有悖于常理，有些不可思议。作者也就此拟出一问一答，假托古圣立言，发出了“先天下之忧而忧，后天下之乐而乐”的誓言，曲终奏雅，点明了全篇的主旨。“噫!微斯人，吾谁与归”一句结语，“如怨如慕，如泣如诉”，悲凉慷慨，一往情深，令人感喟。文章最后标明写作时间，与篇首照应。《古文观止》的作者总评本文说：“岳阳楼大观，已被前人写尽。先生更不赘述，止将登楼者览物之情写出悲喜二意，只是翻出后文忧乐一段正论。”这一评语确实道出了本文的精神实质",
//              @"古木阴中系短篷，杖藜扶我过桥东。沾衣欲湿杏花雨，吹面不寒杨柳风。",
//              @"这首小诗，写诗人在微风细雨中拄杖春游的乐趣。 诗人拄杖春游，却说“杖藜扶我”，是将藜杖人格化了， 仿佛它是一位可以依赖的游伴，默默无言地扶人前行，给人以亲切感，安全感， 使这位老和尚 游兴大涨，欣欣然通过小桥，一路向东。桥东和桥西， 风景未必有很大差别，但对春游的诗人来说，向东向西，意境和情趣却颇不相同。 “东”，有些时候便是“春”的同义词，譬如春神称作东君， 东风专指春风。诗人过桥东行，正好有东风迎面吹来，无论西行、北行、南行， 都没有[1]这样的诗意。 诗的后两句尤为精彩：“杏花雨”，早春的雨“杨柳风”， 早春的风。这样说比“细雨”、“和风”更有美感，更富於画意。 杨柳枝随风荡漾，给人以春风生自杨柳的印象称早春时的雨为“杏花雨”， 与称夏初的雨为“黄梅雨”，道理正好相同。“小楼一夜听春雨，深巷明朝卖杏花”，南宋初年，大诗人陆游已将杏花和春雨联系起来。 “沾衣欲湿”，用衣裳似湿未湿来形容初春细雨似有若无， 更见得体察之精微，描模之细腻。试想诗人扶杖东行，一路红杏灼灼，绿柳翩翩， 细雨沾衣，似湿而不见湿，和风迎面吹来，不觉有一丝儿寒意， 这是怎样不耐心惬意的春日远足啊！ 有人不免要想，老和尚这样兴致勃勃地走下去，游赏下去， 到他想起应该归去的时候，怕要体力不支，连藜杖也扶他不动了吧？不必多虑。 诗的首句说：“古木阴中系短篷。”短篷不就是小船吗？ 老和尚原是乘小船沿溪水而来，那小船偏激在溪水边老树下，正待他解缆回寺呢。",
//              @"春江潮水连海平，海上明月共潮生。滟滟随波千万里，何处春江无月明。江流宛转绕芳甸，月照花林皆似霰。空里流霜不觉飞，汀上白沙看不见。江天一色无纤尘，皎皎空中孤月轮。江畔何人初见月，江月何年初照人？人生代代无穷已，江月年年只相似。不知江月待何人，但见长江送流水。白云一片去悠悠，青枫浦上不胜愁。谁家今夜扁舟子，何处相思明月楼？可怜楼上月徘徊，应照离人妆镜台。玉户帘中卷不去，捣衣砧上拂还来。此时相望不相闻，愿逐月华流照君。鸿雁长飞光不度，鱼龙潜跃水成文。昨夜闲潭梦落花，可怜春半不还家。江水流春去欲尽，江潭落月复西斜。斜月沉沉藏海雾，碣石潇湘无限路。不知乘月几人归，落月摇情满江树。",
//              @"清明澄澈的天地宇宙，仿佛使人进入了一个纯净世界，这就自然地引起了诗人的遐思冥想：“江畔何人初见月？江月何年初照人？”诗人神思飞跃，但又紧紧联系着人生，探索着人生的哲理与宇宙的奥秘。这种探索，古人也已有之，如曹植《送应氏》：“天地无终极，人命若朝霜”，阮籍《咏怀》：“人生若尘露，天道邈悠悠”等等，但诗的主题多半是感慨宇宙永恒，人生短暂。张若虚在此处却别开生面，他的思想没有陷入前人窠臼，而是翻出了新意：“人生代代无穷已，江月年年望相似。”个人的生命是短暂即逝的，而人类的存在则是绵延久长的，因之“代代无穷已”的人生就和“年年望相似”的明月得以共存。这是诗人从大自然的美景中感受到的一种欣慰。诗人虽有对人生短暂的感伤，但并不是颓废与绝望，而是缘于对人生的追求与热爱。全诗的基调是“哀而不伤”，使我们得以聆听到初盛唐时代之音的回响。",
//              @"“不知江月待何人，但见长江送流水”，这是紧承上一句的“望相似”而来的。人生代代相继，江月年年如此。一轮孤月徘徊中天，象是等待着什么人似的，却又永远不能如愿。月光下，只有大江急流，奔腾远去。随着江水的流动，诗篇遂生波澜，将诗情推向更深远的境界。江月有恨，流水无情，诗人自然地把笔触由上半篇的大自然景色转到了人生图象，引出下半篇男女相思的离愁别恨。",
//              @"“白云”四句总写在春江花月夜中思妇与游子的两地思念之情。“白云”、“青枫浦”托物寓情。白云飘忽，象征“扁舟子”的行踪不定。“青枫浦”为地名，但“枫”“浦”在诗中又常用为感别的景物、处所。“谁家”“何处”二句互文见义，正因不止一家、一处有离愁别恨，诗人才提出这样的设问，一种相思，牵出两地离愁，一往一复，诗情荡漾，曲折有致。",
//              @"以下“可怜”八句承“何处”句，写思妇对离人的怀念。然而诗人不直说思妇的悲和泪，而是用“月”来烘托她的怀念之情，悲泪自出。诗篇把“月”拟人化，“徘徊”二字极其传神：一是浮云游动，故光影明灭不定；二是月光怀着对思妇的怜悯之情，在楼上徘徊不忍去。它要和思妇作伴，为她解愁，因而把柔和的清辉洒在妆镜台上、玉户帘上、捣衣砧上。岂料思妇触景生情，反而思念尤甚。她想赶走这恼人的月色，可是月色“卷不去”，“拂还来”，真诚地依恋着她。这里“卷”和“拂”两个痴情的动作，生动地表现出思妇内心的愁怅和迷惘。月光引起的情思在深深地搅扰着她，此时此刻，月色不也照着远方的爱人吗？共望月光而无法相知，只好依托明月遥寄相思之情。",
//              @"最后八句写游子，诗人用落花、流水、残月来烘托他的思归之情。“扁舟子”连做梦也念念归家——花落幽潭，春光将老，人还远隔天涯，情何以堪！江水流春，流去的不仅是自然的春天，也是游子的青春、幸福和憧憬。江潭落月，更衬托出他凄苦的寞寞之情。沉沉的海雾隐遮了落月；碣石、潇湘，天各一方，道路是多么遥远。“沉沉”二字加重地渲染了他的孤寂；“无限路”也就无限地加深了他的乡思。他思忖：在这美好的春江花月之夜，不知有几人能乘月归回自己的家乡！他那无着无落的离情，伴着残月之光，洒满在江边的树林之上……",
//              @"落月摇情满江树”，这结句的“摇情”——不绝如缕的思念之情，将月光之情，游子之情，诗人之情交织成一片，洒落在江树上，也洒落在读者心上，情韵袅袅，摇曳生姿，令人心醉神迷",
//              @"《春江花月夜》在思想与艺术上都超越了以前那些单纯模山范水的景物诗，“羡宇宙之无穷，哀吾生之须臾”的哲理诗，抒儿女别情离绪的爱情诗。诗人将这些屡见不鲜的传统题材，注入了新的含义，融诗情、画意、哲理为一体，凭借对春江花月夜的描绘，尽情赞叹大自然的奇丽景色，讴歌人间纯洁的爱情，把对游子思妇的同情心扩大开来，与对人生哲理的追求、对宇宙奥秘的探索结合起来，从而汇成一种情、景、理水乳交溶的幽美而邈远的意境。诗人将深邃美丽的艺术世界特意隐藏在惝恍迷离的艺术氛围之中，整首诗篇仿佛笼罩在一片空灵而迷茫的月色里，吸引着读者去探寻其中美的真谛。",
//              @"全诗紧扣春、江、花、月、夜的背景来写，而又以月为主体。“月”是诗中情景兼融之物，它跳动着诗人的脉搏，在全诗中犹如一条生命纽带，通贯上下，触处生神，诗情随着月轮的生落而起伏曲折。月在一夜之间经历了升起——高悬——西斜——落下的过程。在月的照耀下，江水、沙滩、天空、原野、枫树、花林、飞霜、白沙、扁舟、高楼、镜台、砧石、长飞的鸿雁、潜跃的鱼龙，不眠的思妇以及漂泊的游子，组成了完整的诗歌形象，展现出一幅充满人生哲理与生活情趣的画卷。这幅画卷在色调上是以淡寓浓，虽用水墨勾勒点染，但“墨分五彩”，从黑白相辅、虚实相生中显出绚烂多彩的艺术效果，宛如一幅淡雅的中国水墨画，体现出春江花月夜清幽的意境美。",
//              @"诗的韵律节奏也饶有特色。诗人灌注在诗中的感情旋律极其悲慨激荡，但那旋律既不是哀丝豪竹，也不是急管繁弦，而是象小提琴奏出的小夜曲或梦幻曲，含蕴，隽永。诗的内在感情是那样热烈、深沉，看来却是自然的、平和的，犹如脉搏跳动那样有规律，有节奏，而诗的韵律也相应地扬抑回旋。全诗共三十六句，四句一换韵，共换九韵。又平声庚韵起首，中间为仄声霰韵、平声真韵、仄声纸韵、平声尤韵、灰韵、文韵、麻韵，最后以仄声遇韵结束。诗人把阳辙韵与阴辙韵交互杂沓，高低音相间，依次为洪亮级（庚、霰、真）——细微极（纸）——柔和级（尤、灰）——洪亮级（文、麻）——细微级（遇）。全诗随着韵脚的转换变化，平仄的交错运用，一唱三叹，前呼后应，既回环反复，又层出不穷，音乐节奏感强烈而优美。这种语音与韵味的变化，又是切合着诗情的起伏，可谓声情与文情丝丝入扣，宛转谐美。",
//              @"本诗热烈赞赏了陆游诗歌中渴望建功立业、为国驱驰之志至老不衰的高昂格调；高度评价了陆游千古难遇的奇男子气概。实际上是抒发了作者自己的异代同心之感。他当时虽然亡身海外，想到遭受列强宰割、阴霾四布的神州大地，发出恨不能从军杀敌的呼喊。",
//              
//              ] mutableCopy];
}

@end
