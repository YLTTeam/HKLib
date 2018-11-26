//
//  HKPromptViewConfig.h
//  BMLib
//
//  Created by 永平 on 2018/9/26.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    ///单个按钮
    HKPromptViewButtonTypeSingle,
    ///两个按钮
    HKPromptViewButtonTypeDouble
} HKPromptViewButtonType;

typedef enum : NSUInteger {
    ///文字标题 + 富文本内容
    HKPromptViewType1,
    ///图片标题 + 富文本内容
    HKPromptViewType2,
    ///自定义
    HKPromptViewTypeCustomize
} HKPromptViewType;


@interface HKPromptViewConfig : NSObject

#pragma mark - 全局

/** 显示隐藏时是否需要动画，默认YES **/
@property (nonatomic, assign) BOOL animationWhenShowAndHide;

/** 背景色，默认YLT_HEXCOLORA(0x000000, 0.5); **/
@property (nonatomic, strong) UIColor *backgroundColor;
/** 内容背景色，默认白色 **/
@property (nonatomic, strong) UIColor *contentBackgroundColor;

#pragma mark - 标题相关

/** 标题字体，默认 [UIFont ylt_regularFont:15]**/
@property (nonatomic, strong) UIFont *textTitleFont;
/** 标题颜色，默认 YLT_HEXCOLOR(0x000000) **/
@property (nonatomic, strong) UIColor *textTitleColor;

#pragma mark - 内容相关

/** 样式，默认 HKPromptViewTypeTitleAndContent**/
@property (nonatomic, assign) HKPromptViewType promptViewType;

/** 内容字体，默认 [UIFont ylt_regularFont:14] **/
@property (nonatomic, strong) UIFont *contentFont;
/** 内容正常颜色,默认 YLT_HEXCOLOR(0x777777) **/
@property (nonatomic, strong) UIColor *contentNormalColor;
/** 链接内容正常颜色,默认 YLT_HEXCOLOR(0x1C90E4) **/
@property (nonatomic, strong) UIColor *contentLinkNormalColor;
/** 链接高亮颜色,默认 YLT_HEXCOLOR(0x1C90E4) **/
@property (nonatomic, strong) UIColor *contentLinkHighlightColor;
/** 内容对其方式，默认 NSTextAlignmentLeft **/
@property (nonatomic, assign) NSTextAlignment contentAlignment;
/** 行间距，默认5 **/
@property (nonatomic, assign) CGFloat lineSpace;

#pragma mark - 按钮相关

/** 样式，默认，HKPromptViewButtonTypeDouble **/
@property (nonatomic, assign) HKPromptViewButtonType promptViewButtonType;

/** 按钮文字字体，默认 [UIFont ylt_regularFont:14]**/
@property (nonatomic, strong) UIFont *buttonTitleFont;
/** 第一个按钮文字颜色, 默认YLT_HEXCOLOR(0xAAAAAA); **/
@property (nonatomic, strong) UIColor *firstButtonTitleColor;
/** 第一个按钮图标 **/
@property (nonatomic, strong) UIImage *firstButtonTitleImage;
/** 第一个按钮背景颜色, 默认YLT_HEXCOLOR(0xFFFFFF); **/
@property (nonatomic, strong) UIColor *firstButtonBackgroundColor;
/** 第一个按钮背景图 **/
@property (nonatomic, strong) UIImage *firstButtonBackgroundImage;
/** 第二个按钮文字颜色，默认YLT_HEXCOLOR(0xB69150) **/
@property (nonatomic, strong) UIColor *secondButtonTitleColor;
/** 第二个按钮图标 **/
@property (nonatomic, strong) UIImage *secondButtonTitleImage;
/** 第二个按钮背景颜色，默认YLT_HEXCOLOR(0xFFFFFF) **/
@property (nonatomic, strong) UIColor *secondButtonBackgroundColor;
/** 第二个按钮背景图 **/
@property (nonatomic, strong) UIImage *secondButtonBackgroundImage;

#pragma mark - 布局相关

/** 内容区域水平外边距，默认 38 **/
@property (nonatomic, assign) CGFloat contentViewHorizontalMargin;
/** 内容区域水平内边距，默认 23 **/
@property (nonatomic, assign) CGFloat contentViewHorizontalPadding;

/** 文字标题顶部边距，默认 22 **/
@property (nonatomic, assign) CGFloat textTitleMarginTop;
/** 图片标题最大高度，默认100 **/
@property (nonatomic, assign) CGFloat imageTitleMaxHeight;
/** 图片标题顶部边距，默认 0 **/
@property (nonatomic, assign) CGFloat imageTitleMarginTop;

/** 文字内容顶部边距，默认 15 **/
@property (nonatomic, assign) CGFloat contentLabelMarginTop;
/** 文字内容底部边距，默认 20 **/
@property (nonatomic, assign) CGFloat contentLabelMarginBottom;

/** 按钮栏高度，默认 44 **/
@property (nonatomic, assign) CGFloat buttonBarHeight;

@end
