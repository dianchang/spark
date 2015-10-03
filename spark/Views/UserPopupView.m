//
//  UserPopupView.m
//  spark
//
//  Created by hustlzp on 15/9/30.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import "SPTopic.h"
#import "UserPopupView.h"
#import "EntryView.h"
#import "TopicBriefView.h"
#import "UIColor+Helper.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>
#import <MagicalRecord/MagicalRecord.h>
#import <ionicons/IonIcons.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

static const NSInteger popupWidth = 260;
static const NSInteger popupHeight = 360;

@interface UserPopupView ()

@property (nonatomic) CGFloat duration;
@property (strong, nonatomic) UIView *wapView;
@property (strong, nonatomic) SPUser *user;
@property (strong, nonatomic) NSArray *topics;
@property (strong, nonatomic) NSArray *entries;

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UILabel *upvotesLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UIView *metaDataView;
@property (strong, nonatomic) UIView *showEntriesView;
@property (strong, nonatomic) UILabel *entriesCountLabel;
@property (strong, nonatomic) UILabel *entriesTextLabel;
@property (strong, nonatomic) UIView *showTopicsView;
@property (strong, nonatomic) UILabel *topicsCountLabel;
@property (strong, nonatomic) UILabel *topicsTextLabel;

@property (strong, nonatomic) UIScrollView *entriesScrollView;
@property (strong, nonatomic) UIScrollView *topicsScrollView;

@property (nonatomic) BOOL detailsDidShow;
@property (nonatomic) BOOL entryDetaisDidShow;
@property (nonatomic) BOOL topicDetailsDidShow;

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
                                             initWithTarget:self action:@selector(backgroundPressed:)];
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
    self.avatarView = avatarView;
    [wapView addSubview:avatarView];
    
    // 用户名
    UILabel *userLabel = [UILabel new];
    userLabel.text = self.user.name;
    userLabel.font = [UIFont fontWithName:SPLanTingFontName size:16];
    self.userLabel = userLabel;
    [wapView addSubview:userLabel];
    
    // 赞数
    NSMutableAttributedString *iconString = [[NSMutableAttributedString alloc] initWithString:ion_heart attributes:@{NSFontAttributeName: [IonIcons fontWithSize:14]}];
    NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d", self.user.upvotesCountValue] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    [iconString appendAttributedString:countString];
    UILabel *upvotesLabel = [UILabel new];
    upvotesLabel.attributedText = iconString;
    self.upvotesLabel = upvotesLabel;
    [wapView addSubview:upvotesLabel];
    
    // 简介
    UILabel *descLabel = [UILabel new];
    descLabel.text = self.user.desc;
    descLabel.font = [UIFont systemFontOfSize:12];
    descLabel.textColor = [UIColor grayColor];
    self.descLabel = descLabel;
    [wapView addSubview:descLabel];
    
    UIView *metaDataView = [UIView new];
    self.metaDataView = metaDataView;
    [wapView addSubview:metaDataView];
    
    // 显示近期笔记按钮
    UIView *showEntriesView = [UIView new];
    [metaDataView addSubview:showEntriesView];
    self.showEntriesView = showEntriesView;
    showEntriesView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureForShowEntries = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showEntries)];
    [showEntriesView addGestureRecognizer:gestureForShowEntries];
    
    // 笔记数
    UILabel *entriesCountLabel = [UILabel new];
    self.entriesCountLabel = entriesCountLabel;
    entriesCountLabel.text = [NSString stringWithFormat:@"%d", self.user.entriesCountValue];
    entriesCountLabel.textColor = [UIColor colorWithRGBA:0x666666FF];
    entriesCountLabel.font = [UIFont systemFontOfSize:24];
    [showEntriesView addSubview:entriesCountLabel];
    
    // 笔记label
    UILabel *entriesTextLabel = [UILabel new];
    self.entriesTextLabel = entriesTextLabel;
    entriesTextLabel.text = @"近期笔记";
    entriesTextLabel.textColor = [UIColor colorWithRGBA:0x999999FF];
    entriesTextLabel.font = [UIFont systemFontOfSize:12];
    [showEntriesView addSubview:entriesTextLabel];
    
    // 显示关注话题按钮
    UIView *showTopicsView = [UIView new];
    [metaDataView addSubview:showTopicsView];
    self.showTopicsView = showTopicsView;
    showTopicsView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureForShowTopics = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTopics)];
    [showTopicsView addGestureRecognizer:gestureForShowTopics];
    
    // 话题数
    UILabel *topicsCountLabel = [UILabel new];
    self.topicsCountLabel = topicsCountLabel;
    topicsCountLabel.text = [NSString stringWithFormat:@"%d", self.user.followedTopicsCountValue];
    topicsCountLabel.textColor = [UIColor colorWithRGBA:0x666666FF];
    topicsCountLabel.font = [UIFont systemFontOfSize:24];
    [showEntriesView addSubview:topicsCountLabel];
    
    // 话题label
    UILabel *topicsTextLabel = [UILabel new];
    self.topicsTextLabel = topicsTextLabel;
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
        make.width.equalTo([NSNumber numberWithLong:popupWidth]);
        make.height.equalTo([NSNumber numberWithLong:popupHeight]);
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
    
    [metaDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.wapView);
    }];
    
    [showEntriesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(metaDataView);
        make.width.equalTo(metaDataView.mas_width).multipliedBy(.5);
    }];
    
    [entriesCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showEntriesView).offset(10);
        make.top.equalTo(showEntriesView).offset(35);
        
    }];
    
    [entriesTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showEntriesView).offset(10);
        make.top.equalTo(entriesCountLabel.mas_bottom).offset(5);
        make.bottom.equalTo(showEntriesView).offset(-35);
    }];
    
    [showTopicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(metaDataView);
        make.width.equalTo(metaDataView.mas_width).multipliedBy(.5);
    }];
    
    [topicsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showTopicsView).offset(-10);
        make.top.equalTo(showTopicsView).offset(35);
        
    }];
    
    [topicsTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showTopicsView).offset(-10);
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

