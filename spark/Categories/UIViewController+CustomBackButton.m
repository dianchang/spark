//
//  UIViewController+CustomBackButton.m
//  spark
//
//  Created by hustlzp on 15/10/7.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "UIViewController+CustomBackButton.h"
#import <ionicons/IonIcons.h>

@implementation UIViewController (CustomBackButton)

- (void)replaceBackButton
{
    UIImage *adminIcon = [IonIcons imageWithIcon:ion_android_arrow_back size:28 color:[UIColor lightGrayColor]];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:adminIcon style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = rightButton;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
