//
//  HKPromptBaseContentView.m
//  BMLib
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "HKPromptBaseContentView.h"
#import <YLT_Kit/YLT_Kit.h>

@interface HKPromptBaseContentView()

@end

@implementation HKPromptBaseContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/** 标题 **/
- (void)setTitle:(id)title {}
- (void)setTitleImage:(UIImage*)titleImage {}

#pragma mark - HKPromptContentHeightProtocol

- (CGFloat)getContentViewHeight{
    return 0;
}

#pragma mark - 公开方法

- (void)setupUI {}

- (void)setContent:(id)content {}

@end
