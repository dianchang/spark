//
//  CommentEntryViewController.m
//  spark
//
//  Created by hustlzp on 15/10/6.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import "MessageView.h"
#import "CommentEntryViewController.h"
#import "Constants.h"
#import "UIColor+Helper.h"
#import <Masonry/Masonry.h>

@interface CommentEntryViewController ()

@property (strong, nonatomic) SPUser *currentUser;
@property (strong, nonatomic) SPEntry *entry;
@property (strong, nonatomic) UIView *commentBarView;
@property (strong, nonatomic) UITextField *commentInputField;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *backdropView;

@end

@implementation CommentEntryViewController

#pragma mark - LifeCycle

- (instancetype)initWithEntry:(SPEntry *)entry
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.entry = entry;
    
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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = self.entry.user.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
    
    MessageView *messageView = [[MessageView alloc] initWithEntry:self.entry];
    [contentView addSubview:messageView];
    
    // 评论栏
    UIView *commentBarView = [self createCommentView];
    self.commentBarView = commentBarView;
    [self.view addSubview:commentBarView];

    // 约束
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView).insets(UIEdgeInsetsMake(0, 0, 15, 0));
    }];
    
    [commentBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(scrollView.mas_bottom);
    }];

    CGSize size = [contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, size.height);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, size.height);
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
        make.bottom.equalTo(self.view).offset(-keyboardFrame.size.height + SPTabBarHeight);
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
