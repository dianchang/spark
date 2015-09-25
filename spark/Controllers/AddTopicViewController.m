//
//  AddTopicViewController.m
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "AddTopicViewController.h"
#import "UIColor+Helper.h"

@interface AddTopicViewController ()

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
    self.navigationItem.title = @"添加话题";
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
