//
//  BigBangViewController.m
//  BigBang
//
//  Created by Jakey on 2017/7/19.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "BigBangViewController.h"

@interface BigBangViewController ()
@property(nonatomic ,strong) UIView *fingerprintView;


@end

@implementation BigBangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buildUI{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                 target:self action:@selector(cancleTouched:)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                  target:self action:@selector(rightTouched:)];
    UIBarButtonItem *spaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    
    UIBarButtonItem *tilteButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ssdss" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem *spaceRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    NSArray  *buttons=[NSArray arrayWithObjects:leftItem, spaceLeft, tilteButtonItem,spaceRight,rightItem, nil];
    
    
    //为子视图构造工具栏
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.backgroundColor = [UIColor colorWithRed:196/255.0 green:204/255.0 blue:215/255.0 alpha:1];
    toolbar.opaque = NO;
    [toolbar setItems:buttons animated:YES];
    
    [self.view addSubview:toolbar];

}
-(void)bigBangWithPoint:(CGPoint)touchedPoint{
    self.fingerprintView.frame = CGRectZero;
    self.fingerprintView.center = touchedPoint;
    [self.view addSubview:self.fingerprintView];
    
   [UIView animateWithDuration:0.3 animations:^{
       CGRect rect = self.fingerprintView.frame;
       rect.size = CGSizeMake(55, 55);
       self.fingerprintView.frame = rect;
      
   } completion:^(BOOL finished) {
       [self.fingerprintView removeFromSuperview];
       self.view.backgroundColor = [UIColor colorWithRed:184/255.0 green:192/255.0 blue:203/255.0 alpha:1];

   }];

    
}
-(UIView *)fingerprintView{
    if (!_fingerprintView) {
        _fingerprintView = [[UIView alloc] init];
        _fingerprintView.backgroundColor = [UIColor redColor];
    }
    return _fingerprintView;
}
-(void)cancleTouched:(UIButton*)leftButton{
    self.view.window.hidden = YES;
}
-(void)rightTouched:(UIButton*)rightButton{
    
}
@end