- (void)backgroundPressed:(UITapGestureRecognizer *)recognizer
{
    CGPoint touchPoint = [recognizer locationInView:self.wapView];
    if (!CGRectContainsPoint(self.wapView.bounds, touchPoint)) {
        [self hide];
    }
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

#pragma mark - User Interface

- (void)showEntries
{
    if (!self.detailsDidShow) {
        [self showDetailsWithCompletion:^{
            self.entriesScrollView.hidden = NO;
            self.topicsScrollView.hidden = YES;
        }];
    } else {
        self.entriesScrollView.hidden = NO;
        self.topicsScrollView.hidden = YES;
    }
}

- (void)showTopics
{
    if (!self.detailsDidShow) {
        [self showDetailsWithCompletion:^{
            self.entriesScrollView.hidden = YES;
            self.topicsScrollView.hidden = NO;
        }];
    } else {
        self.entriesScrollView.hidden = YES;
        self.topicsScrollView.hidden = NO;
    }
}

#pragma mark - Internal Helpers

- (void)showDetailsWithCompletion:(void (^)(void))completionBlock;
{
    self.detailsDidShow = YES;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self.wapView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithLong:window.frame.size.height - 20 * 2]);
    }];
    
    [self.userLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.wapView);
        make.top.equalTo(self.wapView).offset(15);
    }];
    
    [self.entriesCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.showEntriesView).offset(20);
    }];
    
    [self.entriesTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.showEntriesView).offset(-20);
    }];
    
    [self.topicsCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.showTopicsView).offset(20);
    }];
    
    [self.topicsTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.showTopicsView).offset(-20);
    }];
    
    [self.metaDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.wapView);
        make.top.equalTo(self.userLabel.mas_bottom);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [window setNeedsLayout];
        [window layoutIfNeeded];
        
        self.avatarView.alpha = 0;
        self.upvotesLabel.alpha = 0;
        self.descLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [self.avatarView removeFromSuperview];
        [self.upvotesLabel removeFromSuperview];
        [self.descLabel removeFromSuperview];
        
        // 间隔
        UIView *gapView = [UIView new];
        gapView.backgroundColor = [UIColor colorWithRGBA:0xF2F2F2FF];
        [self.wapView addSubview:gapView];
        
        // entries滚动框
        UIScrollView *entriesScrollView = [UIScrollView new];
        self.entriesScrollView = entriesScrollView;
        [self.wapView addSubview:entriesScrollView];
        
        // topics滚动框
        UIScrollView *topicsScrollView = [UIScrollView new];
        self.topicsScrollView = topicsScrollView;
        [self.wapView addSubview:topicsScrollView];
        
        // 约束
        [gapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.metaDataView.mas_bottom);
            make.left.right.equalTo(self.wapView);
            make.height.equalTo(@8);
        }];
        
        [entriesScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(gapView.mas_bottom);
            make.left.right.bottom.equalTo(self.wapView);
        }];
        
        [topicsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(gapView.mas_bottom);
            make.left.right.bottom.equalTo(self.wapView);
        }];
        
        if (!self.entryDetaisDidShow) {
            [self createEntries];
        }
        
        if (!self.topicDetailsDidShow) {
            [self createTopics];
        }
        
        if (completionBlock) {
            completionBlock();
        }
    }];
}

