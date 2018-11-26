//
//  HKPromptStyleTwoContentView.m
//  BMLib
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "HKPromptStyleTwoContentView.h"
#import <YLT_Kit/YLT_Kit.h>
#import "HKPromptViewDefines.h"

@interface HKPromptStyleTwoContentView()

/** 图片标题 **/
@property (nonatomic, strong) UIImageView *imageIV;

/** 图片高度 **/
@property (nonatomic, assign) CGFloat imageHeight;

@end

@implementation HKPromptStyleTwoContentView

#pragma mark - 公开方法

- (void)setupUI{
    
    self.attrStringSize = CGSizeZero;
    self.imageHeight = self.config.imageTitleMaxHeight;
    
    //图片标题
    [self addSubview:self.imageIV];
    [self.imageIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.config.imageTitleMarginTop);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(self.config.imageTitleMaxHeight);
    }];

    //内容
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.imageIV.mas_bottom).mas_offset(self.config.contentLabelMarginTop);
    }];
}

#pragma mark - setter

- (void)setTitle:(id)title{
    if (![title isKindOfClass:[UIImage class]]) { return; }
    
    UIImage *image = title;
    self.imageIV.image = image;
    
    CGFloat imageHeight = MIN(image.size.height,self.config.imageTitleMaxHeight);
    CGFloat imageWidth = MIN(image.size.width,HKPromptViewClientWidth);
    [self.imageIV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(imageHeight);
        make.width.mas_equalTo(imageWidth);
    }];
    
    self.imageHeight = imageHeight;
}

- (void)setTitleImage:(UIImage*)titleImage {
    [self setTitle:titleImage];
}

#pragma mark - 懒加载

///图片标题
- (UIImageView *)imageIV{
    if (!_imageIV) {
        _imageIV = [[UIImageView alloc]init];
        _imageIV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageIV;
}

#pragma mark - 协议

- (CGFloat)getContentViewHeight{
    return self.config.imageTitleMarginTop
        + self.imageHeight
        + self.config.contentLabelMarginTop
        + self.attrStringSize.height
        + self.config.contentLabelMarginBottom;
}

@end
