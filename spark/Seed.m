//
//  Seed.m
//
//  Created by hustlzp on 15/9/11.
//  Copyright (c) 2015年 hustlzp. All rights reserved.
//

#import "Seed.h"
#import "AFNetworking.h"

static const NSString *CDN = @"http://7xn16r.com1.z0.glb.clouddn.com";

@implementation Seed

+ (void)seedData {
    // 用户
    SPUser *userHardin = [self createUserWithName:@"哈丁" avatar:@"hardin.png"];
    SPUser *userJiuqi = [self createUserWithName:@"玖琪" avatar:@"jiuqi.png"];
    SPUser *userHustlzp = [self createUserWithName:@"hustlzp" avatar:@"hustlzp.png"];
    SPUser *userHuangbo = [self createUserWithName:@"黄博" avatar:@"huangtao.png"];
    SPUser *userDante = [self createUserWithName:@"Dante" avatar:@"Dante.png"];
    SPUser *userMichael = [self createUserWithName:@"Michael282694" avatar:@"Michael282694.png"];
    SPUser *userSizhuren = [self createUserWithName:@"寺主人" avatar:@"Sizhuren.png"];
    SPUser *userGM = [self createUserWithName:@"管理员" avatar:@"GM.png"];
    SPUser *userGaomoliang = [self createUserWithName:@"高末良" avatar:@"gaomoliang.png"];
    SPUser *userMadelong = [self createUserWithName:@"马德龙" avatar:@"madelong.png"];
    
    // 话题
    SPTopic *topicStartup = [self createTopicWithName:@"创业" desc:@"雄关漫道真如铁，而今迈步从头越。" entriesCount:@273 followersCount:@231 avatar:@"startup.jpg"];
    SPTopic *topicProduct = [self createTopicWithName:@"产品" desc:@"产品改变世界。" entriesCount:@231 followersCount:@93 avatar:nil];
    SPTopic *topicOne = [self createTopicWithName:@"从0到1" desc:@"不看你绝对后悔。" entriesCount:@231 followersCount:@93 avatar:@"zerotoone.png"];
    SPTopic *topicDesign = [self createTopicWithName:@"设计" desc:@"设计改变世界。" entriesCount:@231 followersCount:@93 avatar:@"design.jpg"];
    SPTopic *topicSocial = [self createTopicWithName:@"社交" desc:@"社交是亘古不变的话题。" entriesCount:@231 followersCount:@93 avatar:nil];
    SPTopic *topicAirbnb = [self createTopicWithName:@"Airbnb" desc:@"是一家链接旅游者和家有空房出租的房主的服务型网站，诞生于美国硅谷。" entriesCount:@231 followersCount:@93 avatar:@"airbnb.png"];
    SPTopic *topicIPhone = [self createTopicWithName:@"iPhone" desc:@"苹果公司出品的手机。" entriesCount:@243 followersCount:@323 avatar:@"iphone.png"];
    SPTopic *topicMusk = [self createTopicWithName:@"Elon Musk" desc:@"狂拽酷炫吊炸天。" entriesCount:@32 followersCount:@313 avatar:@"elon-musk.png"];
    SPTopic *topicWechat = [self createTopicWithName:@"微信" desc:@"第一个拿到移动互联网船票的App。" entriesCount:@23 followersCount:@43 avatar:@"wechat.png"];
    SPTopic *topicZhihu = [self createTopicWithName:@"知乎" desc:@"段子平台。" entriesCount:@249 followersCount:@323 avatar:@"zhihu.png"];
    SPTopic *topicSentence = [self createTopicWithName:@"每日好句" desc:@"每天分享好句子" entriesCount:@283 followersCount:@313 avatar:nil];
    
    // 对话
    [self
     createDialogWithDialogist:userJiuqi
     unreadMessagesCount:@0
     hasNewMessage:@YES
     createdAt:@"18:37"
     messages:@[@[userHardin, @"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。", @YES],
                @[userJiuqi, @"我觉得创业维艰像一本创业字典，适合碰到具体问题的时候拿出来看看。", @NO],
                @[userHardin, @"bingo", @NO],
                @[userHardin, @"你那个项目怎么样了？", @NO],
                @[userJiuqi, @"我得把比我高的都删掉...", @NO]]
     ];
    [self
     createDialogWithDialogist:userHustlzp
     unreadMessagesCount:@0
     hasNewMessage:@NO
     createdAt:@"12:05"
     messages:@[@[userHustlzp, @"Airbnb CEO Brian Chesky 和他交了两年的女朋友 Elissa Patel 是通过 Tinder 认识的。", @YES],
                @[userHardin, @"这个有意思", @NO],
                @[userHustlzp, @"这个，也很像，是做创业问答的", @NO]]
     ];
    [self
     createDialogWithDialogist:userHuangbo
     unreadMessagesCount:@0
     hasNewMessage:@NO
     createdAt:@"昨天"
     messages:@[@[userHardin, @"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。", @YES],
                @[userHuangbo, @"认同。我是知乎的产品经理，能认识一下吗？", @NO],
                @[userHardin, @"当然，久仰。", @NO],
                @[userHuangbo, @"看好你的。", @NO]]
     ];
    [self
     createDialogWithDialogist:userDante
     unreadMessagesCount:@0
     hasNewMessage:@NO
     createdAt:@"昨天"
     messages:@[@[userHardin, @"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。", @YES],
                @[userDante, @"两本都看过，深表认同，真的是佩服 Peter Thiel 的思路。", @NO],
                @[userHardin, @"最近在忙什么？", @NO],
                @[userDante, @"还在陌陌呢，忙的跟狗一样。", @NO],
                @[userHardin, @"真心在忙，还是在约妹子？", @NO],
                @[userDante, @"真心的，哈哈。。。", @NO]]
     ];
    [self
     createDialogWithDialogist:userMichael
     unreadMessagesCount:@0
     hasNewMessage:@NO
     createdAt:@"一周前"
     messages:@[@[userHardin, @"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。", @YES],
                @[userMichael, @"我觉得创业维艰挺值得读三遍，因为在大部分时候把创业者挑下马的不是缺乏那些高屋建瓴式的思想，而是一个发不出工资的困难。", @NO],
                @[userHardin, @"我是认为创业维艰不管读几遍都不能解决发不出工资的困难，想要发的出工资，你需要的是一个好生意。", @NO],
                @[userMichael, @"这个怎么讲呢，是个心理预期的问题。没创业过的人不知道其中的困难，带着改变的心态去做事情，喜欢高举高打，落差蛮大的。读什么书也不会显性的帮助创业成功。", @NO],
                @[userMichael, @"问问那些要去硅谷工作的年轻人", @NO]]
     ];
    [self
     createDialogWithDialogist:userSizhuren
     unreadMessagesCount:@0
     hasNewMessage:@NO
     createdAt:@"一周前"
     messages:@[@[userSizhuren, @"像知乎这样的泛话题社区，女生涨粉的最佳方法就是先po几张修过图的美照，还不管和问题沾不沾边儿。", @YES],
                @[userHardin, @"bingo！", @NO],
                @[userHardin, @"先去忙了，回聊！", @NO],
                @[userSizhuren, @"好的，有机会再说 ", @NO]]
     ];
    
    // 通知
    [self
     createNotificationWithSender:userGM
     unreadMessagesCount:@0
     hasNewMessage:@YES
     createdAt:@"刚刚"
     messages:@[@[userHardin, @"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。", @YES],
                @[userGM, @"你的笔记「我觉得创业维艰」上榜啦！", @NO]]
     ];
    [self
     createNotificationWithSender:userGaomoliang
     unreadMessagesCount:@1
     hasNewMessage:@NO
     createdAt:@"18:22"
     messages:@[@[userHardin, @"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。", @YES],
                @[userGaomoliang, @"你好，这个观点我不是很认同啊...", @NO]]
     ];
    [self
     createNotificationWithSender:userMadelong
     unreadMessagesCount:@0
     hasNewMessage:@NO
     createdAt:@"前天"
     messages:@[@[userHardin, @"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。", @YES],
                @[userMadelong, @"考虑加入下拉钩？", @NO]]
     ];
    
    // 条目    
    [self createEntryWithUser:userHardin
                      content:@"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。"
                       topics:@[topicStartup, topicOne]
                 upvotesCount:@213
               downvotesCount:@19];
    [self createEntryWithUser:userJiuqi
                      content:@"对于越熟悉的人，人们越不需要生产有价值的内容，就可以保持彼此互动，促进社交关系。"
                       topics:@[topicSocial]
                 upvotesCount:@162
               downvotesCount:@27];
    [self createEntryWithUser:userHustlzp
                      content:@"Airbnb CEO Brian Chesky 和他交了两年的女朋友 Elissa Patel 是通过 Tinder 认识的。"
                       topics:@[topicAirbnb]
                 upvotesCount:@173
               downvotesCount:@7];
    [self createEntryWithUser:userGaomoliang
                      content:@"你是准备一辈子给iPhone扩大屏幕，还是和我一起去改变宇宙？"
                       topics:@[topicMusk, topicIPhone]
                 upvotesCount:@373
               downvotesCount:@8];
    [self createEntryWithUser:userHuangbo
                      content:@"看到大家都在晒二维码，想到了之前张小龙的观点：设计基本规则，然后看着用户在基本规则下的自发开始行为进化。"
                       topics:@[topicWechat]
                 upvotesCount:@123
               downvotesCount:@8];
    [self createEntryWithUser:userSizhuren
                      content:@"像知乎这样的泛话题社区，女生涨粉的最佳方法就是先po几张修过图的美照，还不管和问题沾不沾边儿。"
                       topics:@[topicZhihu]
                 upvotesCount:@343
               downvotesCount:@9];
    [self createEntryWithUser:userDante
                      content:@"如果想一个事情变好，一定要先接受它的现状，才能转身使它走向好的方向。我觉得此话有深意。欲速而不达，忍受不完美有时是被迫的最佳策略。"
                       topics:@[topicStartup]
                 upvotesCount:@63
               downvotesCount:@6];
    [self createEntryWithUser:userMadelong
                      content:@"人们喜欢听All in的故事，因为All in透露着豪迈，鼓舞着人们，是正能量。可是生活更需要弃牌，弃牌不丢脸，那是为了更大的All in。All in需要勇气，弃牌需要智慧。"
                       topics:@[topicSentence]
                 upvotesCount:@173
               downvotesCount:@3];
}

