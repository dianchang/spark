//
//  TopicsView.h
//  spark
//
//  Created by hustlzp on 15/9/27.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPTopic.h"
#import <UIKit/UIKit.h>

@protocol TopicsListViewDelegate <NSObject>

- (void)topicPressed:(SPTopic *)topic;

@end

@interface TopicsListView : UIView

@property (weak, nonatomic) id <TopicsListViewDelegate> delegate;
@property (nonatomic) UIEdgeInsets margin;
//@property (nonatomic) CGFloat cornerRadius;
//@property (nonatomic) CGFloat borderWidth;
//@property (strong, nonatomic) UIColor *borderColor;
//@property (strong, nonatomic) UIColor *textColor;
//@property (nonatomic) UIEdgeInsets padding;
//@property (strong, nonatomic) UIColor *tagBackgroundColor;
//@property (strong, nonatomic) UIColor *tagSelectedBackgroundColor;
//@property (strong, nonatomic) UIFont *textFont;
@property (strong, nonatomic) NSArray *topics;

- (instancetype)initWithTopics:(NSArray *)topics;
- (void)addTopic:(SPTopic *)topic;
//- (void)removeAllTopics;

@end
