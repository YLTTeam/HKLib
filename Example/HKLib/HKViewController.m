//
//  HKViewController.m
//  HKLib
//
//  Created by xphaijj0305@126.com on 11/26/2018.
//  Copyright (c) 2018 xphaijj0305@126.com. All rights reserved.
//

#import "HKViewController.h"
#import <HKLib/HKLib.h>

@interface HKViewController ()

@end

@implementation HKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"---------- ");
    HK_TipAlert(@"%@", @"警告框");
//    [HKPromptView showAlertTitle:@"警告框" message:nil cancelTitle:@"确定" cancelBlock:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
