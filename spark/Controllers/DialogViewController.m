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
@property (strong, nonatomic) SPBaseDialog *dialog;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) SPUser *currentUser;
@property (strong, nonatomic) NSTimer *timer;

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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
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
        UIView *messageView = [self createMessageView:self.messages[i]];
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
    }];
    
    [commentBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(scrollView.mas_bottom);
    }];
}

- (UIView *)createMessageView:(SPMessage *)message
{
    UIView *messageView = [UIView new];
    
    // 头像
    UIImageView *avatarView = [UIImageView new];
    [avatarView setImageWithURL:[NSURL URLWithString:message.sender.avatarUrl]];
    avatarView.layer.cornerRadius = 17.5;
    avatarView.layer.masksToBounds = YES;
    [messageView addSubview:avatarView];
    
    // 对话
    UIView *messageContentWapView = [UIView new];
    if ([message.sender isEqualToManagedObject:self.currentUser]) {
        messageContentWapView.backgroundColor = [UIColor SPColorMain];
    } else {
        messageContentWapView.backgroundColor = [UIColor colorWithRGBA:0xF3F3F9FF];
    }
    messageContentWapView.layer.cornerRadius = 2;
    messageContentWapView.layer.masksToBounds = YES;
    [messageView addSubview:messageContentWapView];
    
    // message
    UILabel *messageLabel = [UILabel new];
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.numberOfLines = 0;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message.content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    CGRect textRect = [message.content boundingRectWithSize:CGSizeMake(160, FLT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:messageLabel.font}
                                         context:nil];
    NSInteger lines = textRect.size.height / messageLabel.font.pointSize;
    
    if (lines > 1) {
        paragraphStyle.lineSpacing = 5;
    } else {
        paragraphStyle.lineSpacing = 0;
    }
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, message.content.length)];
    messageLabel.attributedText = attributedString;
    if ([message.sender isEqualToManagedObject:self.currentUser]) {
        messageLabel.textColor = [UIColor whiteColor];
    }
    [messageContentWapView addSubview:messageLabel];
    
    UILabel *tipLable = [UILabel new];
    [messageView addSubview:tipLable];
    if (message.fromEntryValue) {
        tipLable.text = @"来自笔记";
        tipLable.font = [UIFont systemFontOfSize:10];
        tipLable.textColor = [UIColor grayColor];
    }
    
    // 约束
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@35);
        make.top.equalTo(messageView).offset(15);
        
        if ([message.sender isEqualToManagedObject:self.currentUser]) {
            make.right.equalTo(messageView).offset(-15);
        } else {
            make.left.equalTo(messageView).offset(15);
        }
    }];
    
    [messageContentWapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarView);
        make.width.equalTo(@180);
        
        if ([message.sender isEqualToManagedObject:self.currentUser]) {
            make.right.equalTo(avatarView.mas_left).offset(-10);
        } else {
            make.left.equalTo(avatarView.mas_right).offset(10);
        }
    }];
    
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(messageContentWapView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messageContentWapView);
        make.top.equalTo(messageContentWapView.mas_bottom).offset(5);
        make.bottom.equalTo(messageView);
    }];
    
    return messageView;
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
        
        CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
        [self.scrollView setContentOffset:bottomOffset animated:NO];
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

- (NSArray *)messages
{
    if (!_messages) {
        NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
        _messages = [[self.dialog.messages allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    }
    
    return _messages;
}

@end
