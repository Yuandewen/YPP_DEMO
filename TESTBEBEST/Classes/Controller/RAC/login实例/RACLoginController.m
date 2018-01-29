//
//  RACLoginController.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/26.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "RACLoginController.h"
#import <ReactiveObjC.h>
#import "TanLoginViewModel.h"

@interface RACLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mumView;
@property (nonatomic, strong) TanLoginViewModel *viewModel;

@end

@implementation RACLoginController

// RACCommand 传递的是信号，在一个控制器中创建一个网络请求的信号，在另一个控制器中，通过command获取到这个信号然后订阅获取网络数据，真正实现了双工的工作模式，信息互相传递
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mumView.hidden = YES;
    _viewModel = [[TanLoginViewModel alloc] init];
    
    @weakify(self);
    RAC(self.viewModel, userName) = self.userNameTF.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTF.rac_textSignal;
    self.loginBtn.rac_command = self.viewModel.loginCommand;
    [[self.viewModel.loginCommand executionSignals] subscribeNext:^(RACSignal *x) {
        @strongify(self);
        self.mumView.hidden = NO;
        [x subscribeNext:^(id  _Nullable x) {
            self.mumView.hidden = YES;
        }];
    }];
}

@end
