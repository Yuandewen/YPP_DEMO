//
//  UIColor+YP.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/26.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "UIColor+YP.h"
#import "NSString+YP.h"

@implementation UIColor (YP)
+ (UIColor *)yp_colorWithHex:(NSString *)hex{
    
    // 删除空格
    hex = [hex yp_removeSpacing];
    
    if([hex hasPrefix:@"#"]) hex = [hex substringFromIndex:1];
    if([hex hasPrefix:@"0x"]) hex = [hex substringFromIndex:2];
    if(hex.length != 6) return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    // red
    NSString *redString = [hex substringWithRange:range];
    // green
    range.location = 2;
    NSString *greenString = [hex substringWithRange:range];
    // blue
    range.location = 4;
    NSString *blueString = [hex substringWithRange:range];
    
    unsigned int red,green,blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];// 查找是否存在十六进制，存在并复制给第二个参数
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:1.0];
}
@end
