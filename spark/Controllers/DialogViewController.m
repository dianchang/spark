//
//  DialogViewController.m
//  spark
//
//  Created by hustlzp on 15/9/28.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPDialog.h"
#import "SPNotification.h"
#import "SPUser.h"
#import "MessageView.h"
#import "DialogViewController.h"
#import "UIColor+Helper.h"
#import "Constants.h"
#import "UIViewController+CustomBackButton.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <ionicons/IonIcons.h>

@interface DialogViewController ()

@property (strong, nonatomic) UIView *commentBarView;
@property (strong, nonatomic) UITextField *commentInputField;
@property (strong, nonatomic) SPBaseDialog *dialog;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *backdropView;

@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) SPUser *currentUser;

@end

@implementation DialogViewController

#pragma mark - LifeCycle

- (instancetype)initWithBaseDialog:(SPBaseDialog *)baseDialog;
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.dialog = baseDialog;
    
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self replaceBackButton];
    
    // titleView
    UIView *titleView = [UIView new];
    
    SPUser *user;
    UILabel *userLabel = [UILabel new];
    
    if ([self.dialog isKindOfClass:[SPDialog class]]) {
        user = ((SPDialog *)self.dialog).dialogist;
    } else {
        user = ((SPNotification *)self.dialog).sender;
    }
    
    userLabel.text = user.name;
    userLabel.textColor = [UIColor SPColorMain];
    userLabel.font = [UIFont fontWithName:SPLanTingFontName size:17];
    [titleView addSubview:userLabel];
    
    UILabel *descLabel = [UILabel new];
    descLabel.text = user.desc;
    descLabel.textColor = [UIColor lightGrayColor];
    descLabel.font = [UIFont systemFontOfSize:10];
    [titleView addSubview:descLabel];
    
    // titleView 约束
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView);
        make.centerX.equalTo(titleView);
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userLabel.mas_bottom);
        make.centerX.equalTo(titleView);
        make.bottom.equalTo(titleView);
    }];

    CGSize size = [titleView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    titleView.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.navigationItem.titleView = titleView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.commentInputField becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Layout

- (void)createViews
{
    // 滚动栏
    UIScrollView *scrollView = [UIScrollView new];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    UIView *contentView = [UIView new];
    [scrollView addSubview:contentView];
    
    // 评论栏
    UIView *commentBarView = [self createCommentView];
    self.commentBarView = commentBarView;
    [self.view addSubview:commentBarView];
    
    UIView *prevMessageView;
    
    for (int i = 0; i < self.messages.count; i++) {
        MessageView *messageView = [[MessageView alloc] initWithMessage:self.messages[i]];
        [contentView addSubview:messageView];
        
        if (i == 0) {
            [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(contentView);
            }];
        } else {
            [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(prevMessageView.mas_bottom);
            }];
        }
        
        [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
        }];
        
        if (i == self.messages.count - 1) {
            [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(contentView).offset(-15);
            }];
        }
        
        prevMessageView = messageView;
    }
    
    CGSize size = [contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, size.height);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, size.height);
    
    // 约束
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(commentBarView.mas_top);
    }];
    
    [commentBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - Public Interface

#pragma mark - User Interface

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    [self.view addSubview:self.backdropView];
    [self.backdropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.commentBarView.mas_top);
    }];
    
    [self.commentBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardFrame.size.height);
    }];
    
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.commentBarView.mas_top);
    }];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
        
        if (self.scrollView.contentSize.height > self.scrollView.bounds.size.height) {
            CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
            [self.scrollView setContentOffset:bottomOffset animated:NO];
        }
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.commentBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.commentBarView.mas_top).offset(SPTabBarHeight);
    }];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.backdropView removeFromSuperview];
    }];
}

- (void)hideKeyboard
{
    [self.commentInputField resignFirstResponder];
}

#pragma mark - SomeDelegate

#pragma mark - Internal Helpers

- (UIView *)createCommentView
{
    UIView *commentView = [UIView new];
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] applicationFrame]), 0.5);
    border.backgroundColor = [[UIColor colorWithRGBA:0xCCCCCCFF] CGColor];
    [commentView.layer addSublayer:border];
    commentView.backgroundColor = [UIColor colorWithRGBA:0xEEEEEEFF];
    
    // 内层容器
    UIView *innerView = [UIView new];
    innerView.backgroundColor = [UIColor whiteColor];
    innerView.layer.cornerRadius = 3;
    innerView.layer.masksToBounds = YES;
    innerView.layer.borderColor=[[UIColor colorWithRGBA:0xDDDDDDFF] CGColor];
    innerView.layer.borderWidth= .5f;
    [commentView addSubview:innerView];
    
    // 输入框
    UITextField *inputField = [UITextField new];
//    inputField.delegate = self;
    inputField.returnKeyType = UIReturnKeySend;
    self.commentInputField = inputField;
    inputField.backgroundColor = [UIColor whiteColor];
    inputField.placeholder = @"回复";
    [innerView addSubview:inputField];
    
    // 约束
    
    [innerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(commentView).insets(UIEdgeInsetsMake(6, 8, 6, 8));
    }];
    
    [inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(innerView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    return commentView;
}

#pragma mark - Getters & Setters

- (SPUser *)currentUser
{
    if (!_currentUser) {
        _currentUser = [SPUser findCurrentUser];
    }
    
    return _currentUser;
}

- (NSArray *)messages
{
    if (!_messages) {
        NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
        _messages = [[self.dialog.messages allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    }
    
    return _messages;
}

- (UIView *)backdropView
{
    if (!_backdropView) {
        _backdropView = [UIView new];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        [_backdropView addGestureRecognizer:tapGesture];
        [_backdropView addGestureRecognizer:panGesture];
    }
    
    return _backdropView;
}

@end
