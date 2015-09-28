//
//  DialogViewController.m
//  spark
//
//  Created by hustlzp on 15/9/28.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import "DialogViewController.h"
#import "UIColor+Helper.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DialogViewController ()

@property (strong, nonatomic) UIView *commentBarView;
@property (strong, nonatomic) UITextField *commentInputField;
@property (strong, nonatomic) SPUser *user;
@property (strong, nonatomic) SPUser *currentUser;

@end

@implementation DialogViewController

#pragma mark - LifeCycle

- (instancetype)initWithUser:(SPUser *)user
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.user = user;
    
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
    self.navigationItem.title = self.currentUser.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.commentInputField becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Layout

- (void)createViews
{
    UIView *commentBarView = [self createCommentView];
    self.commentBarView = commentBarView;
    [self.view addSubview:commentBarView];
    
    // 头像
    UIImageView *avatarView = [UIImageView new];
    [avatarView setImageWithURL:[NSURL URLWithString:self.currentUser.avatarUrl]];
    avatarView.layer.cornerRadius = 17.5;
    avatarView.layer.masksToBounds = YES;
    [self.view addSubview:avatarView];
    
    // 对话
    UIView *messageWapView = [UIView new];
    messageWapView.backgroundColor = [UIColor colorWithRGBA:0xF3F3F9FF];
    messageWapView.layer.cornerRadius = 2;
    messageWapView.layer.masksToBounds = YES;
    [self.view addSubview:messageWapView];
    
    // message
    UILabel *messageLabel = [UILabel new];
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.numberOfLines = 0;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSString *message = @"讲实话，我觉得《从0到1》比《创业维艰》思维高度高了有10倍不止。《创业维艰》根本不适合每个创业者去读，而《从0到1》你应该读3遍。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, message.length)];
    messageLabel.attributedText = attributedString;
    [messageWapView addSubview:messageLabel];
    
    // Tip
    UILabel *tipLabel = [UILabel new];
    tipLabel.text = @"只有对方回复了你，此聊天才会保存";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tipLabel];
    
    // 约束
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@35);
        make.left.top.equalTo(self.view).offset(10);
    }];
    
    [messageWapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarView);
        make.left.equalTo(avatarView.mas_right).offset(10);
        make.width.equalTo(@200);
    }];
    
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(messageWapView).insets(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messageWapView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
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
    
    [self.commentBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardFrame.size.height + SPTabBarHeight);
    }];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
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

@end
