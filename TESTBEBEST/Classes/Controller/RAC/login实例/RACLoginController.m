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
