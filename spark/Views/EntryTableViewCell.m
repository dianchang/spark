//
//  EntryTableViewCell.m
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import "EntryTableViewCell.h"
#import "UIColor+Helper.h"
#import <QuartzCore/QuartzCore.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <ionicons/IonIcons.h>
#import <Masonry/Masonry.h>

@interface EntryTableViewCell ()

@property (strong, nonatomic) SPEntry *entry;
@property (strong, nonatomic) TopicsListView *topicsView;
@property (strong, nonatomic) UILabel *popularityLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *userAvatarView;
@property (strong, nonatomic) UILabel *userNameLabel;

@end

@implementation EntryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // 话题
    TopicsListView *topicsView = [TopicsListView new];
    self.topicsView = topicsView;
    [self.contentView addSubview:topicsView];
    
    // 流行度
    UIView *popularityWapView = [UIView new];
    [self.contentView addSubview:popularityWapView];

    UILabel *heartLabel = [IonIcons labelWithIcon:ion_heart size:15 color:[UIColor colorWithRGBA:0xA0A4A6FF]];
    [popularityWapView addSubview:heartLabel];
    
    UILabel *popularityLabel = [UILabel new];
    self.popularityLabel = popularityLabel;
    popularityLabel.font = [UIFont systemFontOfSize:12];
    [popularityWapView addSubview:popularityLabel];
    
    // 内容
    UILabel *contentLabel = [UILabel new];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.font = [UIFont systemFontOfSize:16];
    self.contentLabel = contentLabel;
    [self.contentView addSubview:contentLabel];
    
    // 用户头像
    UIImageView *userAvatarView = [UIImageView new];
    self.userAvatarView = userAvatarView;
    userAvatarView.layer.cornerRadius = 15;
    userAvatarView.layer.masksToBounds = YES;
    [self.contentView addSubview:userAvatarView];
    
    // 用户名
    UILabel *userNameLabel = [UILabel new];
    self.userNameLabel = userNameLabel;
    userNameLabel.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:userNameLabel];
    
    // 评论按钮
    UIButton *commentButton = [UIButton new];
    [commentButton setTitle:ion_chatbubble_working forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor colorWithRGBA:0xC0D6DEFF] forState:UIControlStateNormal];
    commentButton.titleLabel.font = [IonIcons fontWithSize:18];
    [self.contentView addSubview:commentButton];
    
    // 下边框
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor colorWithRGBA:0xDDDDDDFF];
    [self.contentView addSubview:bottomBorder];
    
    /* 约束 */
    
    [topicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView).offset(20);
    }];
    
    [popularityWapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topicsView);
        make.right.equalTo(self.contentView).offset(-20);
        make.left.equalTo(topicsView.mas_right).offset(10);
    }];
    
    [heartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(popularityWapView);
    }];
    
    [popularityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(heartLabel.mas_right).offset(5);
        make.centerY.equalTo(heartLabel);
        make.right.equalTo(popularityWapView);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topicsView);
        make.right.equalTo(popularityWapView);
        make.top.equalTo(topicsView.mas_bottom).offset(12);
    }];
    
    [userAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topicsView);
        make.width.height.equalTo(@30);
        make.top.equalTo(contentLabel.mas_bottom).offset(15);
    }];
    
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userAvatarView.mas_right).offset(8);
        make.centerY.equalTo(userAvatarView);
    }];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(userAvatarView);
    }];
    
    [bottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userAvatarView.mas_bottom).offset(20).priorityHigh();
        make.left.equalTo(topicsView);
        make.right.equalTo(popularityWapView);
        make.height.equalTo(@.5).priorityHigh();
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    return self;
}

- (void)updateWithEntry:(SPEntry *)entry
{
    self.entry = entry;
    self.topicsView.topics = [entry.topics allObjects];
    self.popularityLabel.text = [NSString stringWithFormat:@"%d%%", (int)((double)entry.upvotesCountValue / (entry.upvotesCountValue + entry.downvotesCountValue))];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:entry.content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, entry.content.length)];
    self.contentLabel.attributedText = attributedString;
    
    [self.userAvatarView setImageWithURL:[NSURL URLWithString:entry.user.avatarUrl]];
    self.userNameLabel.text = entry.user.name;
}

#pragma mark - Getters & Setters

- (void)setViewController:(id<TopicsListViewDelegate>)viewController
{
    self.topicsView.delegate = viewController;
}

@end
