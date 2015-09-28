//
//  EntryTableViewCell.h
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import "SPUser.h"
#import "TopicsListView.h"
#import <UIKit/UIKit.h>

@protocol EntryCellDelegate <NSObject>

- (void)commentButtonPressed:(SPUser *)user;

@end

@interface EntryTableViewCell : UITableViewCell

@property (weak, nonatomic) id <TopicsListViewDelegate, EntryCellDelegate> delegate;

- (void)updateWithEntry:(SPEntry *)entry;

@end
