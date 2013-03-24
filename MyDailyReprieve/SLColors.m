//
//  SLColors.m
//  MyDailyReprieve
//
//  Created by Scott Lucien on 3/23/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import "SLColors.h"

// USE THIS CLASS FOR THE APP COLOR SCHEME

@implementation SLColors

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *)lightTanColor {
    return [self colorFromHexString:@"#F3E8C8"];
}

+ (UIColor *)darkerTanColor {
    return [self colorFromHexString:@"#E1D2A9"];
}

+ (UIColor *)greenTextColor {
    return [self colorFromHexString:@"#6E7641"];
}

@end
