//
//  UIView+YP.h
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/20.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YP)
@property (nonatomic, assign) CGFloat yp_x;
@property (nonatomic, assign) CGFloat yp_y;
@property (nonatomic, assign) CGFloat yp_height;
@property (nonatomic, assign) CGFloat yp_width;
@property (nonatomic, assign, readonly) CGFloat yp_max_x;
@property (nonatomic, assign, readonly) CGFloat yp_max_y;
@end
