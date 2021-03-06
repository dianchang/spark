//
//  DraggableEntryView.h
//  spark
//
//  Created by hustlzp on 15/9/28.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import "SPEntry.h"
#import "TopicsListView.h"
#import <UIKit/UIKit.h>

@protocol DraggableViewDelegate <NSObject>

- (void)cardSwipedLeft:(UIView *)card;
- (void)cardSwipedRight:(UIView *)card;
- (void)commentButtonPressed:(SPEntry *)entry;

@end

@interface EntryDraggableView : UIView

@property (weak, nonatomic) id <DraggableViewDelegate ,TopicsListViewDelegate> delegate;

- (instancetype)initWithEntry:(SPEntry *)entry;

@end
