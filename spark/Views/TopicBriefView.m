//
//  TopicBriefView.m
//  spark
//
//  Created by hustlzp on 15/10/1.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "TopicView.h"
#import "UIColor+Helper.h"
#import "TopicBriefView.h"
#import <Masonry/Masonry.h>

@interface TopicBriefView ()

@property (strong, nonatomic) SPTopic *topic;

@end

@implementation TopicBriefView

- (instancetype)initWithTopic:(SPTopic *)topic
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.topic = topic;
    
    [self createViews];
    
    return self;
}

- (void)createViews
{
    // 话题
    TopicView *topicView = [[TopicView alloc] initWithTopic:self.topic];
    [self addSubview:topicView];
    
    // 关注数
    UILabel *countLabel = [UILabel new];
    NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d", self.topic.followersCountValue] attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:10]}];
    NSMutableAttributedString *countTextString = [[NSMutableAttributedString alloc] initWithString:@" 关注" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
    [countString appendAttributedString:countTextString];
    countLabel.attributedText = countString;
    countLabel.textColor = [UIColor colorWithRGBA:0xAAAAAAFF];
    [self addSubview:countLabel];

    // 边框
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor colorWithRGBA:0xEEEEEEFF];
    [self addSubview:bottomBorder];
    
    // 约束
    [topicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(15);
        make.bottom.equalTo(bottomBorder.mas_top).offset(-15);
    }];
    
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topicView);
        make.right.equalTo(self);
    }];
    
    [bottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@.5);
    }];
}

@end