- (void)createEntries
{
    self.entryDetaisDidShow = YES;
    
    UIView *entriesWapView = [UIView new];
    EntryView *prevEntryView;
    
    [self.entriesScrollView addSubview:entriesWapView];
    
    for (int i = 0; i < self.entries.count; i++) {
        SPEntry *entry = self.entries[i];
        EntryView *entryView = [[EntryView alloc] initWithEntry:entry padding:UIEdgeInsetsMake(15, 15, 15, 15)];
        [entriesWapView addSubview:entryView];
        
        if (i == 0) {
            [entryView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(entriesWapView);
            }];
        } else {
            [entryView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(prevEntryView.mas_bottom);
            }];
        }
        
        [entryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(entriesWapView);
        }];
        
        if (i == self.topics.count - 1) {
            [entryView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(entriesWapView);
            }];
        }
        
        prevEntryView = entryView;
    }
    
    CGSize size = [entriesWapView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    entriesWapView.frame = CGRectMake(0, 0, popupWidth, size.height);
    self.entriesScrollView.contentSize = CGSizeMake(popupWidth, size.height);
}

- (void)createTopics
{
    self.topicDetailsDidShow = YES;
    
    UIView *topicsWapView = [UIView new];
    TopicBriefView *prevTopicBriefView;
    
    [self.topicsScrollView addSubview:topicsWapView];
    
    for (int i = 0; i < self.topics.count; i++) {
        SPTopic *topic = self.topics[i];
        TopicBriefView *topicBriefView = [[TopicBriefView alloc] initWithTopic:topic];
        [topicsWapView addSubview:topicBriefView];
        
        if (i == 0) {
            [topicBriefView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(topicsWapView);
            }];
        } else {
            [topicBriefView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(prevTopicBriefView.mas_bottom);
            }];
        }
        
        [topicBriefView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(topicsWapView);
        }];
        
        if (i == self.topics.count - 1) {
            [topicBriefView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(topicsWapView);
            }];
        }
        
        prevTopicBriefView = topicBriefView;
    }
    
    CGSize size = [topicsWapView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    topicsWapView.frame = CGRectMake(15, 0, popupWidth - 15 * 2, size.height);
    self.topicsScrollView.contentSize = CGSizeMake(popupWidth, size.height);
}

#pragma mark - Getters & Setters

- (NSArray *)topics
{
    if (!_topics) {
        _topics = [SPTopic MR_findAll];
    }
    
    return _topics;
}

- (NSArray *)entries
{
    if (!_entries) {
        _entries = [self.user.entries allObjects];
    }
    
    return _entries;
}

@end
