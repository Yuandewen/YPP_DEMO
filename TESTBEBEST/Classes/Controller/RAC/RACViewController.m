//
//  RACViewController.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/11.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveObjC.h>
#import "DelegateView.h"

@interface RACViewController ()
@property (weak, nonatomic) IBOutlet UITextField *yp_textFiled;

@property (nonatomic, strong) RACDisposable *disposable;

@end

@implementation RACViewController


// 热信号 冷信号
- (void)viewDidLoad {
    [super viewDidLoad];
     
    [self fliter];
   
}
// skip
- (void)skip{
    // 传入n，跳过前面2个值
    RACSubject *subject = [RACSubject subject];
    // 可以屏蔽一些值，去前面几个值，take为2，忽略前面2个值
    [[subject skip:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"---%@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
}
// distinctUntilChanged
- (void)distinctUntilChanged{
    RACSubject *subject = [RACSubject subject];
    // 相同的值没必要被多次订阅
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"---%@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@2];
}
// take 参数为x，执行前面x个值
- (void)take{
    RACSubject *subject = [RACSubject subject];
    [[subject take:3] subscribeNext:^(id  _Nullable x) {
        NSLog(@"---%@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
}
- (void)ignore{
    RACSubject *subject = [RACSubject subject];
    RACSignal *ignoreSignal = [subject ignore:@1];
    [ignoreSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"---%@",x);
    }];
    [subject sendNext:@2];
}
- (void)fliter{
//    [[self.yp_textFiled.rac_textSignal filter:^BOOL(id value) {
//        return [value length] > 6; // 返回值就是过滤条件，满足就可以获取
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"1---%@",x);
//    }] ;
//
//    [[self.yp_textFiled.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//        return value.length < 6;
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"2---%@",x);
//    }] ;
    [[[self.yp_textFiled.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        NSLog(@"string --- %@",value);
        return @(value.length);
    }] filter:^BOOL(id  _Nullable value) {
        return [value integerValue] > 3;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"x ---- %@",x);
    }] ;
}
// 把两个信号压缩成一个信号，只有当两个信号都发出信号内容后，并且把两个信号合并成一个元祖，才会触发压缩流的next事件  相当于串联
- (void)zipWith{
    // 使用场景，当一个界面多个请求的时候，要等所有请求完成后才更新UI
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSignal *zipSignal = [signalA zipWith:signalB];// 先A后B,决定压缩顺序
    [zipSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"---%@---%@",x,x[0]);
    }];
    
    [signalA sendNext:@1];
    [signalB sendNext:@2];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{

//    });
}
// 多个信号合并成一个信号，任何一个信号有新值都会调用，任何一个信号请求完成都会被订阅  相当于并联
- (void)merge{
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    // 组合信号
    RACSignal *mergeSignal = [signalA merge:signalB];
    
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"---%@",x);
    }];
    [signalA sendNext:@1];
    [signalB sendNext:@"b"];
}
// 使用需求：有两部分数据，想让上部分先进行网络请求但是过滤掉数据，然后进行下部分的，拿到下部分数据
- (void)then{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"---发送上部分请求---");
        [subscriber sendNext:@"上部分数据0"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"---发送下部分数据---");
        [subscriber sendNext:@"下部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];
//    [signalA subscribeNext:^(id  _Nullable x) {
//        NSLog(@"dd --- %@",x);
//    }];
    RACSignal *thenSignal = [signalA then:^RACSignal *{
        return signalB;
    }];

    [thenSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x---%@",x);
    }];
}
// 使用需求：有两部分数据，想让上部分先执行，结束之后再让下部分执行（）都可获取值
- (void)concat{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"---发送上部分请求---");
        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"---发送下部分请求---");
        [subscriber sendNext:@"下部分请求"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *concatSignal = [signalA concat:signalB];
    [concatSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"----%@",x);
    }];
}
- (void)arrayFor{
    // 遍历数组
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"数组的内容 -- %@",x);
    }];
}
- (void)dictionaryFor{
    // 遍历字典
    NSDictionary *dic = @{@"key1":@"value1",@"key2":@"value2"};
    [dic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"--%@",x);
        RACTupleUnpack(NSString *key, NSString *value) = x;// x是一个元祖，这个宏能够将key 和 value 拆开
        NSLog(@"字典的内容:key -- %@,value -- %@",key,value);
    }];
}
// 生成新的数组，内容为指定的内容
- (void)arrayWith0{
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
    
    // 方法一
    NSArray *newArray = [[array.rac_sequence map:^id _Nullable(id  _Nullable value) {
        NSLog(@"value -- %@",value);
        return @"0";
    }] array] ;
    NSLog(@"newArray --- %@",newArray);
    
    // 方法二
    NSArray *newArray1 = [[array.rac_sequence mapReplace:@"9"] array];
    NSLog(@"newArray1 --- %@",newArray1);
}
// 监听button事件
- (void)monitoringWithButton{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"----%@",x);
    }];
}
- (void)monitorLoginBtn{
    UIButton *login_btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
//    [[login_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"能用了...");
//    }];
    [login_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [login_btn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:login_btn];
    UITextField *user_name_field = [[UITextField alloc] initWithFrame:CGRectMake(100, 140, 100, 30)];
    user_name_field.placeholder = @"用户名";
    [self.view addSubview:user_name_field];
    UITextField *password_field = [[UITextField alloc] initWithFrame:CGRectMake(100, 180, 100, 30)];
    password_field.placeholder = @"密码";
    [self.view addSubview:password_field];
    RAC(login_btn,enabled) = [RACSignal combineLatest:@[user_name_field.rac_textSignal,password_field.rac_textSignal] reduce:^id _Nullable{
        if(password_field.text.length && user_name_field.text.length){
            login_btn.backgroundColor = [UIColor blueColor];
        }else{
            login_btn.backgroundColor = [UIColor lightGrayColor];
        }
        
          return @(password_field.text.length && user_name_field.text.length);
    }];
    
}
- (void)btnAction{
    NSLog(@"点击按钮了...");
}
- (void)dealloc{
    NSLog(@"来到这说明销毁了......");
}

//////////////////////////////////////////////////////////////////////
#pragma mark - 监听Notification通知事件
// 可省去在dealloc方法中清除通知和监听通知创建方法的步骤
- (void)rac_notification{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"-----%@",x);
    }];
}
// 可以代替delegate
- (void)rac_delegate{
    DelegateView *d_v = [[DelegateView alloc] initWithFrame:CGRectMake(100, 100, 200, 150)];
    [self.view addSubview:d_v];
    SEL d_v_selector = NSSelectorFromString(@"DelegateViewBtnClick");
    [[d_v rac_signalForSelector:d_v_selector] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"delegate view中的按钮被击中了--- %@",x);
    }];
}
// 代替KVO监听
- (void)rac_kvo{
//    [[self.view rac_valuesForKeyPath:@"backgroundColor" observer:self] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"backgroundColor----%@",x);
//    }];
    
    // 简写
    [RACObserve(self.view, backgroundColor) subscribeNext:^(id  _Nullable x) {
        NSLog(@"backgroundColor----%@",x);
    }];
}
// 代替NSTimer计时器
- (void)rac_disposable{
    self.disposable = [[RACSignal interval:10.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"----%@",x);
        //  关闭定时器
        [_disposable dispose];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.view.backgroundColor = [UIColor blueColor];
    RACSignal *signal = [@"a b c d d f g" componentsSeparatedByString:@" "].rac_sequence.signal;
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"--%@",x);
    }];
}
@end
