//
//  HKPromptView.h
//  BMLib
//
//  Created by 永平 on 2018/9/26.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKPromptViewConfig.h"
#import "HKPromptVIewProtocol.h"
#import "HKPromptViewDefines.h"


@interface HKPromptView : UIView<HKPromptBottomBarProtocol>

/** 中间可显示区域宽度 **/
@property (nonatomic, assign,readonly) CGFloat clientWidth;

+ (instancetype)promptView:(void(^)(HKPromptViewConfig *config))configBlock;

/** 标题 **/
- (void)setTitle:(id)title;
- (void)setTitleImage:(UIImage*)titleImage;
/** 内容 **/
- (void)setContent:(id)content;
/** 自定义 **/
- (void)setCustomView:(UIView*)customView customViewHeight:(CGFloat)customViewHeight;

/**
 内容区域添加链接文字
 */
- (void)addLinkString:(NSString*)linkString clickBlock:(void(^)(HKPromptView*sender))clickBlock;

/**
 在 Alert Window上显示
 */
- (void)showOnAlertWindow;

/**
 在指定 superView上显示
 */
- (void)showOnSuperView:(UIView*)superView;

/**
 隐藏提示框(有动画)

 @param complete 隐藏完成后的回调
 */
- (void)hideAnimation:(void(^)(void))complete;

/**
 隐藏提示框(无动画)
 */
- (void)hideNoAnimation;

/**
 显示页面，当在Alert Window显示时，需要push页面，则必须使用该方法进行push
 */
- (void)showVC:(UIViewController*)vc;

#pragma mark - 类方法

/**
 显示警告弹窗
 
 @param title 标题
 @param message 消息
 @param cancelTitle 取消标题
 @param otherTitle 其他标题
 @param cancelBlock 取消事件的回调
 @param otherBlock 其他事件回调
 @return 当前警告弹窗实例
 */
+ (instancetype)showAlertTitle:(NSString *)title
                       message:(NSString *)message
                   cancelTitle:(NSString *)cancelTitle
                    otherTitle:(NSString *)otherTitle
                   cancelBlock:(void(^)(HKPromptView *sender))cancelBlock
                    otherBlock:(void(^)(HKPromptView *sender))otherBlock;

/**
 显示警告弹窗
 
 @param title 标题
 @param message 消息
 @param cancelTitle 取消标题
 @param cancelBlock 取消事件的回调
 @return 当前警告弹窗实例
 */
+ (instancetype)showAlertTitle:(NSString *)title
                       message:(NSString *)message
                   cancelTitle:(NSString *)cancelTitle
                   cancelBlock:(void(^)(HKPromptView *sender))cancelBlock;

@end

#define HK_TipAlert(_S_, ...) [HKPromptView showAlertTitle:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] message:nil cancelTitle:@"确定" cancelBlock:nil];

