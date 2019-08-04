//
//  ViewController.m
//  CustomLayoutBestDemo
//
//  Created by DCH on 2019/8/4.
//  Copyright © 2019 DCH. All rights reserved.
//

#import "ViewController.h"
#import "CustomLayoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(200, 200, 60, 30);
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(showViewC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)showViewC
{
    CustomLayoutViewController *vc = [CustomLayoutViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
