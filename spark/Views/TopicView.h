//
//  Topic.h
//  spark
//
//  Created by hustlzp on 15/9/27.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPTopic.h"
#import <UIKit/UIKit.h>

@interface TopicView : UIButton

@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) UIColor *borderColor;
@property (strong, nonatomic) UIColor *textColor;
@property (nonatomic) UIEdgeInsets padding;
@property (strong, nonatomic) UIColor *tagBackgroundColor;
@property (strong, nonatomic) UIColor *tagSelectedBackgroundColor;
@property (strong, nonatomic) UIFont *textFont;
@property (strong, nonatomic) SPTopic *topic;

- (instancetype)initWithTopic:(SPTopic *)topic;
- (void)pressed;

@end
