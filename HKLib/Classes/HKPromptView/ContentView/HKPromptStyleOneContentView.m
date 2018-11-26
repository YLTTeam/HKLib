//
//  HKPromptStyleOneContentView.m
//  BMLib
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "HKPromptStyleOneContentView.h"
#import <YLT_Kit/YLT_Kit.h>

@interface HKPromptStyleOneContentView()

/** 标题Label **/
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HKPromptStyleOneContentView

#pragma mark - 公开方法

- (void)setupUI{
    
    self.attrStringSize = CGSizeZero;
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.config.textTitleMarginTop);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(self.config.contentLabelMarginTop);
    }];
}

#pragma mark - setter

- (void)setTitle:(id)title{
    if (![title isKindOfClass:[NSString class]]) { return; }
    self.titleLabel.text = title;
}

#pragma mark - 懒加载

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = self.config.textTitleColor;
        _titleLabel.font = self.config.textTitleFont;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 协议

- (CGFloat)getContentViewHeight{
    return self.config.textTitleMarginTop
        + self.config.textTitleFont.lineHeight
        + self.config.contentLabelMarginTop
        + self.attrStringSize.height
        + self.config.contentLabelMarginBottom;
}

@end
