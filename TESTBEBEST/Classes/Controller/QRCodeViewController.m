//
//  QRCodeViewController.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/11/15.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()
{
    UIMenuController *menu;
}
@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *l = [[UILabel alloc] init];
    [self.view addSubview:l];
    [l becomeFirstResponder];
    
        menu = [UIMenuController sharedMenuController];
        UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"好好" action:@selector(pppp)];
        UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"好好" action:@selector(yyyy)];
    
        [menu setMenuItems:@[item1,item2]];
        [menu setTargetRect:CGRectMake(60, 60, 200, 200) inView:self.view];
        [menu setMenuVisible:YES animated:YES];
    
}
- (void)pppp{
    
}
- (void)yyyy{
    
}
@end
