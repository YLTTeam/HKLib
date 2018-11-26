//
//  HKPromptRichTextContentView.m
//  BMLib
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "HKPromptRichTextContentView.h"
#import "NSString+JCRegexHelper.h"
#import <YLT_Kit/YLT_Kit.h>

@interface HKPromptRichTextContentView()<TTTAttributedLabelDelegate>

/** 内容 **/
@property (nonatomic, copy) NSString *contentString;

/** 高亮字符串数组 **/
@property (nonatomic, strong) NSMutableDictionary<NSString*,id> *linkStringMap;

@end

@implementation HKPromptRichTextContentView

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result{
    NSString *linkString = [self.contentString substringWithRange:result.range];
    void(^clickBlock)(HKPromptView*promptView) = self.linkStringMap[linkString];
    clickBlock(self.promptView);
}

#pragma mark - 公开方法

- (void)addLinkString:(NSString*)linkString clickBlock:(void(^)(HKPromptView*promptView))clickBlock{
    if ([linkString ylt_isValid]) {
        //如果内容中不包含linkString,则不处理
        if (![self.contentString containsString:linkString]) {
            return;
        }
        //刷新富文本
        [self setContent:self.contentString];
        //添加到集合中
        self.linkStringMap[linkString] = clickBlock;
        //添加到Label上
        for (NSString *key in self.linkStringMap.allKeys) {
            NSTextCheckingResult *result = [self.contentString firstMatchWithRegex:key];
            [self.contentLabel addLinkWithTextCheckingResult:result];
        }
    }
}

#pragma mark - 私有方法

#pragma mark - setter

- (void)setContent:(id)content{
    _contentString = content;
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:_contentString];
    //默认字体
    [attrString addAttribute:NSFontAttributeName value:self.config.contentFont range:NSMakeRange(0, _contentString.length)];
    //默认颜色
    [attrString addAttribute:NSForegroundColorAttributeName value:self.config.contentNormalColor range:NSMakeRange(0, _contentString.length)];
    //加宽行高
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = self.config.lineSpace;
    paragraphStyle.alignment = self.config.contentAlignment;
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _contentString.length)];
    
    //富文本尺寸
    self.attrStringSize = [attrString boundingRectWithSize:CGSizeMake(HKPromptViewClientWidth, 0) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
    
    self.contentLabel.attributedText = attrString;
}

#pragma mark - getter

///中间内容文字Label
- (TTTAttributedLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =  [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _contentLabel.delegate = self;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = self.config.contentAlignment;
        
        _contentLabel.linkAttributes = @{
                                         NSForegroundColorAttributeName:self.config.contentLinkNormalColor,
                                         NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone)
                                         };
        _contentLabel.activeLinkAttributes = @{
                                               NSForegroundColorAttributeName:self.config.contentLinkHighlightColor,
                                               NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone)
                                               };
    }
    return _contentLabel;
}

///中间文本中的点击事件
- (NSMutableDictionary<NSString *,id> *)linkStringMap{
    if (!_linkStringMap) {
        _linkStringMap = [NSMutableDictionary dictionary];
    }
    return _linkStringMap;
}

@end
