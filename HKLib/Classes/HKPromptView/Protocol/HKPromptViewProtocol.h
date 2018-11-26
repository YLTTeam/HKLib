//
//  HKPromptViewProtocol.h
//  BlackCard
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#ifndef HKPromptViewProtocol_h
#define HKPromptViewProtocol_h

@class HKPromptView;

@protocol HKPromptContentHeightProtocol<NSObject>

@optional

- (CGFloat)getContentViewHeight;

@end


@protocol HKPromptBottomRictTextProtocol<NSObject>

@optional

/// 添加富文本链接按钮
- (void)addLinkString:(NSString*)linkString clickBlock:(void(^)(HKPromptView*sender))clickBlock;

@end


@protocol HKPromptBottomBarProtocol<NSObject>

@optional

/**
 左侧按钮
 
 @param title 按钮文字
 @param clickBlock 点击事件
 */
- (void)configFirstButton:(NSString*)title clickBlock:(void(^)(HKPromptView*sender))clickBlock;

/**
 右侧按钮，当config.promptViewButtonType==HKPromptViewButtonTypeSingle时，该方法无效
 
 @param title 按钮文字
 @param clickBlock 点击事件
 */
- (void)configSecondButton:(NSString*)title clickBlock:(void(^)(HKPromptView*sender))clickBlock;

@end

#endif /* HKPromptViewProtocol_h */
