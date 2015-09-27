//
//  MessageTableViewCell.m
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "BaseMessageTableViewCell.h"
#import "UIColor+Helper.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>

@interface BaseMessageTableViewCell ()

@end

@implementation BaseMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // 头像
    UIImageView *userAvatarView = [UIImageView new];
    self.userAvatarView = userAvatarView;
    [self.contentView addSubview:userAvatarView];
    userAvatarView.layer.cornerRadius = 20;
    userAvatarView.layer.masksToBounds = YES;
    
    // 名称
    UILabel *userNameLabel = [UILabel new];
    self.userNameLabel = userNameLabel;
    userNameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:userNameLabel];
    
    // 消息
    UILabel *contentLabel = [UILabel new];
    self.contentLabel = contentLabel;
    contentLabel.textColor = [UIColor colorWithRGBA:0x999999FF];
    contentLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:contentLabel];
    
    // 时间
    UILabel *createAtLabel = [UILabel new];
    createAtLabel.font = [UIFont systemFontOfSize:12];
    createAtLabel.textColor = [UIColor colorWithRGBA:0xAAAAAAFF];
    self.createdAtLabel = createAtLabel;
    [self.contentView addSubview:createAtLabel];
    
    // 边框
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor colorWithRGBA:0xEEEEEEFF];
    [self.contentView addSubview:bottomBorder];
    
    // 约束
    
    [userAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(13);
        make.width.height.equalTo(@40);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userAvatarView);
        make.left.equalTo(userAvatarView.mas_right).offset(15);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameLabel);
        make.top.equalTo(userNameLabel.mas_bottom).offset(6);
    }];
    
    [createAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userAvatarView);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [bottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameLabel);
        make.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@.5);
    }];
    
    return self;
}

@end
