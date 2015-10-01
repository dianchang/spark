//
//  UserPopupView.m
//  spark
//
//  Created by hustlzp on 15/9/30.
//  Copyright © 2015年 hustlzp. All rights reserved.
//


#import "UserPopupView.h"
#import "UIColor+Helper.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>
#import <MagicalRecord/MagicalRecord.h>
#import <ionicons/IonIcons.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface UserPopupView ()

@property (nonatomic) CGFloat duration;
@property (strong, nonatomic) UIView *wapView;
@property (strong, nonatomic) SPUser *user;

@end

@implementation UserPopupView

- (instancetype)initWithUser:(SPUser *)user
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.duration = .3;
    self.user = user;
    self.backgroundColor = [UIColor colorWithRGBA:0x00000000];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tapRecognizer];
    
    [self createViews];
    
    return self;
}

- (void)createViews
{
    // 容器
    UIView *wapView = [UIView new];
    wapView.backgroundColor = [UIColor whiteColor];
    wapView.layer.cornerRadius = 5;
    wapView.layer.masksToBounds = YES;
    [self addSubview:wapView];
    wapView.alpha = 0;
    self.wapView = wapView;
    
    // 关闭按钮
    UIButton *hideButton = [UIButton new];
    hideButton.titleLabel.font = [IonIcons fontWithSize:24];
    [hideButton setTitle:ion_android_close forState:UIControlStateNormal];
    [hideButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [wapView addSubview:hideButton];
    [hideButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    // 头像
    UIImageView *avatarView = [UIImageView new];
    [avatarView setImageWithURL:[NSURL URLWithString:self.user.avatarUrl]];
    avatarView.layer.cornerRadius = 30;
    avatarView.layer.masksToBounds = YES;
    [wapView addSubview:avatarView];
    
    // 用户名
    UILabel *userLabel = [UILabel new];
    userLabel.text = self.user.name;
    userLabel.font = [UIFont fontWithName:SPLanTingFontName size:16];
    [wapView addSubview:userLabel];
    
    // 赞数
    NSMutableAttributedString *iconString = [[NSMutableAttributedString alloc] initWithString:ion_heart attributes:@{NSFontAttributeName: [IonIcons fontWithSize:14]}];
    NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d", self.user.upvotesCountValue] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    [iconString appendAttributedString:countString];
    UILabel *upvotesLabel = [UILabel new];
    upvotesLabel.attributedText = iconString;
    [wapView addSubview:upvotesLabel];
    
    // 简介
    UILabel *descLabel = [UILabel new];
    descLabel.text = self.user.desc;
    descLabel.font = [UIFont systemFontOfSize:12];
    descLabel.textColor = [UIColor grayColor];
    [wapView addSubview:descLabel];
    
    // 显示近期笔记按钮
    UIView *showEntriesView = [UIView new];
    [wapView addSubview:showEntriesView];
    
    // 笔记数
    UILabel *entriesCountLabel = [UILabel new];
    entriesCountLabel.text = [NSString stringWithFormat:@"%d", self.user.entriesCountValue];
    entriesCountLabel.textColor = [UIColor colorWithRGBA:0x666666FF];
    entriesCountLabel.font = [UIFont systemFontOfSize:24];
    [showEntriesView addSubview:entriesCountLabel];
    
    // 笔记label
    UILabel *entriesTextLabel = [UILabel new];
    entriesTextLabel.text = @"近期笔记";
    entriesTextLabel.textColor = [UIColor colorWithRGBA:0x999999FF];
    entriesTextLabel.font = [UIFont systemFontOfSize:12];
    [showEntriesView addSubview:entriesTextLabel];
    
    // 显示关注话题按钮
    UIView *showTopicsView = [UIView new];
    [wapView addSubview:showTopicsView];
    
    // 话题数
    UILabel *topicsCountLabel = [UILabel new];
    topicsCountLabel.text = [NSString stringWithFormat:@"%d", self.user.followedTopicsCountValue];
    topicsCountLabel.textColor = [UIColor colorWithRGBA:0x666666FF];
    topicsCountLabel.font = [UIFont systemFontOfSize:24];
    [showEntriesView addSubview:topicsCountLabel];
    
    // 话题label
    UILabel *topicsTextLabel = [UILabel new];
    topicsTextLabel.text = @"关注话题";
    topicsTextLabel.textColor = [UIColor colorWithRGBA:0x999999FF];
    topicsTextLabel.font = [UIFont systemFontOfSize:12];
    [showEntriesView addSubview:topicsTextLabel];
    
    // 约束
    
    [hideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wapView).offset(-5);
        make.top.equalTo(wapView).offset(5);
    }];
    
    [wapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@260);
        make.height.equalTo(@350);
        make.center.equalTo(self);
    }];
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@60);
        make.top.equalTo(wapView).offset(30);
        make.centerX.equalTo(wapView);
    }];
    
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wapView);
        make.top.equalTo(avatarView.mas_bottom).offset(12);
    }];
    
    [upvotesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wapView);
        make.top.equalTo(userLabel.mas_bottom).offset(10);
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upvotesLabel.mas_bottom).offset(20).priorityHigh();
        make.centerX.equalTo(wapView);
    }];
    
    [showEntriesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(wapView);
        make.width.equalTo(wapView.mas_width).multipliedBy(.5);
    }];
    
    [entriesCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showEntriesView);
        make.top.equalTo(showEntriesView).offset(35);
        
    }];
    
    [entriesTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showEntriesView);
        make.top.equalTo(entriesCountLabel.mas_bottom).offset(5);
        make.bottom.equalTo(showEntriesView).offset(-35);
    }];
    
    [showTopicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(wapView);
        make.width.equalTo(wapView.mas_width).multipliedBy(.5);
    }];
    
    [topicsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showTopicsView);
        make.top.equalTo(showTopicsView).offset(35);
        
    }];
    
    [topicsTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showTopicsView);
        make.top.equalTo(topicsCountLabel.mas_bottom).offset(5);
        make.bottom.equalTo(showTopicsView).offset(-35);
    }];
}

- (void)show
{
    [self showWithDuration:self.duration];
}

- (void)showWithDuration:(CGFloat)duration
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    [window setNeedsLayout];
    [window layoutIfNeeded];
    
    [UIView animateWithDuration:self.duration animations:^{
        self.backgroundColor = [UIColor colorWithRGBA:0x00000099];
        self.wapView.alpha = 1;
    }];
}

- (void)hide
{
    [self hideWithDuration:self.duration];
}

- (void)hideWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:self.duration animations:^{
        self.backgroundColor = [UIColor colorWithRGBA:0x00000000];
        self.wapView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
