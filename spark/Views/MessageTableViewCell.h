//
//  MessageTableViewCell.h
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPMessage.h"
#import "SPDialog.h"
#import "SPNotification.h"
#import "SPNotification.h"
#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *userAvatarView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *createdAtLabel;

@property (strong, nonatomic) SPDialog *dialog;
- (void)updateDataWithDialog:(SPDialog *)dialog;

@property (strong, nonatomic) SPNotification *notification;
- (void)updateDataWithNotification:(SPNotification *)notification;

@end
