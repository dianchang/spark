//
//  DraggableEntryView.m
//  spark
//
//  Created by hustlzp on 15/9/28.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPTopic.h"
#import "SPUser.h"
#import "EntryDraggableView.h"
#import "UIColor+Helper.h"
#import <QuartzCore/QuartzCore.h>
#import <ionicons/IonIcons.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

#define ACTION_MARGIN 120 // distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 // how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 // upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 // the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 // strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 // Higher = stronger rotation angle

@interface EntryDraggableView ()

@property (strong, nonatomic) SPEntry *entry;
@property (strong, nonatomic) TopicsListView *topicsView;
@property (nonatomic) CGFloat xFromCenter;
@property (nonatomic) CGFloat yFromCenter;
@property (nonatomic) CGPoint originalPoint;

@end

@implementation EntryDraggableView

- (instancetype)initWithEntry:(SPEntry *)entry
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.entry = entry;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRGBA:0xE2E2E2FF].CGColor;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
    [self addGestureRecognizer:panGestureRecognizer];
    
    // 话题
    TopicsListView *topicsView = [[TopicsListView alloc] initWithTopics:[entry.topics allObjects]];
    self.topicsView = topicsView;
    [self addSubview:topicsView];
    
    // 内容
    UILabel *contentLabel = [UILabel new];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:entry.content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, entry.content.length)];
    contentLabel.attributedText = attributedString;
    [self addSubview:contentLabel];

    // 用户头像
    UIImageView *userAvatarView = [UIImageView new];
    userAvatarView.layer.cornerRadius = 20;
    userAvatarView.layer.masksToBounds = YES;
    [userAvatarView setImageWithURL:[NSURL URLWithString:entry.user.avatarUrl]];
    [self addSubview:userAvatarView];
    
    // 用户名
    UIButton *userNameButton = [UIButton new];
    userNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [userNameButton setTitle:entry.user.name forState:UIControlStateNormal];
    [userNameButton setTitleColor:[UIColor colorWithRGBA:0x9E9E9EFF] forState:UIControlStateNormal];
    [self addSubview:userNameButton];
    
    // border
    UIView *borderView = [UIView new];
    borderView.backgroundColor = [UIColor colorWithRGBA:0xDDDDDDFF];
    [self addSubview:borderView];
    
    // commands
    UIView *commandsWapView = [UIView new];
    [self addSubview:commandsWapView];
    
    // 喜欢
    UIButton *upvoteButton = [UIButton new];
    upvoteButton.titleLabel.font = [IonIcons fontWithSize:35];
    [upvoteButton setTitle:ion_heart forState:UIControlStateNormal];
    [upvoteButton setTitleColor:[UIColor colorWithRGBA:0xFB9293FF] forState:UIControlStateNormal];
    upvoteButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [upvoteButton addTarget:self action:@selector(leftClickAction) forControlEvents:UIControlEventTouchUpInside];
    [commandsWapView addSubview:upvoteButton];
    
    // 消息
    UIButton *commentButton = [UIButton new];
    commentButton.titleLabel.font = [IonIcons fontWithSize:20];
    [commentButton setTitle:ion_chatbubble_working forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor colorWithRGBA:0xC1D6DEFF] forState:UIControlStateNormal];
    commentButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [commentButton addTarget:self action:@selector(commentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [commandsWapView addSubview:commentButton];
    
    // 讨厌
    UIButton *downButton = [UIButton new];
    downButton.titleLabel.font = [IonIcons fontWithSize:35];
    [downButton setTitle:ion_close forState:UIControlStateNormal];
    downButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [downButton setTitleColor:[UIColor colorWithRGBA:0x77787AFF] forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(rightClickAction) forControlEvents:UIControlEventTouchUpInside];
    [commandsWapView addSubview:downButton];
    
    // 约束
    [topicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topicsView.mas_bottom).offset(20);
        make.left.equalTo(topicsView);
        make.right.equalTo(self).offset(-20);
    }];
    
    [userAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.height.equalTo(@40);
        make.bottom.equalTo(userNameButton.mas_top).offset(-2);
    }];
    
    [userNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(borderView.mas_top).offset(-25);
    }];
    
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.bottom.equalTo(commandsWapView.mas_top);
        make.left.right.equalTo(self);
    }];
    
    [commandsWapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(commandsWapView);
    }];
    
    [upvoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commandsWapView);
        make.left.equalTo(self).offset(35);
    }];
    
    [downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commandsWapView);
        make.right.equalTo(self).offset(-35);
    }];
    
    return self;
}

#pragma mark - User Interface

- (void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    self.xFromCenter = [gestureRecognizer translationInView:self].x;
    self.yFromCenter = [gestureRecognizer translationInView:self].y;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
            
        case UIGestureRecognizerStateChanged:{
            // dictates rotation (see ROTATION_MAX and ROTATION_STRENGTH for details)
            CGFloat rotationStrength = MIN(self.xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            // degree change in radians
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            // amount the height changes when you move the card up to a certain point
            CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            // move the object's center by center + gesture coordinate
            self.center = CGPointMake(self.originalPoint.x + self.xFromCenter, self.originalPoint.y + self.yFromCenter);
            
            // rotate by certain amount
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            // scale by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            // apply transformations
            self.transform = scaleTransform;
//            [self updateOverlay:xFromCenter];
            
            break;
        };

        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
 
}

- (void)afterSwipeAction
{
    if (self.xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (self.xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
//                             overlayView.alpha = 0;
                         }];
    }
}

- (void)leftAction
{
    CGPoint finishPoint = CGPointMake(-500, 2 * self.yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     } completion:^(BOOL complete){
                         [self removeFromSuperview];
                         [self.delegate cardSwipedLeft:self];
                     }];
}

- (void)rightAction
{
    CGPoint finishPoint = CGPointMake(500, 2 * self.yFromCenter + self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     } completion:^(BOOL complete){
                         [self removeFromSuperview];
                         [self.delegate cardSwipedRight:self];
                     }];
}

- (void)leftClickAction
{
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     } completion:^(BOOL complete){
                         [self removeFromSuperview];
                         [self.delegate cardSwipedLeft:self];
                     }];
}

- (void)rightClickAction
{
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     } completion:^(BOOL complete){
                         [self removeFromSuperview];
                         [self.delegate cardSwipedRight:self];
                     }];
}

- (void)commentButtonPressed
{
    [self.delegate commentButtonPressed:self.entry.user];
}

#pragma mark - Getters & Setters

- (void)setDelegate:(id<DraggableViewDelegate,TopicsListViewDelegate>)delegate
{
    _delegate = delegate;
    self.topicsView.delegate = delegate;
}

@end
