//
//  HKPromptViewBottomBar.h
//  BMLib
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKPromptViewConfig.h"
#import "HKPromptViewProtocol.h"

@class HKPromptView;

@interface HKPromptViewBottomBar : UIView<HKPromptBottomBarProtocol>

/** 弹框类，弱引用 **/
@property (nonatomic, weak) HKPromptView *promptView;

/** 配置 **/
@property (nonatomic, strong) HKPromptViewConfig *config;

///设置View
- (void)setupUI;

@end
