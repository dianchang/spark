//
//  DraggableEntryView.h
//  spark
//
//  Created by hustlzp on 15/9/28.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import <UIKit/UIKit.h>

@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface EntryDraggableView : UIView

@property (weak, nonatomic) id <DraggableViewDelegate> delegate;

- (instancetype)initWithEntry:(SPEntry *)entry;

@end