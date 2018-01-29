//
//  ViewController.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/11/15.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "ViewController.h"
#import "MethodExtension.h"
#import "NSString+YP.h"
#import "NSData+YP.h"
#import "UIColor+YP.h"
#import "YPScaleNavControllerAnimatedTransitioning.h"

#import "SingletonManger.h"




#define GET_COLOR_WITH_HEX(__HEXVALUE__,a) [UIColor colorWithRed:((float)((__HEXVALUE__ & 0xFF0000) >> 16))/255.0 green:((float)((__HEXVALUE__ & 0xFF00) >> 8))/255.0 blue:((float)(__HEXVALUE__ & 0xFF))/255.0 alpha:a]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *methodsArray;

@property (nonatomic, strong) YPScaleNavControllerAnimatedTransitioning *delegate;
@end

@implementation ViewController


- (NSMutableArray *)methodsArray{
    if(!_methodsArray){
        _methodsArray = [NSMutableArray array];
    }
    return _methodsArray;
}
// iOS7之后，view Cobtrollers默认使用全屏布局，edgesForExtendedLayout是enum属性UIRectEdge，默认值是UIRectEdgeAll，意味着view会被扩展到整个屏幕。
// 注意：viewController只有被嵌入到container view controller（navigationController）中才会起作用
//self.edgesForExtendedLayout = UIRectEdgeNone;
// 如果status bar 是不透明的，view不会被延伸到status bar，除非extendedLayoutIncludesOpaqueBars = YES，默认 NO
//self.extendedLayoutIncludesOpaqueBars = YES;
// 当在另一个视图控制器上呈现非全屏时，此视图控制器控制状态栏的外观。默认为没有。
//self.modalPresentationCapturesStatusBarAppearance = YES;
//    self.automaticallyAdjustsScrollViewInsets 已过期
- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = [YPScaleNavControllerAnimatedTransitioning new];
    
    NSLog(@"------%f",[UIScreen mainScreen].scale);
    
    self.view.backgroundColor = [UIColor yp_colorWithHex:@"ccff00"];//GET_COLOR_WITH_HEX(0xCCFF00,1.0f);
    
    MethodExtension *method01 = [[MethodExtension alloc] initWithTitle:@"二维码扫描"];
    method01.className = @"QRCodeViewController";
    [self.methodsArray addObject:method01];
    
    MethodExtension *method02 = [[MethodExtension alloc] initWithTitle:@"谓词的使用"];
    method02.className = @"PredicateViewController";
    [self.methodsArray addObject:method02];
    
    MethodExtension *method03 = [[MethodExtension alloc] initWithTitle:@"时间的计算"];
    method03.className = @"DateUsingViewController";
    [self.methodsArray addObject:method03];
    
    MethodExtension *method04 = [[MethodExtension alloc] initWithTitle:@"转场动画"];
    method04.className = @"TransionViewController";
    [self.methodsArray addObject:method04];
    
    MethodExtension *method05 = [[MethodExtension alloc] initWithTitle:@"RAC的使用"];
    method05.className = @"RACViewController";
    [self.methodsArray addObject:method05];
    
    MethodExtension *method06 = [[MethodExtension alloc] initWithTitle:@"RAC登录界面"];
    method06.className = @"RACLoginController";
    [self.methodsArray addObject:method06];
    
    // 获取view的快照，比位图截图快，通常用于动画效果的制作
//    NSLog(@"-----%@",self.view);
//    UIView *v = [self.view snapshotViewAfterScreenUpdates:YES];
//    v.backgroundColor = [UIColor redColor];
//    [self.view addSubview:v];
    // 一些字符串的处理
    [self stringUsing];
    

//    UUserDefaults.name = @"中华人民共和国";
    NSLog(@"mytitle ---- %@",UUserDefaults.name);
    UUserDefaults.name = @"smyi";
    NSLog(@"mytitle ---- %@",UUserDefaults.name);
    UUserDefaults.name = @"jjjjjj";
    
    
}
#pragma mark - 字符串的处理
- (void)stringUsing{
    UILabel *title_label = [[UILabel alloc] init];
    NSString *title = @"中华人民共  和国万岁，毛主席万岁";
    NSRange range1 = NSMakeRange(0, 2);
    NSRange range2 =NSMakeRange(3, 5);
    NSValue *value1 = [NSValue valueWithRange:range1];
    NSValue *value2 = [NSValue valueWithRange:range2];
    NSAttributedString *attr = [title attributesWithArray:@[@{NSFontAttributeName:[UIFont systemFontOfSize:19 weight:1]},@{NSForegroundColorAttributeName:[UIColor redColor]}] ranges:@[value1,value2]];
    title_label.attributedText = attr;
    self.navigationItem.titleView = title_label;
    ////////////////////////////////////////////////////////////////////////
    NSLog(@"MD5 ------ %@",[title MD5]);
    ////////////////////////////////////////////////////////////////////////
    NSLog(@"string --- %@",[title yp_removeSpecicalCharacter:@" "]);
    ////////////////////////////////////////////////////////////////////////
    NSString *h = nil;
    NSLog(@"---%d",[NSString isNull:h]);
    ////////////////////////////////////////////////////////////////////////
    NSData *base64_data = [title yp_base64Encoding];
    NSLog(@"titleBase64 --- %@",base64_data);
    NSLog(@"title --- %@",[base64_data yp_base64Decoding]);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.methodsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MethodExtension *method = self.methodsArray[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = method.title;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MethodExtension *method = self.methodsArray[indexPath.row];
    Class class = NSClassFromString(method.className);
    if(class){
        UIViewController *crlv = class.new;
        crlv.title = method.title;
        self.navigationController.delegate = self.delegate;
        [self.navigationController pushViewController:crlv animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s --- 收到了内存警告",__FILE__);
}













@end
