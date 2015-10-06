//
//  EntryView.h
//  spark
//
//  Created by hustlzp on 15/10/1.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import "SPUser.h"
#import "TopicsListView.h"
#import <UIKit/UIKit.h>

@protocol EntryViewDelegate <TopicsListViewDelegate>

- (void)commentButtonPressed:(SPEntry *)entry;

@end

@interface EntryView : UIView

@property (weak, nonatomic) id <EntryViewDelegate> delegate;

- (void)updateWithEntry:(SPEntry *)entry;
- (instancetype)initWithEntry:(SPEntry *)entry padding:(UIEdgeInsets)padding;
- (instancetype)initWithPadding:(UIEdgeInsets)padding;

@end
