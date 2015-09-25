//
//  AddEntryViewController.m
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AddEntryViewController.h"
#import "AddTopicViewController.h"
#import "UIColor+Helper.h"
#import "SPPresentedViewControllerProtocol.h"
#import "UIColor+Helper.h"
#import <ionicons/IonIcons.h>
#import <Masonry/Masonry.h>

@interface AddEntryViewController ()

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIView *addTopicWap;

@end

@implementation AddEntryViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor SPBackgroundColor];
    
    [self createViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
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
    
    // 添加话题框
    UIView *addTopicWap = [UIView new];
    addTopicWap.backgroundColor = [UIColor whiteColor];
    self.addTopicWap = addTopicWap;
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), .5);
    border.backgroundColor = [UIColor colorWithRGBA:0xDDDDDDFF].CGColor;
    [addTopicWap.layer addSublayer:border];
    [self.view addSubview:addTopicWap];
    
    // 添加话题按钮
    UIButton *addTopicButton = [UIButton new];
    [addTopicWap addSubview:addTopicButton];
    addTopicButton.layer.cornerRadius = 12;
    addTopicButton.layer.masksToBounds = YES;
    addTopicButton.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    [addTopicButton setTitle:@"+ 添加话题" forState:UIControlStateNormal];
    [addTopicButton setTitleColor:[UIColor SPTopicForegroundColor] forState:UIControlStateNormal];
    addTopicButton.titleLabel.font = [UIFont systemFontOfSize:12];
    addTopicButton.backgroundColor = [UIColor SPTopicBackgroundColor];
    [addTopicButton addTarget:self action:@selector(addTopic) forControlEvents:UIControlEventTouchUpInside];
    
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
    }];
    
    [addTopicWap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(15);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [addTopicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addTopicWap).offset(15);
        make.top.equalTo(addTopicWap).offset(10);
        make.bottom.equalTo(addTopicWap).offset(-10);
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

- (void)addTopic
{
    UIViewController *addTopicViewController = [AddTopicViewController new];
    [self.navigationController pushViewController:addTopicViewController animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    [self.addTopicWap mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardFrame.size.height);
    }];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.addTopicWap mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - SomeDelegate

#pragma mark - Internal Helpers

#pragma mark - Getters & Setters


@end
