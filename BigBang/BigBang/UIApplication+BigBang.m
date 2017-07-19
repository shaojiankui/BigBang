//
//  UIApplication+BigBang.m
//  BigBang
//
//  Created by Jakey on 2017/7/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "UIApplication+BigBang.h"
#import <objc/runtime.h>
#import "BigBangWindow.h"
#import "BigBangViewController.h"
static const void *k_bb_enableBigBang = &k_bb_enableBigBang;
static const void *k_bb_window = &k_bb_window;


@implementation UIApplication (BigBang)
@dynamic enableBigBang;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(sendEvent:);
        SEL swizzledSelector = @selector(_bb_sendEvent:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,originalSelector,method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
-(void)setEnableBigBang:(BOOL)enableBigBang{
    objc_setAssociatedObject(self, k_bb_enableBigBang, @(enableBigBang), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)enableBigBang{
    return [objc_getAssociatedObject(self, k_bb_enableBigBang) boolValue];
}

-(void)setBb_window:(UIWindow *)bb_window{
    objc_setAssociatedObject(self, k_bb_window, bb_window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIWindow *)bb_window{
    return objc_getAssociatedObject(self, k_bb_window);
}
#pragma mark - Method Swizzling
- (void)_bb_sendEvent:(UIEvent*)event {
 
        
        
    if (self.enableBigBang && event.type==UIEventTypeTouches) {
        UITouch *touch = [event.allTouches anyObject];
        CGPoint touchPoint = [touch locationInView:[UIApplication sharedApplication].keyWindow];

        CGFloat touchSize = [[touch valueForKey:@"pathMajorRadius"] floatValue];
        NSLog(@"pathMajorRadius size is %.2f,majorRadius is %.2f", touchSize,touch.majorRadius);
       
        if ([[event.allTouches anyObject] phase]==UITouchPhaseBegan) {
            //我炸
            if (!self.bb_window) {
                self.bb_window = [[BigBangWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
                self.bb_window.rootViewController = [[BigBangViewController alloc] init];
                self.bb_window.hidden = YES;
            }
            if (self.bb_window.hidden) {
                self.bb_window.hidden = NO;
                [((BigBangViewController*) self.bb_window.rootViewController) bigBangWithPoint:touchPoint];
            }
        }
        if ([[event.allTouches anyObject] phase]==UITouchPhaseCancelled) {
//            self.bb_window.hidden = YES;
        }
      
    }
    [self _bb_sendEvent:event];
}
@end
