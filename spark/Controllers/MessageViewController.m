//
//  MessageViewController.m
//  spark
//
//  Created by hustlzp on 15/9/24.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPMessage.h"
#import "SPUser.h"
#import "MessageTableViewCell.h"
#import "MessageViewController.h"
#import <Masonry/Masonry.h>
#import <MagicalRecord/MagicalRecord.h>

static NSString * const cellIdentifier = @"MessageCell";

@interface MessageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;

@end

@implementation MessageViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectZero];
    titleView.frame = CGRectMake(0, 0, [titleView intrinsicContentSize].width, [titleView intrinsicContentSize].height);
    
    UIButton *leftButton = [UIButton new];
    [leftButton setTitle:@"消息" forState:UIControlStateNormal];
    
    [titleView setTitle:@"消息" forState:UIControlStateNormal];
    titleView.backgroundColor = [UIColor blackColor];
    self.navigationItem.titleView = titleView;
    
//    [titleView ma]
    NSLog(@"%@", self.navigationItem.titleView.superview);
}

#pragma mark - Public Interface

#pragma mark - User Interface

# pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPMessage *message = self.messages[indexPath.row];
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell updateDataWithMessage:message];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters

- (NSArray *)messages
{
    if (!_messages) {
        _messages = [SPMessage MR_findAllSortedBy:@"createdAt" ascending:NO];
    }
    
    return _messages;
}


@end
