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
//    [[[UIAlertView alloc] initWithTitle:@"title" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//    HK_TipAlert(@"%@", @"警告框");
//    [HKPromptView showAlertTitle:@"警告框" message:nil cancelTitle:@"确定" cancelBlock:nil];
}

- (IBAction)go2Setting:(id)sender {
    [HKLibTools hk_showSettingTitle:@"设置title"];
}

- (IBAction)showRoundPromptView:(id)sender {
    HKPromptView *promptView = [HKPromptView promptView:^(HKPromptViewConfig *config) {
        config.promptViewType = HKPromptViewType1;//图片标题 + 富文本内容
        config.contentAlignment = NSTextAlignmentCenter;
        config.contentCornerRadius = 16; //内容区域圆角
    }];
    [promptView configFirstButton:@"取消" clickBlock:^(HKPromptView *sender) {
        [sender hideAnimation:^{
        }];
    }];
    [promptView configSecondButton:@"确定" clickBlock:^(HKPromptView *sender) {
        [sender hideAnimation:^{
        }];
    }];
    [promptView setTitle:@"提示"];
    [promptView setContent:@"提示内容"];
    [promptView showOnAlertWindow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
