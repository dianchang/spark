//
//  TopicViewController.m
//  spark
//
//  Created by hustlzp on 15/9/27.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "TopicViewController.h"

@interface TopicViewController ()

@property (strong, nonatomic) SPTopic *topic;

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
    self.navigationItem.title = self.topic.name;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Layout

- (void)createViews {
    
}

#pragma mark - Public Interface

#pragma mark - User Interface

#pragma mark - SomeDelegate

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters


@end
