//
//  MessageView.h
//  spark
//
//  Created by hustlzp on 15/10/6.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import "SPMessage.h"
#import <UIKit/UIKit.h>

@interface MessageView : UIView

- (instancetype)initWithMessage:(SPMessage *)message;
- (instancetype)initWithEntry:(SPEntry *)entry;

@end
