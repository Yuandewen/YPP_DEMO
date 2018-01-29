//
//  DelegateView.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/24.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "DelegateView.h"

@implementation DelegateView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = YES;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        btn.backgroundColor = [UIColor blueColor];
        [btn addTarget:self action:@selector(DelegateViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    return self;
}
- (void)DelegateViewBtnClick{
    NSLog(@"-----delegate");
}
@end
