//
//  MessageViewController.m
//  spark
//
//  Created by hustlzp on 15/9/24.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPDialog.h"
#import "SPMessage.h"
#import "SPUser.h"
#import "SPNotification.h"
#import "MessageTableViewCell.h"
#import "BadgeView.h"
#import "MessageViewController.h"
#import "DialogViewController.h"
#import "Constants.h"
#import "UIColor+Helper.h"
#import <Masonry/Masonry.h>
#import <MagicalRecord/MagicalRecord.h>

static NSString * const cellIdentifier = @"MessageCell";
static UIColor *navButtonInactiveColor;

@interface MessageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (nonatomic) NSInteger currentSelectedIndex;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dialogs;
@property (strong, nonatomic) NSArray *notifications;

@end

@implementation MessageViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentSelectedIndex = 0;
    
    navButtonInactiveColor = [UIColor colorWithRGBA:0xAEB2B4FF];
    
    [self createViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"聊天";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Layout

- (void)createViews {
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 150;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // titleView
    UIView *titleView = [UIView new];
    
    UIButton *leftButton = [UIButton new];
    self.leftButton = leftButton;
    [leftButton setTitle:@"聊天" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor SPColorMain] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:SPLanTingFontName size:17];
    [leftButton addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    [titleView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton new];
    self.rightButton = rightButton;
    [rightButton setTitle:@"通知" forState:UIControlStateNormal];
    [rightButton setTitleColor:navButtonInactiveColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:SPLanTingFontName size:17];
    [rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    rightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    [titleView addSubview:rightButton];
    
    // badge
    BadgeView *badgeView = [[BadgeView alloc] initWithNumber:2 withBorder:NO];
    [titleView addSubview:badgeView];
    
    // titleView 约束
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView).offset(5);
        make.left.bottom.equalTo(titleView);
    }];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView).offset(5);
        make.right.bottom.equalTo(titleView);
        make.left.equalTo(leftButton.mas_right).offset(40);
    }];
    
    [badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rightButton).offset(30);
        make.centerY.equalTo(rightButton).offset(-2);
    }];
    
    CGSize size = [titleView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    titleView.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.navigationItem.titleView = titleView;
}

#pragma mark - Public Interface

#pragma mark - User Interface

- (void)leftButtonPressed
{
    self.currentSelectedIndex = 0;
    [self.leftButton setTitleColor:[UIColor SPColorMain] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:navButtonInactiveColor forState:UIControlStateNormal];
    [self.tableView reloadData];
}

- (void)rightButtonPressed
{
    self.currentSelectedIndex = 1;
    [self.leftButton setTitleColor:navButtonInactiveColor forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor SPColorMain] forState:UIControlStateNormal];
    [self.tableView reloadData];
}

# pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.currentSelectedIndex == 0) {
        return self.dialogs.count;
    } else {
        return self.notifications.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (self.currentSelectedIndex == 0) {
        SPDialog *dialog = self.dialogs[indexPath.row];
        [cell updateDataWithDialog:dialog];
    } else {
        SPNotification *notification = self.notifications[indexPath.row];
        [cell updateDataWithNotification:notification];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DialogViewController *controller;
    SPBaseDialog *dialog;
    
    if (self.currentSelectedIndex == 0) {
        dialog = self.dialogs[indexPath.row];
        
    } else {
        dialog = self.notifications[indexPath.row];
    }
    
    controller = [[DialogViewController alloc] initWithBaseDialog:dialog];
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters

- (NSArray *)dialogs
{
    if (!_dialogs) {
        _dialogs = [SPDialog MR_findAllSortedBy:@"createdAt" ascending:YES];
    }
    
    return _dialogs;
}

- (NSArray *)notifications
{
    if (!_notifications) {
        _notifications = [SPNotification MR_findAllSortedBy:@"createdAt" ascending:YES];
    }
    
    return _notifications;
}

@end
