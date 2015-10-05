//
//  Badge.m
//  spark
//
//  Created by hustlzp on 15/10/5.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "BadgeView.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>

@implementation BadgeView

- (instancetype)initWithNumber:(NSInteger)number withBorder:(BOOL)withBorder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = 7;
    self.layer.masksToBounds = YES;
    
    if (withBorder) {
        self.layer.borderWidth = .5;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    // 数字
    UILabel *numberLabel = [UILabel new];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.font = [UIFont boldSystemFontOfSize:10];
    numberLabel.text = [NSString stringWithFormat:@"%ld", (long)number];
    [self addSubview:numberLabel];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@14);
    }];
    
    // 约束
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    return self;
}

@end
