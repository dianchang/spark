//
//  MessageTableViewCell.h
//  spark
//
//  Created by hustlzp on 15/9/26.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPMessage.h"
#import "BaseMessageTableViewCell.h"
#import <UIKit/UIKit.h>

@interface MessageTableViewCell : BaseMessageTableViewCell

- (void)updateDataWithMessage:(SPMessage *)message;

@end
