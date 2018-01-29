//
//  NSString+YP.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/19.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "NSString+YP.h"
#import "NSData+YP.h"


@implementation NSString (YP)
- (NSMutableAttributedString *)attributesWithArray:(NSArray<NSDictionary *> *)attributesArr ranges:(NSArray *)ranges{
    // 两个数组的元素一一对应
//    if(attributesArr.count != ranges.count) return nil;
    //断言
    NSAssert(attributesArr.count == ranges.count, @"属性和range一一对应");
    
    NSInteger count = attributesArr.count;
    NSMutableAttributedString *attributesString = [[NSMutableAttributedString alloc] initWithString:self];
    for(int i=0;i<count;i++){
        NSDictionary *dic = attributesArr[i];
        NSValue *value = ranges[i];
        [attributesString addAttributes:dic range:[value rangeValue]];
    }
    
    return attributesString;
}
- (NSString *)MD5{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}
- (BOOL)isNull{
    if(self && [self isEqualToString:@""]) return YES;
    if(self && [self isEqualToString:@"<null>"]) return YES;
    if(self && [self isEqual:[NSNull null]]) return YES;
    if(self && [self isEqual:[NSNull class]]) return YES;
    return NO;
}
+ (BOOL)isNull:(id)object{
    if(!object) return YES;
    if(object && [object isEqualToString:@""]) return YES;
    if(object && [object isEqualToString:@"<null>"]) return YES;
    if(object && [object isEqual:[NSNull null]]) return YES;
    if(object && [object isEqual:[NSNull class]]) return YES;
    return NO;
}
- (NSString *)yp_removeSpecicalCharacter:(NSString *)character{
   return [self stringByReplacingOccurrencesOfString:character withString:@""];
}
- (NSString *)yp_removeSpacing{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
- (NSData *)yp_base64Encoding{
    NSData *data = [self yp_UTF8String];
    NSData *base64_data = [data base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return base64_data;
}
- (NSData *)yp_UTF8String{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
@end
