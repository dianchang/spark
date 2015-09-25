//
//  MessageTableViewCell.h
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMessageTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *userAvatarView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *createdAtLabel;

@end
