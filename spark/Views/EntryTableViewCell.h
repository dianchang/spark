//
//  EntryTableViewCell.h
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import <UIKit/UIKit.h>

@interface EntryTableViewCell : UITableViewCell

- (void)updateWithEntry:(SPEntry *)entry;

@end
