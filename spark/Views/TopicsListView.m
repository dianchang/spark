//
//  TopicsView.m
//  spark
//
//  Created by hustlzp on 15/9/27.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "TopicView.h"
#import "TopicsListView.h"
#import <Masonry/Masonry.h>

@interface TopicsListView ()

@property (strong, nonatomic) NSMutableArray *topicViews;
@property (nonatomic) NSInteger rows;
@property (nonatomic) CGFloat topicViewHeight;

@end

@implementation TopicsListView

- (void)addTopic:(SPTopic *)topic
{
    [self.topicViews addObject:[self createTopicViewWithTopic:topic]];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//- (void)removeAllTopics
//{
//    for (TopicView *topicView in self.topicViews) {
//        [topicView removeFromSuperview];
//    }
//    
//    [self.topicViews removeAllObjects];
//    [self setNeedsLayout];
//}

//- (CGSize)intrinsicContentSize
//{
//    CGFloat height = self.rows * (self.topicViewHeight + self.margin.bottom);
//    if (self.rows > 0) {
//        height -= self.margin.bottom;
//    }
//    
//    return CGSizeMake(self.frame.size.width, height);
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (TopicView *topicView in self.topicViews) {
        [topicView removeFromSuperview];
    }

    NSInteger currentRow = 0;
    NSInteger currentRowTagCount = 0;
    CGFloat currentRowWidth = 0;
    CGFloat tagViewWidth, tagViewHeight = 0.0, tagViewX, tagViewY;
    
    for (TopicView *tagView in self.topicViews) {
        tagViewWidth = [tagView intrinsicContentSize].width;
        tagViewHeight = [tagView intrinsicContentSize].height;

        if (currentRowTagCount == 0 || currentRowWidth + tagViewWidth + self.margin.bottom > self.frame.size.width) {
            currentRow += 1;
            tagViewX = 0;
        } else {
            tagViewX = currentRowWidth;
        }
        
        tagViewY = (currentRow - 1) * (tagViewHeight + self.margin.bottom);
        currentRowTagCount += 1;
        currentRowWidth += tagViewWidth + self.margin.right;
        
        tagView.frame = CGRectMake(tagViewX, tagViewY, tagViewWidth, tagViewHeight);
        
        [self addSubview:tagView];
    }
    
    self.rows = currentRow;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithLong:(currentRow - 1) * (tagViewHeight + self.margin.bottom) + tagViewHeight]);
    }];
}

- (TopicView *)createTopicViewWithTopic:(SPTopic *)topic
{
    TopicView *topicView = [[TopicView alloc] initWithTopic:topic];
    
//    if (self.textColor) {
//        topicView.textColor = self.textColor;
//    }
//    
//    if (self.tagBackgroundColor) {
//        self.tagBackgroundColor
//    }
//    
//    topicView.tagBackgroundColor = self.tagBackgroundColor;
//    topicView.tagSelectedBackgroundColor = self.tagSelectedBackgroundColor;
//    topicView.cornerRadius = self.cornerRadius;
//    topicView.borderWidth = self.borderWidth;
//    topicView.borderColor = self.borderColor;
//    topicView.padding = self.padding;
//    topicView.textFont = self.textFont;
    
    [topicView addTarget:self action:@selector(topicPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return topicView;
}

#pragma mark - User Interface
     
- (void)topicPressed:(TopicView *)topicView
{
    [topicView pressed];
    [self.delegate topicPressed:topicView.topic];
}

#pragma mark - Getters & Setters

//- (void)setTextColor:(UIColor *)textColor
//{
//    for (TopicView *topicView in self.topicViews) {
//        topicView.textColor = textColor;
//    }
//}
//
//- (void)setTagBackgroundColor:(UIColor *)tagBackgroundColor
//{
//    for (TopicView *topicView in self.topicViews) {
//        topicView.tagBackgroundColor = tagBackgroundColor;
//    }
//}
//
//- (void)setTagSelectedBackgroundColor:(UIColor *)tagSelectedBackgroundColor
//{
//    for (TopicView *topicView in self.topicViews) {
//        topicView.tagSelectedBackgroundColor = tagSelectedBackgroundColor;
//    }
//}
//
//- (void)setCornerRadius:(CGFloat)cornerRadius
//{
//    for (TopicView *topicView in self.topicViews) {
//        topicView.cornerRadius = cornerRadius;
//    }
//}
//
//- (void)setBorderWidth:(CGFloat)borderWidth
//{
//    for (TopicView *topicView in self.topicViews) {
//        topicView.borderWidth = borderWidth;
//    }
//}
//
//- (void)setBorderColor:(UIColor *)borderColor
//{
//    for (TopicView *topicView in self.topicViews) {
//        topicView.borderColor = borderColor;
//    }
//}
//
//- (void)setPadding:(UIEdgeInsets)padding
//{
//    for (TopicView *topicView in self.topicViews) {
//        topicView.padding = padding;
//    }
//    
//    [self setNeedsLayout];
//}
//
//- (void)setTextFont:(UIFont *)textFont
//{
//    for (TopicView *topicView in self.topicViews) {
//        topicView.textFont = textFont;
//    }
//    
//    [self setNeedsLayout];
//}

- (UIEdgeInsets)margin
{
    return UIEdgeInsetsMake(5, 10, 5, 10);;
}

- (void)setTopics:(NSArray *)topics
{
    _topics = topics;
    
    for (TopicView *topicView in self.topicViews) {
        [topicView removeFromSuperview];
    }
    
    for (SPTopic *topic in topics) {
        [self.topicViews addObject:[self createTopicViewWithTopic:topic]];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (NSMutableArray *)topicViews
{
    if (!_topicViews) {
        _topicViews = [NSMutableArray new];
    }
    
    return _topicViews;
}

@end
