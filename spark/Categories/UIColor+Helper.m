//
//  UIColor+Helper.m
//  
//
//  Created by hustlzp on 15/8/17.
//
//

#import "UIColor+Helper.h"

@implementation UIColor (Helper)

+ (UIColor *)colorWithRGBA:(NSUInteger)color
{
    return [UIColor colorWithRed:((color >> 24) & 0xFF) / 255.0f
                           green:((color >> 16) & 0xFF) / 255.0f
                            blue:((color >> 8) & 0xFF) / 255.0f
                           alpha:((color) & 0xFF) / 255.0f];
}

+ (UIColor *)SPColorMain
{
    return [self colorWithRGBA:0x474E54FF];
}

+ (UIColor *)SPColorLightMain
{
    return [self colorWithRGBA:0x9E9F9FFF];
}

+ (UIColor *)SPBackgroundColor
{
    return [self colorWithRGBA:0xF7F9F8FF];
}

+ (UIColor *)SPTopicBackgroundColor
{
    return [self colorWithRGBA:0xF4F4FAFF];
}

+ (UIColor *)SPTopicForegroundColor
{
    return [self colorWithRGBA:0x8A8E9BFF];
}

@end
