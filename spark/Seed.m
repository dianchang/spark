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
    SPTopic *topicStartup = [self createTopicWithName:@"创业" entriesCount:@273 followersCount:@231];
    SPTopic *topicProduct = [self createTopicWithName:@"产品" entriesCount:@231 followersCount:@93];
    SPTopic *topicOne = [self createTopicWithName:@"从0到1" entriesCount:@231 followersCount:@93];
    SPTopic *topicDesign = [self createTopicWithName:@"设计" entriesCount:@231 followersCount:@93];
    SPTopic *topicSocial = [self createTopicWithName:@"社交" entriesCount:@231 followersCount:@93];
    SPTopic *topicAirbnb = [self createTopicWithName:@"Airbnb" entriesCount:@231 followersCount:@93];
    SPTopic *topicIPhone = [self createTopicWithName:@"iPhone" entriesCount:@243 followersCount:@323];
    SPTopic *topicMusk = [self createTopicWithName:@"Elon Musk" entriesCount:@32 followersCount:@313];
    SPTopic *topicWechat = [self createTopicWithName:@"微信" entriesCount:@23 followersCount:@43];
    SPTopic *topicZhihu = [self createTopicWithName:@"知乎" entriesCount:@249 followersCount:@323];
    SPTopic *topicSentence = [self createTopicWithName:@"每日好句" entriesCount:@283 followersCount:@313];
    
    // 聊天
    [self createMessageWithSender:userJiuqi content:@"我得把比我高的都删掉..." createdAt:@"18:37"];
    [self createMessageWithSender:userHustlzp content:@"这个，也很像，是做创业问答的" createdAt:@"12:05"];
    [self createMessageWithSender:userHuangbo content:@"看好你的。" createdAt:@"昨天"];
    [self createMessageWithSender:userDante content:@"真心的，哈哈。。" createdAt:@"昨天"];
    [self createMessageWithSender:userMichael content:@"问问那些要去硅谷工作的年轻人" createdAt:@"一周前"];
    [self createMessageWithSender:userSizhuren content:@"好的，有机会再说" createdAt:@"一周前"];
    
    // 通知
    [self createNotificationWithSender:userGM content:@"你的笔记「我觉得创业维艰」上榜啦！" createdAt:@"刚刚"];
    [self createNotificationWithSender:userGaomoliang content:@"你好，这个观点我不是很认同啊..." createdAt:@"18:22"];
    [self createNotificationWithSender:userMadelong content:@"考虑加入下拉钩？" createdAt:@"前天"];
    
    // 条目    
    [self createEntryWithUser:userHardin
                      content:@"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。"
                       topics:@[topicStartup, topicOne, topicAirbnb]
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
+ (SPTopic *)createTopicWithName:(NSString *)name entriesCount:(NSNumber *)entriesCount followersCount:(NSNumber *)followersCount
{
    __block SPTopic *topic;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        topic = [SPTopic MR_createEntityInContext:localContext];
        topic.name = name;
        topic.entriesCount = entriesCount;
        topic.followersCount = followersCount;
    }];
    
    return topic;
}

// Message
+ (SPMessage *)createMessageWithSender:(SPUser *)sender content:(NSString *)content createdAt:(NSString *)createdAt
{
    __block SPMessage *message;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        message = [SPMessage MR_createEntityInContext:localContext];
        SPUser *_sender = [sender MR_inContext:localContext];
        message.sender = _sender;
        message.content = content;
        message.createdAtString = createdAt;
    }];
    
    return message;
}

// Notification
+ (SPNotification *)createNotificationWithSender:(SPUser *)sender content:(NSString *)content createdAt:(NSString *)createdAt
{
    __block SPNotification *noti;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        noti = [SPNotification MR_createEntityInContext:localContext];
        SPUser *_sender = [sender MR_inContext:localContext];
        noti.sender = _sender;
        noti.content = content;
        noti.createdAtString = createdAt;
    }];
    
    return noti;
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
    [SPNotification MR_truncateAll];
    [SPMessage MR_truncateAll];
    [SPEntry MR_truncateAll];
    [SPTopic MR_truncateAll];
    [SPUser MR_truncateAll];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