// User
+ (SPUser *)createUserWithName:(NSString *)name avatar:(NSString *)avatar
{
    __block SPUser *user;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        user = [SPUser MR_createEntityInContext:localContext];
        user.name = name;
        user.desc = @"产品设计 / 健身爱好者 / 创业中";
        user.avatarUrl = [NSString stringWithFormat:@"%@/%@", CDN, avatar];
        user.entriesCount = @91;
        user.followedTopicsCount = @18;
        user.upvotesCount = @32371;
    }];
    
    return user;
}

// Topic
+ (SPTopic *)createTopicWithName:(NSString *)name desc:(NSString *)desc entriesCount:(NSNumber *)entriesCount followersCount:(NSNumber *)followersCount avatar:(NSString *)avatar
{
    __block SPTopic *topic;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        topic = [SPTopic MR_createEntityInContext:localContext];
        topic.name = name;
        topic.desc = desc;
        
        if (avatar) {
            topic.avatarUrl = [NSString stringWithFormat:@"%@/%@", CDN, avatar];
        }
        
        topic.entriesCount = entriesCount;
        topic.followersCount = followersCount;
    }];
    
    return topic;
}

// Dialog
+ (SPDialog *)createDialogWithDialogist:(SPUser *)dialogist unreadMessagesCount:(NSNumber *)unreadMessagesCount hasNewMessage:(NSNumber *)hasNewMessage createdAt:(NSString *)createdAt messages:(NSArray *)messages
{
    __block SPDialog *dialog;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        dialog = [SPDialog MR_createEntityInContext:localContext];
        SPUser *_dialogist = [dialogist MR_inContext:localContext];
        dialog.dialogist = _dialogist;
        dialog.hasNewMessage = hasNewMessage;
        dialog.createdAtString = createdAt;
        dialog.unreadMessagesCount = unreadMessagesCount;
    }];
    
    [self addMessages:messages toDialog:dialog];
    
    return dialog;
}

