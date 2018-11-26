//
//  HKPromptViewBottomBar.m
//  BMLib
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "HKPromptViewBottomBar.h"
#import <YLT_Kit/YLT_Kit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface HKPromptViewBottomBar()

@end

@implementation HKPromptViewBottomBar

#pragma mark - 公开方法

///设置View
- (void)setupUI{
    
    //按钮栏上面的水平线
    UIView *separatorLine = [[UIView alloc]init];
    separatorLine.backgroundColor = YLT_HEXCOLOR(0xDDDDDD);
    [self addSubview:separatorLine];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    //显示两个按钮时，中间需要显示分割线
    if (self.config.promptViewButtonType == HKPromptViewButtonTypeDouble) {
        //按钮栏中间的垂直线
        UIView *separatorLine2 = [[UIView alloc]init];
        separatorLine2.backgroundColor = YLT_HEXCOLOR(0xDDDDDD);
        [self addSubview:separatorLine2];
        [separatorLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(1);
        }];
    }
    
}

- (void)configFirstButton:(NSString*)title clickBlock:(void(^)(HKPromptView*sender))clickBlock{
    
    //如果显示两个按钮时，每个按钮宽度是contentView的一半，反之全部占满
    CGFloat multipliedBy = (self.config.promptViewButtonType == HKPromptViewButtonTypeDouble) ? 0.5 : 1;
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:self.config.firstButtonTitleColor forState:(UIControlStateNormal)];
    button.titleLabel.font = self.config.buttonTitleFont;
    button.backgroundColor = self.config.firstButtonBackgroundColor;
    [button setBackgroundImage:self.config.firstButtonBackgroundImage forState:(UIControlStateNormal)];
    [button setImage:self.config.firstButtonTitleImage forState:(UIControlStateNormal)];
    
    @weakify(self)
    [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if(clickBlock){
            @strongify(self)
            clickBlock(self.promptView);
        }
    }];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.equalTo(self).multipliedBy(multipliedBy);
    }];
    
    [self sendSubviewToBack:button];
}

- (void)configSecondButton:(NSString*)title clickBlock:(void(^)(HKPromptView*sender))clickBlock{
    
    if (self.config.promptViewButtonType == HKPromptViewButtonTypeDouble) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setTitleColor:self.config.secondButtonTitleColor forState:(UIControlStateNormal)];
        button.titleLabel.font = self.config.buttonTitleFont;
        button.backgroundColor = self.config.secondButtonBackgroundColor;
        [button setBackgroundImage:self.config.secondButtonBackgroundImage forState:(UIControlStateNormal)];
        [button setImage:self.config.secondButtonTitleImage forState:(UIControlStateNormal)];
        
        @weakify(self)
        [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if(clickBlock){
                @strongify(self)
                clickBlock(self.promptView);
            }
        }];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.width.equalTo(self).multipliedBy(0.5);
        }];
        [self sendSubviewToBack:button];
    }
}

@end
