//
//  PredicateViewController.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/11/30.
//  Copyright © 2017年 dcz. All rights reserved.
/**
 *  Description: 谓词的使用
**/
#import "PredicateViewController.h"
typedef NSPredicate PRE;
@interface PredicateViewController ()

@end

@implementation PredicateViewController
+ (void)load{
    NSLog(@"777777----");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 语法：1，self（SELF）
    //      2,前面加 NOT  等效于  !=
    
    // 1.在数组中查询数字
    NSArray *numberArray = @[@100,@200,@300,@400];
    NSPredicate *numP = [NSPredicate predicateWithFormat:@" SELF != 200"];
    NSArray *resultNumArr = [numberArray filteredArrayUsingPredicate:numP];
    Log(resultNumArr);
    
    // between 等效于 >= && <=  是一个包括两头在内的区间
    // 与 AND,&&
    // 或 OR,||
    // 非 NOT,!
//    NSPredicate *numP2 = [NSPredicate predicateWithFormat:@"self > 50 && self < 250"];
    NSPredicate *numP3 = [NSPredicate predicateWithFormat:@"self between {50,250}"];
    NSArray *resultB = [numberArray filteredArrayUsingPredicate:numP3];
    Log(resultB);
    
    // 2.字符串
    NSString *numberString = @"100";
    NSPredicate *stringP = [NSPredicate predicateWithFormat:@"self == '100'"];
    BOOL isHas = [stringP evaluateWithObject:numberString];
    Log(@(isHas));
    
    // 字符串筛选的语法
    /* 1,字符串是否以什么开头  BETWEEN
       2,字符串包含          CONATINS
       3,字符串以什么结尾     ENDSWITH
       4,谓词的模糊查询       LIKE
       5,正则表达式的筛选     MATCHES
       6,判断两个是否相等     UIT-EQUALS
     */
    NSArray *stringArray = @[@"henan",@"jiaozuo",@"xinxiang"];
    NSPredicate *stringP1 = [NSPredicate predicateWithFormat:@"self BEGINSWITH 'h' || self BEGINSWITH 'j' && self ENDSWITH 'o'"];
    NSArray *resultC = [stringArray filteredArrayUsingPredicate:stringP1];
    log1(resultC);
    NSPredicate *stringP2 = [NSPredicate predicateWithFormat:@"self contains 'an'"];
    NSArray *resultD = [stringArray filteredArrayUsingPredicate:stringP2];
    log1(resultD);
    NSPredicate *stringP3 = [NSPredicate predicateWithFormat:@"self like '*e*'"];// *n 以n结尾／ h* 以h开头／ *n* 中间包含n
    NSArray *resultE = [stringArray filteredArrayUsingPredicate:stringP3];
    log1(resultE);
    NSString *phoneString = @"18737196629";
    NSPredicate *stringP4 = [NSPredicate predicateWithFormat:@"self MATCHES %@",@"^1[3|4|5|7|8][0-9]\\d{8}$"];
    BOOL isPhone = [stringP4 evaluateWithObject:phoneString];
    log1(@(isPhone));
    
    NSPredicate *stringP5 = [NSPredicate predicateWithFormat:@"self UTI-EQUALS '18737196629'"];
    BOOL isEqual = [stringP5 evaluateWithObject:phoneString];
    log1(@(isEqual));
    
    //谓词集合语法
    /*  1,一些、任意  ANY  SOME
        2,所有       ALL
        3,逻辑非     NONE
        4,交集       IN
     */
    NSArray *setArray = @[
                          @[@10,@20],
                          @[@10,@50,@100],
                          @[@10,@60],
                          @[@90]
                          ];
    NSPredicate *setP = [NSPredicate predicateWithFormat:@"some self == 90"];
    NSArray *resultF = [setArray filteredArrayUsingPredicate:setP];
    log3(resultF);
    
    NSPredicate *setP1 = [NSPredicate predicateWithFormat:@" NONE self == 50"];
    NSArray *resultG = [setArray filteredArrayUsingPredicate:setP1];
    log3(resultG);
    
    NSPredicate *setP2 = [NSPredicate predicateWithFormat:@"ALL self IN %@",@[@10,@60]];
    NSArray *resultH = [setArray filteredArrayUsingPredicate:setP2];
    log3(resultH);
    
    
    NSArray * cityNameArray = @[@[@"henan",@"beijing"],@[@"xian"],@[@"qinghai",@"xuchang",@"luhe"],@[@"kaifeng"]];
    NSArray * cityNameArray2 = @[@[@"henan",@"hebei"],@[@"xiangtai"],@[@"qinghaihu",@"xuchangshi",@"luhe"],@[@"henan",@"hebei"]];
    // 模糊匹配
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"ANY SELF CONTAINS 'an'"];
    NSArray *result_A = [cityNameArray filteredArrayUsingPredicate:pre];
    log5(result_A);
    // 精确匹配
    NSPredicate *pre1 = [NSPredicate predicateWithFormat:@"ANY SELF IN 'henan'"];
    NSArray *result_B = [cityNameArray filteredArrayUsingPredicate:pre1];
    log5(result_B);
    // 多个匹配
    NSPredicate *pre2 = [NSPredicate predicateWithFormat:@"ANY SELF IN %@",@[@"henan",@"xian"]];
    NSArray *result_C = [cityNameArray filteredArrayUsingPredicate:pre2];
    log5(result_C);
    // 不包含某个字段匹配
    NSPredicate *pre3 = [NSPredicate predicateWithFormat:@"NONE SELF CONTAINS 'henan'"];
    NSArray *result_D = [cityNameArray filteredArrayUsingPredicate:pre3];
    log5(result_D);
    
    // 断言（嵌套数组是精确匹配）数组中是否包含"henan" c不区分大小写 d不区分重音符号
    NSPredicate *pre4 = [NSPredicate predicateWithFormat:@"ANY %@ CONTAINS[cd] %@",cityNameArray2,@"henan"];
    BOOL isP = [pre4 evaluateWithObject:cityNameArray2];
    log5(@(isP));
    
    // 评估 (单个数组的评估)
    NSPredicate *pre5 = [NSPredicate predicateWithFormat:@"ANY %@ CONTAINS[cd] %@",cityNameArray2[0],@"henan"];
    BOOL isP1 = [pre5 evaluateWithObject:cityNameArray2];
    log5(@(isP1));
    