// Notification
+ (SPNotification *)createNotificationWithSender:(SPUser *)sender unreadMessagesCount:(NSNumber *)unreadMessagesCount hasNewMessage:(NSNumber *)hasNewMessage createdAt:(NSString *)createdAt messages:(NSArray *)messages
{
    __block SPNotification *notification;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        notification = [SPNotification MR_createEntityInContext:localContext];
        SPUser *_sender = [sender MR_inContext:localContext];
        notification.sender = _sender;
        notification.createdAtString = createdAt;
        notification.hasNewMessage = hasNewMessage;
        notification.unreadMessagesCount = unreadMessagesCount;
    }];
    
    [self addMessages:messages toDialog:notification];
    
    return notification;
}

// Message
+ (SPMessage *)createMessageWithSender:(SPUser *)sender dialog:(SPBaseDialog *)dialog content:(NSString *)content fromEntry:(NSNumber *)fromEntry
{
    __block SPMessage *message;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        message = [SPMessage MR_createEntityInContext:localContext];
        SPUser *_sender = [sender MR_inContext:localContext];
        SPBaseDialog *_dialog = [dialog MR_inContext:localContext];
        message.sender = _sender;
        message.dialog = _dialog;
        message.content = content;
        message.fromEntry = fromEntry;
    }];
    
    return message;
}

+ (void)addMessages:(NSArray *)messages toDialog:(SPBaseDialog *)dialog
{
    for (NSArray *message in messages) {
        SPUser *messageSender = (SPUser *)[message objectAtIndex:0];
        NSString *content = (NSString *)[message objectAtIndex:1];
        NSNumber *fromEntry = (NSNumber *)[message objectAtIndex:2];
        
        [self createMessageWithSender:messageSender dialog:dialog content:content fromEntry:fromEntry];
    }
}

+ (SPEntry *)createEntryWithUser:(SPUser *)user content:(NSString *)content topics:(NSArray *)topics upvotesCount:(NSNumber *)upvotesCount downvotesCount:(NSNumber *)downvotesCount
{
    __block SPEntry *entry;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        entry = [SPEntry MR_createEntityInContext:localContext];
        SPUser *_user = [user MR_inContext:localContext];
        entry.user = _user;
        entry.upvotesCount = upvotesCount;
        entry.downvotesCount = downvotesCount;
        entry.content = content;
        
        for (SPTopic *topic in topics) {
            SPTopic *_topic = [topic MR_inContext:localContext];
            [entry addTopicsObject:_topic];
        }
    }];
    
    return entry;
}

// Truncate all data
+ (void)truncateAllData {
    [SPMessage MR_truncateAll];
    [SPNotification MR_truncateAll];
    [SPDialog MR_truncateAll];
    [SPEntry MR_truncateAll];
    [SPTopic MR_truncateAll];
    [SPUser MR_truncateAll];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
