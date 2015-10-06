//
//  MessageView.m
//  spark
//
//  Created by hustlzp on 15/10/6.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import "MessageView.h"
#import "UIColor+Helper.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <Masonry/Masonry.h>

@interface MessageView ()

@property (strong, nonatomic) SPUser *currentUser;

@end

@implementation MessageView

- (instancetype)initWithMessage:(SPMessage *)message
{
    return [self initWithUser:message.sender content:message.content fromEntry:message.fromEntry];
}

- (instancetype)initWithEntry:(SPEntry *)entry
{
    return [self initWithUser:entry.user content:entry.content fromEntry:YES];
}

- (instancetype)initWithUser:(SPUser *)user content:(NSString *)content fromEntry:(BOOL)fromEntry
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // 头像
    UIImageView *avatarView = [UIImageView new];
    [avatarView setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
    avatarView.layer.cornerRadius = 17.5;
    avatarView.layer.masksToBounds = YES;
    [self addSubview:avatarView];
    
    // 对话
    UIView *messageContentWapView = [UIView new];
    if ([user isEqualToManagedObject:self.currentUser]) {
        messageContentWapView.backgroundColor = [UIColor SPColorMain];
    } else {
        messageContentWapView.backgroundColor = [UIColor colorWithRGBA:0xF3F3F9FF];
    }
    messageContentWapView.layer.cornerRadius = 2;
    messageContentWapView.layer.masksToBounds = YES;
    [self addSubview:messageContentWapView];
    
    // message
    UILabel *messageLabel = [UILabel new];
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.numberOfLines = 0;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    CGRect textRect = [content boundingRectWithSize:CGSizeMake(160, FLT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:messageLabel.font}
                                                    context:nil];
    NSInteger lines = textRect.size.height / messageLabel.font.pointSize;
    
    if (lines > 1) {
        paragraphStyle.lineSpacing = 5;
    } else {
        paragraphStyle.lineSpacing = 0;
    }
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    messageLabel.attributedText = attributedString;
    if ([user isEqualToManagedObject:self.currentUser]) {
        messageLabel.textColor = [UIColor whiteColor];
    }
    [messageContentWapView addSubview:messageLabel];
    
    UILabel *tipLable = [UILabel new];
    [self addSubview:tipLable];
    if (fromEntry) {
        tipLable.text = @"来自笔记";
        tipLable.font = [UIFont systemFontOfSize:10];
        tipLable.textColor = [UIColor grayColor];
    }
    
    // 约束
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@35);
        make.top.equalTo(self).offset(15);
        
        if ([user isEqualToManagedObject:self.currentUser]) {
            make.right.equalTo(self).offset(-15);
        } else {
            make.left.equalTo(self).offset(15);
        }
    }];
    
    [messageContentWapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarView);
        make.width.lessThanOrEqualTo(@180);
        
        if ([user isEqualToManagedObject:self.currentUser]) {
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
        make.bottom.equalTo(self);
    }];
    
    return self;
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
