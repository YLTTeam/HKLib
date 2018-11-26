//
//  HKLibTools.m
//  AFNetworking
//
//  Created by 项普华 on 2018/11/26.
//

#import "HKLibTools.h"
#import "HKPromptView.h"

@implementation HKLibTools

/**
 显示跳转设置提示
 
 @param title 标题
 */
+ (void)hk_showSettingTitle:(NSString *)title {
    [HKPromptView showAlertTitle:@"提示" message:title cancelTitle:@"好的" otherTitle:@"设置" cancelBlock:^(HKPromptView *sender) {
    } otherBlock:^(HKPromptView *sender) {
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
}

@end
