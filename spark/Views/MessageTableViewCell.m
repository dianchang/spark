//
//  MessageTableViewCell.m
//  spark
//
//  Created by hustlzp on 15/9/26.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import "MessageTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MessageTableViewCell ()

@property (strong, nonatomic) SPMessage *message;

@end

@implementation MessageTableViewCell

- (void)updateDataWithMessage:(SPMessage *)message
{
    self.message = message;
    [self.userAvatarView setImageWithURL:[NSURL URLWithString:message.sender.avatarUrl]];
    self.userNameLabel.text = message.sender.name;
    self.contentLabel.text = message.content;
    if (message.createAtString) {
        self.createdAtLabel.text = message.createAtString;
    }
}

@end
