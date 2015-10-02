//
//  EntryView.m
//  spark
//
//  Created by hustlzp on 15/10/1.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "EntryView.h"
#import "UserPopupView.h"
#import "UIColor+Helper.h"
#import <Masonry/Masonry.h>
#import <ionicons/IonIcons.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface EntryView ()

@property (strong, nonatomic) SPEntry *entry;
@property (strong, nonatomic) TopicsListView *topicsView;
@property (strong, nonatomic) UILabel *popularityLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *userAvatarView;
@property (strong, nonatomic) UIButton *userNameButton;

@end

@implementation EntryView

- (instancetype)initWithEntry:(SPEntry *)entry
{
    self = [self init];
    
    [self updateWithEntry:entry];
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self createViews];
    
    return self;
}

- (void)createViews
{
    // 话题
    TopicsListView *topicsView = [TopicsListView new];
    self.topicsView = topicsView;
    [self addSubview:topicsView];
    
    // 流行度
    UIView *popularityWapView = [UIView new];
    [self addSubview:popularityWapView];
    
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
    [self addSubview:contentLabel];
    
    // 用户头像
    UIImageView *userAvatarView = [UIImageView new];
    self.userAvatarView = userAvatarView;
    userAvatarView.layer.cornerRadius = 15;
    userAvatarView.layer.masksToBounds = YES;
    [self addSubview:userAvatarView];
    userAvatarView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureForAvatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userElementPressed)];
    [userAvatarView addGestureRecognizer:gestureForAvatar];
    
    // 用户名
    UIButton *userNameButton = [UIButton new];
    self.userNameButton = userNameButton;
    userNameButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [userNameButton setTitleColor:[UIColor colorWithRGBA:0x444444FF] forState:UIControlStateNormal];
    [userNameButton addTarget:self action:@selector(userElementPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:userNameButton];
    
    // 评论按钮
    UIButton *commentButton = [UIButton new];
    [commentButton setTitle:ion_chatbubble_working forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor colorWithRGBA:0xC0D6DEFF] forState:UIControlStateNormal];
    commentButton.titleLabel.font = [IonIcons fontWithSize:18];
    [commentButton addTarget:self action:@selector(commentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commentButton];
    
    // 下边框
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor colorWithRGBA:0xDDDDDDFF];
    [self addSubview:bottomBorder];
    
    /* 约束 */
    
    [topicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(20);
    }];
    
    [popularityWapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topicsView);
        make.right.equalTo(self);
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
    
    [userNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userAvatarView.mas_right).offset(8);
        make.centerY.equalTo(userAvatarView);
    }];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(0);
        make.centerY.equalTo(userAvatarView);
    }];
    
    [bottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userAvatarView.mas_bottom).offset(20).priorityHigh();
        make.left.equalTo(topicsView);
        make.right.equalTo(popularityWapView);
        make.height.equalTo(@.5).priorityHigh();
        make.bottom.equalTo(self.mas_bottom);
    }];

}

#pragma mark - Public methods

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
    [self.userNameButton setTitle:entry.user.name forState:UIControlStateNormal];
}

#pragma mark - User Interface

- (void)commentButtonPressed
{
    if (self.delegate) {
        [self.delegate commentButtonPressed:self.entry.user];
    }
}

- (void)userElementPressed
{
    if (self.delegate) {
        UserPopupView *popupView = [[UserPopupView alloc] initWithUser:self.entry.user];
        [popupView show];
    }
}

#pragma mark - Getters & Setters

- (void)setDelegate:(id <EntryViewDelegate>)delegate
{
    _delegate = delegate;
    self.topicsView.delegate = delegate;
}

@end
