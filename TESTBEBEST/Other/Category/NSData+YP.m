//
//  NSData+YP.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/22.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "NSData+YP.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSData (YP)
- (NSString *)md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    // x 整数转换成小写十六进制位  X 整数转换为大写十六进制位
    return [NSString stringWithFormat:
        @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
        result[0], result[1], result[2], result[3],
        result[4], result[5], result[6], result[7],
        result[8], result[9], result[10], result[11],
        result[12], result[13], result[14], result[15]
        ];
}

- (NSString *)yp_base64Decoding{
    NSData *dd = [[NSData alloc] initWithBase64EncodedData:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:dd encoding:NSUTF8StringEncoding];
}
@end