//    // 方法二
//    NSPredicate *pre6 = [NSPredicate predicateWithFormat:@"ALL SELF IN %@" argumentArray:@[cityNameArray2.firstObject]];
//    NSArray *result_I = [cityNameArray2 filteredArrayUsingPredicate:pre6];
//    log5(result_I);
//    // 方法三
//    [self predicateWithFormatArray:cityNameArray2 andArgList:@"h",@"n"];
//
//    NSPredicate *pre7 = [NSPredicate predicateWithBlock:^BOOL(NSArray * evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [evaluatedObject.firstObject isEqualToString:@"henan"];
//    }];
//    NSArray *result_J = [cityNameArray2 filteredArrayUsingPredicate:pre7];
//    log5(result_J);
}
-(void)predicateWithFormatArray:(NSArray*)array  andArgList:(NSString*)args, ...{
    va_list MList ;
    va_start(MList, args);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY SELF CONTAINS %@" arguments:MList];
    va_end(MList);
    log5([array filteredArrayUsingPredicate:predicate]);
}
void log5(id obj){
    NSLog(@"obj -- %@",obj);
}
void log3(id obj){
//    NSLog(@"obj -- %@",obj);
}

void log1(id obj){
//    NSLog(@"obj -- %@",obj);
}
void Log(id obj){
//    NSLog(@"obj -- %@",obj);
}

@end
