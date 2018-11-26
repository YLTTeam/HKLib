//
//  HKPromptRichTextContentView.h
//  BMLib
//
//  Created by 永平 on 2018/9/29.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "HKPromptBaseContentView.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface HKPromptRichTextContentView : HKPromptBaseContentView

/** 内容Label **/
@property (nonatomic, strong) TTTAttributedLabel *contentLabel;

/** 富文本大小 **/
@property (nonatomic, assign) CGSize attrStringSize;

@end
