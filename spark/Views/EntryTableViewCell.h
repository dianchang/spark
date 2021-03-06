//
//  EntryTableViewCell.h
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import "EntryView.h"
#import "SPUser.h"
#import "TopicsListView.h"
#import <UIKit/UIKit.h>

@interface EntryTableViewCell : UITableViewCell

@property (weak, nonatomic) id <EntryViewDelegate> delegate;

- (void)updateWithEntry:(SPEntry *)entry;

@end
