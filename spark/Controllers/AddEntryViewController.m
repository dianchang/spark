//
//  AddEntryViewController.m
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "AddEntryViewController.h"
#import "UIColor+Helper.h"
#import "SPPresentedViewControllerProtocol.h"
#import "UIColor+Helper.h"
#import <ionicons/IonIcons.h>
#import <Masonry/Masonry.h>

@interface AddEntryViewController ()

@property (strong, nonatomic) UITextView *textView;

@end

@implementation AddEntryViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [UIView new];
    self.view.backgroundColor = [UIColor SPBackgroundColor];
    
    [self createViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Layout

- (void)createViews {
    // 关闭按钮
    UIImageView *dismissButton = [[UIImageView alloc] initWithImage:[IonIcons imageWithIcon:ion_android_close size:35 color:[UIColor SPColorLightMain]]];
    dismissButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureForCloseButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissViewController)];
    [dismissButton addGestureRecognizer:tapGestureForCloseButton];
    [self.view addSubview:dismissButton];
    
    // 发送按钮
    UIButton *sendButton = [UIButton new];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [sendButton setTitleColor:[UIColor colorWithRGBA:0x7EDA96FF] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendEntry) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    // 输入框
    UITextView *textView = [UITextView new];
    self.textView = textView;
    textView.backgroundColor = [UIColor SPBackgroundColor];
    textView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textView];
    
    // 约束
    [dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(25);
    }];
    
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(25);
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dismissButton.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view).offset(-15);
    }];
}

#pragma mark - Public Interface

#pragma mark - User Interface

- (void)dismissViewController
{
    [self.delegate didDismissPresentedViewController];
}

- (void)sendEntry
{
}

#pragma mark - SomeDelegate

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters


@end
