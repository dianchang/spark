//
//  PopularityPopupView.m
//  spark
//
//  Created by hustlzp on 15/10/3.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import "PopularityPopupView.h"
#import "UIColor+Helper.h"
#import "Constants.h"
#import <ionicons/IonIcons.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <Masonry/Masonry.h>
#import <PNChart/PNChart.h>

static const NSInteger popupWidth = 260;
static const NSInteger popupHeight = 440;

@interface PopularityPopupView ()

@property (strong, nonatomic) SPEntry *entry;
@property (strong, nonatomic) UIView *wapView;

@end

@implementation PopularityPopupView

- (instancetype)initWithEntry:(SPEntry *)entry
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.entry = entry;
    
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
    self.wapView = wapView;
    wapView.backgroundColor = [UIColor whiteColor];
    wapView.layer.cornerRadius = 5;
    wapView.layer.masksToBounds = YES;
    [self addSubview:wapView];
    wapView.alpha = 0;
    
    // 关闭按钮
    UIButton *hideButton = [UIButton new];
    hideButton.titleLabel.font = [IonIcons fontWithSize:24];
    [hideButton setTitle:ion_android_close forState:UIControlStateNormal];
    [hideButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [wapView addSubview:hideButton];
    [hideButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    // 图表
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20, 30, popupWidth - 20 * 2, 150.0)];
    barChart.isShowNumbers = NO;
    barChart.barBackgroundColor = [UIColor clearColor];
    [barChart setXLabels:@[[NSString stringWithFormat:@"%@人", self.entry.upvotesCount], [NSString stringWithFormat:@"%@人", self.entry.downvotesCount]]];
    barChart.strokeColors = @[[UIColor colorWithRGBA:0xFD9191FF], [UIColor colorWithRGBA:0x868AA4FF]];
    barChart.isGradientShow = NO;
    barChart.barRadius = 0;
    barChart.yMaxValue = 280;
    barChart.barWidth = 20;
    barChart.showChartBorder = YES;
    [barChart setYValues:@[self.entry.upvotesCount, self.entry.downvotesCount]];
    [barChart strokeChart];
    [wapView addSubview:barChart];
    
    // 图表说明
    NSMutableAttributedString *graphTipFirstString = [[NSMutableAttributedString alloc] initWithString:@"在笔记发出后 " attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor grayColor]}];
    NSMutableAttributedString *graphTipSecondString = [[NSMutableAttributedString alloc] initWithString:@"9小时23分钟" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor SPColorMain]}];
    NSMutableAttributedString *graphTipThirdString = [[NSMutableAttributedString alloc] initWithString:@" 内" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor grayColor]}];
    [graphTipFirstString appendAttributedString:graphTipSecondString];
    [graphTipFirstString appendAttributedString:graphTipThirdString];
    UILabel *graphTipLabel = [UILabel new];
    graphTipLabel.attributedText = graphTipFirstString;
    [wapView addSubview:graphTipLabel];
    
    // 流行度
    UILabel *popularityLabel = [UILabel new];
    popularityLabel.text = [NSString stringWithFormat:@"%d%%", (int)((double)self.entry.upvotesCountValue * 100 / (self.entry.upvotesCountValue + self.entry.downvotesCountValue))];
    popularityLabel.font = [UIFont fontWithName:SPLanTingFontName size:34];
    popularityLabel.textColor = [UIColor SPColorMain];
    [wapView addSubview:popularityLabel];
    
    // 流行度附加文字
    UILabel *popularityAdditionLabel = [UILabel new];
    popularityAdditionLabel.text = @"的人喜欢了它，并把它传播给更多人";
    popularityAdditionLabel.font = [UIFont systemFontOfSize:12];
    popularityAdditionLabel.textColor = [UIColor grayColor];
    [wapView addSubview:popularityAdditionLabel];
    
    // 头像
    UIImageView *avatarView = [UIImageView new];
    [avatarView setImageWithURL:[NSURL URLWithString:self.entry.user.avatarUrl]];
    avatarView.layer.cornerRadius = 15;
    avatarView.layer.masksToBounds = YES;
    [wapView addSubview:avatarView];
    
    // 约束
    
    [wapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithLong:popupWidth]);
        make.height.equalTo([NSNumber numberWithLong:popupHeight]);
        make.center.equalTo(self);
    }];
    
    [hideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wapView).offset(-5);
        make.top.equalTo(wapView).offset(5);
    }];
    
    [graphTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wapView);
        make.top.equalTo(barChart.mas_bottom).offset(-10);
    }];
    
    [popularityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wapView);
        make.bottom.equalTo(popularityAdditionLabel.mas_top).offset(-15);
    }];
    
    [popularityAdditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wapView);
        make.bottom.equalTo(avatarView.mas_top).offset(-50);
    }];
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wapView).offset(-30);
        make.centerX.equalTo(wapView);
        make.width.height.equalTo(@30);
    }];
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    [window setNeedsLayout];
    [window layoutIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = [UIColor colorWithRGBA:0x00000099];
        self.wapView.alpha = 1;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = [UIColor colorWithRGBA:0x00000000];
        self.wapView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)backgroundPressed:(UITapGestureRecognizer *)recognizer
{
    CGPoint touchPoint = [recognizer locationInView:self.wapView];
    if (!CGRectContainsPoint(self.wapView.bounds, touchPoint)) {
        [self hide];
    }
}

@end
