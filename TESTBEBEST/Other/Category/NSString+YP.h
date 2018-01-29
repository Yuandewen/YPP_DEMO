//
//  NSString+YP.h
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/19.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YP)
//- (NSMutableAttributedString *)attributesWithArray:(NSArray<NSDictionary *> *)attributesArr ranges:(NSArray *)ranges;
- (NSAttributedString *)attributesWithArray:(NSArray <NSDictionary *> *)attributeArr ranges:(NSArray *)ranges;

- (NSString *)MD5;
- (BOOL)isNull;// 判断字符串是否为空
+ (BOOL)isNull:(id)object;
- (NSString *)yp_removeSpecicalCharacter:(NSString *)character; // 移除特殊字符
- (NSString *)yp_removeSpacing;// 移除空格
- (NSData *)yp_base64Encoding;// base64编码
- (NSData *)yp_UTF8String;
//- (const char *)UTF8String

@end
