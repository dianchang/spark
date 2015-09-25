//
//  AddEntryViewController.h
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPPresentedViewControllerProtocol.h"
#import <UIKit/UIKit.h>

@interface AddEntryViewController : UIViewController

@property (strong, nonatomic) id<SPPresentedViewControllerProtocol> delegate;

@end
