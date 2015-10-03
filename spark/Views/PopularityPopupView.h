//
//  PopularityPopupView.h
//  spark
//
//  Created by hustlzp on 15/10/3.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import <UIKit/UIKit.h>

@interface PopularityPopupView : UIView

- (instancetype)initWithEntry:(SPEntry *)entry;

- (void)show;
- (void)hide;

@end
