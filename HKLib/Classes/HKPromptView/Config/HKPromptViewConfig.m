//
//  HKPromptViewConfig.m
//  BMLib
//
//  Created by 永平 on 2018/9/26.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "HKPromptViewConfig.h"
#import <YLT_Kit/YLT_Kit.h>

@implementation HKPromptViewConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        self.promptViewButtonType = HKPromptViewButtonTypeDouble;
        
        self.promptViewType = HKPromptViewType1;
        
        self.animationWhenShowAndHide = YES;
        self.contentAlignment = NSTextAlignmentLeft;
        self.contentBackgroundColor = [UIColor whiteColor];
        self.contentCornerRadius = 2;
        self.backgroundColor = YLT_HEXCOLORA(0x000000, 0.5);
        
        self.buttonTitleFont = [UIFont ylt_regularFont:14];
        self.firstButtonTitleColor = YLT_HEXCOLOR(0xAAAAAA);
        self.secondButtonTitleColor = YLT_HEXCOLOR(0xB69150);
        self.firstButtonBackgroundColor  = YLT_HEXCOLOR(0xFFFFFF);
        self.secondButtonBackgroundColor = YLT_HEXCOLOR(0xFFFFFF);
        
        self.textTitleFont = [UIFont ylt_regularFont:15];
        self.textTitleColor = YLT_HEXCOLOR(0x000000);
        
        self.contentFont = [UIFont ylt_regularFont:14];
        self.contentNormalColor = YLT_HEXCOLOR(0x777777) ;
        self.contentLinkNormalColor = YLT_HEXCOLOR(0x1C90E4) ;
        self.contentLinkHighlightColor = YLT_HEXCOLOR(0x1C90E4) ;
        self.lineSpace = 2;
        self.contentAlignment = NSTextAlignmentLeft;
        
        self.imageTitleMarginTop = 0;
        self.imageTitleMaxHeight = 100;
        
        self.contentViewHorizontalMargin = 38;
        self.contentViewHorizontalPadding = 23;
        self.textTitleMarginTop = 22;
        self.contentLabelMarginTop = 15;
        self.contentLabelMarginBottom = 20;
        self.buttonBarHeight = 44;
    }
    return self;
}

@end
