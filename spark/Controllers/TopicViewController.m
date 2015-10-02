//
//  TopicViewController.m
//  spark
//
//  Created by hustlzp on 15/9/27.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "EntryTableViewCell.h"
#import "TopicViewController.h"
#import "DialogViewController.h"
#import <Masonry/Masonry.h>

static NSString * const cellIdentifier = @"EntryCell";

@interface TopicViewController () <UITableViewDataSource, UITableViewDelegate, TopicsListViewDelegate, EntryViewDelegate>

@property (strong, nonatomic) SPTopic *topic;
@property (strong, nonatomic) UITableView *tableView;
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
    self.navigationItem.title = [NSString stringWithFormat:@"「%@」", self.topic.name];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    
    // 约束
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Public Interface

#pragma mark - User Interface

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
    UIViewController *controller = [[DialogViewController alloc] initWithUser:user];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters


@end
