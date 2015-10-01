//
//  UserPopupView.h
//  spark
//
//  Created by hustlzp on 15/9/30.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPUser.h"
#import <UIKit/UIKit.h>

@interface UserPopupView : UIView

- (instancetype)initWithUser:(SPUser *)user;

- (void)show;
- (void)showWithDuration:(CGFloat)duration;

- (void)hide;
- (void)hideWithDuration:(CGFloat)duration;

@end
