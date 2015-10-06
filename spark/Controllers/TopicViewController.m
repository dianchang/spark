//
//  TopicViewController.m
//  spark
//
//  Created by hustlzp on 15/9/27.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "EntryTableViewCell.h"
#import "SPLabel.h"
#import "TopicViewController.h"
#import "DialogViewController.h"
#import "Constants.h"
#import "UIColor+Helper.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>
#import <ionicons/IonIcons.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

static NSString * const cellIdentifier = @"EntryCell";

@interface TopicViewController () <UITableViewDataSource, UITableViewDelegate, TopicsListViewDelegate, EntryViewDelegate>

@property (strong, nonatomic) SPTopic *topic;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) NSArray *entries;

@end

@implementation TopicViewController

#pragma mark - LifeCycle

- (instancetype)initWithTopic:(SPTopic *)topic
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.topic = topic;
    self.entries = [topic.entries allObjects];
    
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), SPNavBarHeight)];
    newNavBar.backgroundColor = [UIColor clearColor];
    
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    [newNavBar setItems:@[newItem]];
    
    newNavBar.shadowImage = [[UIImage alloc] init];
    [newNavBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *adminIcon = [IonIcons imageWithIcon:ion_ios_gear_outline size:28 color:[UIColor lightGrayColor]];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:adminIcon style:UIBarButtonItemStylePlain target:self action:@selector(adminTopic)];
    newNavBar.topItem.rightBarButtonItem = rightButton;
    
    UIImage *backIcon = [IonIcons imageWithIcon:ion_ios_arrow_left size:28 color:[UIColor lightGrayColor]];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:backIcon style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    newNavBar.topItem.leftBarButtonItem = leftButton;
    
    [self.view addSubview:newNavBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLayoutSubviews
{
    [self sizeHeaderViewToFit];
}

#pragma mark - Layout

- (void)createViews {
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 150;
    [self.view addSubview:tableView];
    [tableView registerClass:[EntryTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    tableView.tableHeaderView = [self createHeaderView];
    
    // 约束
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-SPStatusBarHeight);
    }];
}

- (UIView *)createHeaderView
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor SPBackgroundColor];
    
    if (self.topic.avatarUrl) {
        // 头像
        UIImageView *avatarView = [UIImageView new];
        self.avatarView = avatarView;
        [avatarView setImageWithURL:[NSURL URLWithString:self.topic.avatarUrl]];
        avatarView.layer.cornerRadius = 3;
        avatarView.layer.masksToBounds = YES;
        [headerView addSubview:avatarView];
    }
    
    // 话题名
    SPLabel *topicNameLabel = [SPLabel new];
    topicNameLabel.text = self.topic.name;
    topicNameLabel.font = [UIFont fontWithName:SPLanTingFontName size:18];
    [headerView addSubview:topicNameLabel];
    
    // 简介
    SPLabel *descLabel = [SPLabel new];
    descLabel.text = self.topic.desc;
    descLabel.font = [UIFont systemFontOfSize:12];
    descLabel.numberOfLines = 0;
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descLabel.textColor = [UIColor grayColor];
    [headerView addSubview:descLabel];
    
    // 数据wap
    UIView *countWapView = [UIView new];
    [headerView addSubview:countWapView];
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 40, .5);
    border.backgroundColor = [UIColor colorWithRGBA:0xDDDDDDFF].CGColor;
    [countWapView.layer addSublayer:border];
    UILabel *countLabel = [UILabel new];
    countLabel.text = @"271 条笔记";
    countLabel.textColor = [UIColor grayColor];
    countLabel.font = [UIFont systemFontOfSize:12];
    [countWapView addSubview:countLabel];
    
    NSMutableAttributedString *entriesCountString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d", self.topic.entriesCountValue] attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
    NSMutableAttributedString *entriesCountTextString = [[NSMutableAttributedString alloc] initWithString:@" 条笔记，" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    NSMutableAttributedString *followersCountString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d", self.topic.followersCountValue] attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
    NSMutableAttributedString *followerCountTextString = [[NSMutableAttributedString alloc] initWithString:@" 人关注" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    [entriesCountString appendAttributedString:entriesCountTextString];
    [entriesCountString appendAttributedString:followersCountString];
    [entriesCountString appendAttributedString:followerCountTextString];
    countLabel.attributedText = entriesCountString;
    
    UIButton *followButton = [UIButton new];
    followButton.layer.cornerRadius = 3;
    followButton.layer.masksToBounds = YES;
    [followButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    [followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    followButton.titleLabel.font = [UIFont fontWithName:SPLanTingFontName size:14];
    followButton.contentEdgeInsets = UIEdgeInsetsMake(8, 12, 6, 12);
    followButton.backgroundColor = [UIColor colorWithRGBA:0x23CC95FF];
    [countWapView addSubview:followButton];
    
    // 约束
    
    if (self.topic.avatarUrl) {
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@50);
            make.top.equalTo(headerView).offset(SPStatusBarHeight + 10);
            make.centerX.equalTo(headerView);
        }];
    }
    
    [topicNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        if (self.topic.avatarUrl) {
            make.top.equalTo(self.avatarView.mas_bottom).offset(10);
        } else {
            make.top.equalTo(headerView).offset(SPStatusBarHeight + 12);
        }
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topicNameLabel.mas_bottom).offset(15).priorityHigh();
        make.left.equalTo(headerView).offset(20).priorityHigh();
        make.right.equalTo(headerView).offset(-20);
    }];
    
    [countWapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descLabel.mas_bottom).offset(20);
        make.left.equalTo(headerView).offset(20).priorityHigh();
        make.right.equalTo(headerView).offset(-20);
        make.bottom.equalTo(headerView);
    }];
    
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countWapView);
        make.top.equalTo(countWapView).offset(18);
        make.bottom.equalTo(countWapView).offset(-18);
    }];
    
    [followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countLabel);
        make.right.equalTo(countWapView);
    }];
    
    return headerView;
}

- (void)sizeHeaderViewToFit
{
    UIView *headerView = self.tableView.tableHeaderView;
    [headerView setNeedsLayout];
    [headerView layoutIfNeeded];
    CGSize size = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGRect frame = headerView.frame;
    frame.size.height = size.height;
    headerView.frame = frame;
    
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, frame.size.height - .5, frame.size.width, .5);
    border.backgroundColor = [UIColor colorWithRGBA:0xBBBBBBFF].CGColor;
    [headerView.layer addSublayer:border];
    
    [self.tableView setTableHeaderView:headerView];
}

#pragma mark - Public Interface

#pragma mark - User Interface

- (void)adminTopic
{

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPEntry *entry = self.entries[indexPath.row];
    EntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.delegate = self;
    [cell updateWithEntry:entry];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TopicsListViewDelegate

- (void)topicPressed:(SPTopic *)topic
{
    TopicViewController *viewController = [[TopicViewController alloc] initWithTopic:topic];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - EntryCellDelegate

- (void)commentButtonPressed:(SPUser *)user
{
//    UIViewController *controller = [[DialogViewController alloc] initWithUser:user];
//    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters


@end
