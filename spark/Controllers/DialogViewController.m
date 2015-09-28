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
#import <Masonry/Masonry.h>

@interface DialogViewController ()

@property (strong, nonatomic) UITextField *commentInputField;
@property (strong, nonatomic) SPUser *user;

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
    
    self.navigationItem.title = self.user.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.commentInputField becomeFirstResponder];
}

#pragma mark - Layout

- (void)createViews
{
    UIView *commentBarView = [self createCommentView];
    [self.view addSubview:commentBarView];
    
    [commentBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - Public Interface

#pragma mark - User Interface

#pragma mark - SomeDelegate

#pragma mark - Internal Helpers

- (UIView *)createCommentView
{
    UIView *commentView = [UIView new];
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] applicationFrame]), 0.5);
    border.backgroundColor = [[UIColor colorWithRGBA:0xBBBBBBFF] CGColor];
    [commentView.layer addSublayer:border];
    commentView.backgroundColor = [UIColor colorWithRGBA:0xEEEEEEFF];
    
    // 内层容器
    UIView *innerView = [UIView new];
    innerView.backgroundColor = [UIColor whiteColor];
    innerView.layer.cornerRadius = 5;
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
        make.edges.equalTo(commentView).insets(UIEdgeInsetsMake(6, 10, 6, 10));
    }];
    
    [inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(innerView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    return commentView;
}

#pragma mark - Getters & Setters


@end
