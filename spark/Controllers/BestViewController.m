//
//  BestViewController.m
//  spark
//
//  Created by hustlzp on 15/9/24.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import "EntryTableViewCell.h"
#import "BestViewController.h"
#import "AddEntryViewController.h"
#import "TopicViewController.h"
#import "UIColor+Helper.h"
#import "Constants.h"
#import <ionicons/IonIcons.h>
#import <MagicalRecord/MagicalRecord.h>
#import <Masonry/Masonry.h>

static NSString * const cellIdentifier = @"EntryCell";

@interface BestViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *entries;

@end

@implementation BestViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"今日最佳";
    UIImage *plusIcon = [IonIcons imageWithIcon:ion_android_add size:28 color:[UIColor lightGrayColor]];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:plusIcon style:UIBarButtonItemStylePlain target:self action:@selector(addEntry)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

#pragma mark - Layout

- (void)createViews {
    // 提示
    UIView *tipLabelWap = [UIView new];
    tipLabelWap.backgroundColor = [UIColor SPBackgroundColor];
    [self.view addSubview:tipLabelWap];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.font = [UIFont systemFontOfSize:10];
    tipLabel.textColor = [UIColor colorWithRGBA:0x848D8fFF];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"根据你关注的话题，为你选出 24 小时内最佳笔记";
    [tipLabelWap addSubview:tipLabel];
    
    // 表格
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
    
    // 约束
    [tipLabelWap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tipLabelWap).insets(UIEdgeInsetsMake(5, 0, 5, 0));
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabelWap.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - Public Interface

#pragma mark - User Interface

- (void)addEntry
{
    AddEntryViewController *addEntryViewController = [AddEntryViewController new];
    addEntryViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addEntryViewController];
    [self presentViewController:navController animated:YES completion:nil];
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
    cell.viewController = self;
    [cell updateWithEntry:entry];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mard - TopicsListViewDelegate

- (void)topicPressed:(SPTopic *)topic
{
    TopicViewController *viewController = [[TopicViewController alloc] initWithTopic:topic];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - SPPresentedViewControllerProtocol

- (void)didDismissPresentedViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters

- (NSArray *)entries
{
    if (!_entries) {
        _entries = [SPEntry MR_findAllSortedBy:@"createdAt" ascending:NO];
    }
    
    return _entries;
}


@end
