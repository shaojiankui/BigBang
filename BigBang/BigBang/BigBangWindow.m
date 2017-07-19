//
//  BigBangWindow.m
//  BigBang
//
//  Created by Jakey on 2017/7/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "BigBangWindow.h"

@implementation BigBangWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self buildWindow];
    }
    return self;
}
- (void)buildWindow
{
    self.windowLevel = UIWindowLevelStatusBar;
    self.hidden = NO;
    self.autoresizesSubviews = YES;
//    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.800];
    self.frame = [UIScreen mainScreen].bounds;
}

@end
