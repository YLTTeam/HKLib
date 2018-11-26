#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HKLib.h"
#import "HKPromptViewBottomBar.h"
#import "HKPromptViewConfig.h"
#import "HKPromptBaseContentView.h"
#import "HKPromptRichTextContentView.h"
#import "HKPromptStyleOneContentView.h"
#import "HKPromptStyleTwoContentView.h"
#import "HKPromptViewDefines.h"
#import "HKPromptView.h"
#import "HKPromptViewProtocol.h"
#import "HKLibTools.h"
#import "NSString+JCRegexHelper.h"

FOUNDATION_EXPORT double HKLibVersionNumber;
FOUNDATION_EXPORT const unsigned char HKLibVersionString[];

