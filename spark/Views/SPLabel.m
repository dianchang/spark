//
//  SPLabel.m
//  spark
//
//  Created by hustlzp on 15/10/2.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPLabel.h"

@implementation SPLabel

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.numberOfLines == 0) {
        self.preferredMaxLayoutWidth = self.bounds.size.width;
    }
}

@end
