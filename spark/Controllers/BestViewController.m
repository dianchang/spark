//
//  BestViewController.m
//  spark
//
//  Created by hustlzp on 15/9/24.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "BestViewController.h"
#import "AddEntryViewController.h"
#import <ionicons/IonIcons.h>

@interface BestViewController ()

@end

@implementation BestViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
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

#pragma mark - SPPresentedViewControllerProtocol

- (void)didDismissPresentedViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters


@end
