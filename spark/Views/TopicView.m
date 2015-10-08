//
//  Topic.m
//  spark
//
//  Created by hustlzp on 15/9/27.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIColor+Helper.h"
#import "TopicView.h"

@implementation TopicView

- (instancetype)initWithTopic:(SPTopic *)topic
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.cornerRadius = 12;
    self.borderWidth = 0;
    self.borderColor = [UIColor lightGrayColor];
    self.textColor = [UIColor SPTopicForegroundColor];
    self.padding = UIEdgeInsetsMake(4, 10, 4, 10);
    self.tagBackgroundColor = [UIColor SPTopicBackgroundColor];
    self.tagSelectedBackgroundColor = [UIColor colorWithRGBA:0xEEEEEEFF];
    self.textFont = [UIFont boldSystemFontOfSize:12];
    self.topic = topic;
    
    [self setTitle:topic.name forState:UIControlStateNormal];
    
    return self;
}

#pragma mark - User Interface

- (void)pressed
{
    self.backgroundColor = self.tagSelectedBackgroundColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = self.tagBackgroundColor;
    });
}

#pragma mark - Getters & Setters

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setPadding:(UIEdgeInsets)padding
{
    _padding = padding;
    self.contentEdgeInsets = padding;
}

- (void)setTagBackgroundColor:(UIColor *)tagBackgroundColor
{
    _tagBackgroundColor = tagBackgroundColor;
    self.backgroundColor = tagBackgroundColor;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    self.titleLabel.font = textFont;
}

@end
