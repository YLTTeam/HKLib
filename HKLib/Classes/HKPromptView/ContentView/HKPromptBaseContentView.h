//
//  HKPromptBaseContentView.h
//  BMLib
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKPromptViewConfig.h"
#import "HKPromptVIewProtocol.h"
#import "HKPromptViewDefines.h"

@class HKPromptView;

@interface HKPromptBaseContentView : UIView<HKPromptContentHeightProtocol,HKPromptBottomRictTextProtocol>

/** 弹框类，弱引用 **/
@property (nonatomic, weak) HKPromptView *promptView;

/** 配置 **/
@property (nonatomic, strong) HKPromptViewConfig *config;

/** 标题 **/
- (void)setTitle:(id)title;
- (void)setTitleImage:(UIImage*)titleImage;
/** 内容 **/
- (void)setContent:(id)content;

///设置View
- (void)setupUI;

@end
