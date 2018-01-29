//
//  UIView+YP.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/20.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "UIView+YP.h"

@implementation UIView (YP)

- (void)setYp_x:(CGFloat)yp_x{
    CGRect frame = self.frame;
    frame.origin.x = yp_x;
    self.frame = frame;
}
- (CGFloat)yp_x{
    return self.frame.origin.x;
}

- (void)setYp_y:(CGFloat)yp_y{
    CGRect frame = self.frame;
    frame.origin.y = yp_y;
    self.frame = frame;
}
- (CGFloat)yp_y{
    return self.frame.origin.y;
}

- (void)setYp_width:(CGFloat)yp_width{
    CGRect frame = self.frame;
    frame.size.width = yp_width;
    self.frame = frame;
}
- (CGFloat)yp_width{
    return self.frame.size.width;
}

- (void)setYp_height:(CGFloat)yp_height{
    CGRect frame = self.frame;
    frame.size.height = yp_height;
    self.frame = frame;
}
- (CGFloat)yp_height{
    return self.yp_height;
}

- (CGFloat)yp_max_x{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)yp_max_y{
    return CGRectGetMaxY(self.frame);
}

@end
