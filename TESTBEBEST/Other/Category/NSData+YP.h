//
//  NSData+YP.h
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/22.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YP)
- (NSString *)md5String;

// base64解码
- (NSString *)yp_base64Decoding;
@end
