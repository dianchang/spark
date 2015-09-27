//
//  MyProfileViewController.m
//  spark
//
//  Created by hustlzp on 15/9/24.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import "MyProfileViewController.h"
#import "Constants.h"
#import "UIColor+Helper.h"
#import <Masonry/Masonry.h>
#import <Ionicons/IonIcons.h>
#import <MagicalRecord/MagicalRecord.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MyProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) SPUser *currentUser;

@end

@implementation MyProfileViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor SPColorMain];
    
    [self createViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLayoutSubviews
{
    [self sizeHeaderViewToFit];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Layout

- (void)createViews
{
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor SPColorMain];
    [self.view addSubview:topView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [self.tableView setTableHeaderView:[self createHeaderView]];
    
    // 约束
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@20);
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - Public Interface

#pragma mark - User Interface

# pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self configTableViewCell:cell key:@"笔记" value:@"91条"];
        } else {
            [self configTableViewCell:cell key:@"话题" value:@"已关注18个"];
        }
    } else if (indexPath.section == 1) {
        [self configTableViewCell:cell key:@"个人资料" value:nil];
    } else {
        [self configTableViewCell:cell key:@"设置" value:nil];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Internal Helpers

- (void)configTableViewCell:(UITableViewCell *)cell key:(NSString *)key value:(NSString *)value
{
    UILabel *keyLabel = [UILabel new];
    keyLabel.text = key;
    keyLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:keyLabel];
    
    UILabel *valueLabel = [UILabel new];
    valueLabel.textColor = [UIColor grayColor];
    if (value) {
        valueLabel.text = value;
    }
    valueLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:valueLabel];
    
    // 约束
    [keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(15);
        make.width.equalTo(@80);
    }];
    
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
    }];
}

- (UIView *)createHeaderView
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor SPColorMain];
    
    // 头像
    UIImageView *avatarView = [UIImageView new];
    [avatarView setImageWithURL:[NSURL URLWithString:self.currentUser.avatarUrl]];
    avatarView.layer.cornerRadius = 30;
    avatarView.layer.borderWidth = 1.8;
    avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarView.layer.masksToBounds = YES;
    [headerView addSubview:avatarView];
    
    // 用户名
    UILabel *userLabel = [UILabel new];
    userLabel.text = self.currentUser.name;
    userLabel.textColor = [UIColor whiteColor];
    userLabel.font = [UIFont fontWithName:SPLanTingFontName size:16];
    [headerView addSubview:userLabel];

    // 赞数
    NSMutableAttributedString *iconString = [[NSMutableAttributedString alloc] initWithString:ion_heart attributes:@{NSFontAttributeName: [IonIcons fontWithSize:14]}];
    NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d", self.currentUser.upvotesCountValue] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    [iconString appendAttributedString:countString];
    UILabel *upvotesLabel = [UILabel new];
    upvotesLabel.attributedText = iconString;
    upvotesLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:upvotesLabel];
    
    // 简介
    UILabel *descLabel = [UILabel new];
    descLabel.text = self.currentUser.desc;
    descLabel.font = [UIFont systemFontOfSize:12];
    descLabel.textColor = [UIColor grayColor];
    [headerView addSubview:descLabel];
    
    // 约束
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@60);
        make.top.equalTo(headerView).offset(30);
        make.centerX.equalTo(headerView);
    }];
    
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(avatarView.mas_bottom).offset(10);
    }];
    
    [upvotesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(userLabel.mas_bottom).offset(10);
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upvotesLabel.mas_bottom).offset(15);
        make.centerX.equalTo(headerView);
        make.bottom.equalTo(headerView).offset(-30);
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
    [self.tableView setTableHeaderView:headerView];
}

#pragma mark - Getters & Setters

- (SPUser *)currentUser
{
    if (!_currentUser) {
        _currentUser = [SPUser MR_findFirstByAttribute:@"name" withValue:@"哈丁"];
    }
    
    return _currentUser;
}

@end
