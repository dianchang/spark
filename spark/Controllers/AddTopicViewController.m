//
//  AddTopicViewController.m
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPTopic.h"
#import "AddTopicViewController.h"
#import "UIColor+Helper.h"
#import "Constants.h"
#import <Masonry/Masonry.h>
#import <MagicalRecord/MagicalRecord.h>

static NSString * const cellIdentifier = @"TopicSearchCell";

@interface AddTopicViewController () <UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *topics;
@property (strong, nonatomic) NSString *searchString;
@property (nonatomic) BOOL exactlyMatched;

@end

@implementation AddTopicViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor SPBackgroundColor];
    
    [self createViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = self.searchController.searchBar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.searchController.active = YES;
}

#pragma mark - Layout

- (void)createViews
{
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController = searchController;
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"搜索话题";
    
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    self.tableView.backgroundColor = [UIColor SPBackgroundColor];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Public Interface

#pragma mark - User Interface

#pragma mark - UISearchControllerDelegate

- (void)didPresentSearchController:(UISearchController *)searchController
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchController.searchBar becomeFirstResponder];
    });
    
    UIButton* cancelButton = [self.searchController.searchBar valueForKey:@"cancelButton"];
    [cancelButton setTitle:@"完成" forState:UIControlStateNormal];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    
    self.searchString = searchString;
    
    SPTopic *topic = [SPTopic MR_findFirstByAttribute:@"name" withValue:searchString];
    if (topic) {
        self.exactlyMatched = YES;
        self.topics = @[topic];
    } else {
        self.exactlyMatched = NO;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchString];
        self.topics = [SPTopic MR_findAllWithPredicate:predicate];
    }

    [self.tableView reloadData];
}

# pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.searchString length] != 0 && !self.exactlyMatched) {
        return self.topics.count + 1;
    } else {
        return self.topics.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [UITableViewCell new];
    }
    
    if ([self.searchString length] != 0 && !self.exactlyMatched) {
        if (indexPath.row == 0) {
            NSMutableAttributedString *perfixString = [[NSMutableAttributedString alloc] initWithString:@"+ 新建：" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor SPTopicForegroundColor]}];
            NSMutableAttributedString *topicString = [[NSMutableAttributedString alloc] initWithString:self.searchString attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor SPTopicForegroundColor]}];
            [perfixString appendAttributedString:topicString];
            cell.textLabel.attributedText = perfixString;
        } else {
            SPTopic *topic = self.topics[indexPath.row - 1];
            NSMutableAttributedString *topicString = [[NSMutableAttributedString alloc] initWithString:topic.name attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor SPTopicForegroundColor]}];
            cell.textLabel.attributedText = topicString;
        }
    } else {
        SPTopic *topic = self.topics[indexPath.row];
        NSMutableAttributedString *topicString = [[NSMutableAttributedString alloc] initWithString:topic.name attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor SPTopicForegroundColor]}];
        cell.textLabel.attributedText = topicString;
    }
    
    cell.backgroundColor = [UIColor SPBackgroundColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.searchString length] != 0 && !self.exactlyMatched) {
        if (indexPath.row == 0) {
            
        } else {
            SPTopic *topic = self.topics[indexPath.row - 1];
            
        }
    } else {
        SPTopic *topic = self.topics[indexPath.row];
        
    }
}

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters

@end
