//
//  HKPromptView.m
//  BMLib
//
//  Created by 永平 on 2018/9/26.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "HKPromptView.h"
#import <YLT_Kit/YLT_Kit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "HKPromptViewBottomBar.h"
#import "HKPromptBaseContentView.h"
#import "HKPromptStyleOneContentView.h"
#import "HKPromptStyleTwoContentView.h"

#import <pop/pop.h>

#define HKPromptViewWidth (375 - self.config.contentViewHorizontalMargin*2)

@interface PromptViewController:UIViewController
@end
@implementation PromptViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end

@interface HKPromptView()

/** 配置 **/
@property (nonatomic, strong) HKPromptViewConfig *config;

/** 当前显示的AlertWin **/
@property (nonatomic, strong) UIWindow *alertWin;
/** 之前的KeyWin **/
@property (nonatomic, weak) UIWindow *preKeyWin;

/** 中间白色内容视图 **/
@property (nonatomic, strong) UIView *centerAreaView;

/** 中间显示内容 **/
@property (nonatomic, strong) HKPromptBaseContentView *contentView;
/** 中间显示自定义视图 **/
@property (nonatomic, strong) UIView *customView;
/** 底部按钮栏 **/
@property (nonatomic, strong) HKPromptViewBottomBar *bottomBar;

/** 显示内容的尺寸 **/
@property (nonatomic, assign) CGSize contentSize;

@end

@implementation HKPromptView

+ (instancetype)promptView:(void(^)(HKPromptViewConfig *config))configBlock{
    HKPromptViewConfig *config = [[HKPromptViewConfig alloc]init];
    if (configBlock) {
        configBlock(config);
    }
    HKPromptView *v = [[HKPromptView alloc]init];
    v.config = config;
    [v setupUI]; //绘制UI
    return v;
}

- (void)setupUI{
    
    //内容视图
    [self addSubview:self.centerAreaView];
    [self.centerAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(HKPromptViewWidth);
        make.height.mas_equalTo(320);
        make.center.equalTo(self);
    }];
    
    if (self.config.promptViewType == HKPromptViewType1) {//文字标题 + 富文本内容
        self.contentView = [[HKPromptStyleOneContentView alloc]init];
    }else if(self.config.promptViewType == HKPromptViewType2){ //图片标题 + 富文本内容
        self.contentView = [[HKPromptStyleTwoContentView alloc]init];
    }else if(self.config.promptViewType == HKPromptViewTypeCustomize){ //自定义
        
    }
    
    self.contentView.config = self.config;
    self.contentView.promptView = self;
    [self.contentView setupUI];
    
    //底部按钮栏
    [self.centerAreaView addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.config.buttonBarHeight);
    }];
    
    if (self.config.promptViewType != HKPromptViewType1
        || self.config.promptViewType != HKPromptViewType2) {
        [self.centerAreaView addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.config.contentViewHorizontalPadding);
            make.right.mas_equalTo(-self.config.contentViewHorizontalPadding);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
    }
}

#pragma mark - setter

/** 标题 **/
- (void)setTitle:(id)title{
    if (!title) { return; }
    [self.contentView setTitle:title];
}
- (void)setTitleImage:(UIImage*)titleImage{
    if (!titleImage) { return; }
    [self.contentView setTitleImage:titleImage];
}
/** 内容 **/
- (void)setContent:(id)content{
    if (content) {
        [self.contentView setContent:content];
    }
    
    [self.centerAreaView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self.contentView getContentViewHeight] + self.config.buttonBarHeight);
    }];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self.contentView getContentViewHeight]);
    }];
}
/** 自定义 **/
- (void)setCustomView:(UIView*)customView customViewHeight:(CGFloat)customViewHeight;{
    if (self.config.promptViewType != HKPromptViewTypeCustomize) {
        return;
    }
    self.customView = customView;
    [self.centerAreaView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(customViewHeight + self.config.buttonBarHeight);
    }];
    [self.centerAreaView addSubview:customView];
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(customViewHeight);
        make.left.top.right.mas_equalTo(0);
    }];
}

#pragma mark - 底部按钮栏-公开方法

- (void)configFirstButton:(NSString*)title clickBlock:(void(^)(HKPromptView*sender))clickBlock{
    [self.bottomBar configFirstButton:title clickBlock:clickBlock];
}

- (void)configSecondButton:(NSString*)title clickBlock:(void(^)(HKPromptView*sender))clickBlock{
    [self.bottomBar configSecondButton:title clickBlock:clickBlock];
}

#pragma mark - 富文本-公开方法

- (void)addLinkString:(NSString*)linkString clickBlock:(void(^)(HKPromptView*sender))clickBlock{
    if (linkString.ylt_isValid) {
        [self.contentView addLinkString:linkString clickBlock:clickBlock];
    }
}

- (void)showVC:(UIViewController *)vc{
    [self.currentVC.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 显示/隐藏

- (void)showOnSuperView:(UIView*)superView{
    self.frame = superView.bounds;
    [superView addSubview:self];
    [self startShowAnimation];
}

- (void)showOnAlertWindow{
    
    self.preKeyWin = [UIApplication sharedApplication].keyWindow;
    
    [self.alertWin makeKeyAndVisible];
    self.frame = [UIScreen mainScreen].bounds;
    
    [self.currentVC.view addSubview:self];
    [self startShowAnimation];
}

- (void)hideAnimation:(void(^)(void))complete{
    @weakify(self)
    [self startHideAnimation:^{
        @strongify(self)
        //这里延迟0.1秒，避免弹窗隐藏后需要菊花，却不显示问题(具体原因还不明确)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (complete) {
                complete();
            }
        });
         [self hide];
    }];
}

- (void)hideNoAnimation{
    [self hide];
}

- (void)hide{
    //及时将原先的preKeyWin makeKey
    [self.preKeyWin makeKeyWindow];
    //先将alerWin resign下
    [self.alertWin resignKeyWindow];
    self.alertWin = nil;
    [self removeFromSuperview];
}

#pragma mark - 私有方法

///显示动画
- (void)startShowAnimation{
    
    if (!self.config.animationWhenShowAndHide) {
        return;
    }
    
    //背景色
    {
        [self.layer pop_removeAllAnimations];
        POPBasicAnimation *backgroundAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        backgroundAnim.fromValue           = [UIColor clearColor];
        backgroundAnim.toValue             = self.config.backgroundColor;
        [self.layer pop_addAnimation:backgroundAnim forKey:nil];
    }
    
    //内容区域缩放
    {
        //缩放动画
        [self.centerAreaView.layer pop_removeAllAnimations];
        POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnim.fromValue           = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
        scaleAnim.toValue             = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
        scaleAnim.springSpeed = 20;
        [self.centerAreaView.layer pop_addAnimation:scaleAnim forKey:nil];
        
        //透明度动画
        POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        opacityAnim.fromValue           = @(0);
        opacityAnim.toValue             = @(1);
        [self.centerAreaView.layer pop_addAnimation:opacityAnim forKey:nil];
    }
}

/**
 隐藏动画

 @param complete 动画执行结束后的回调
 */
- (void)startHideAnimation:(void(^)(void))complete{
    
    if (!self.config.animationWhenShowAndHide) {
        complete();
        return;
    }
    
    //背景色
    {
        [self.layer pop_removeAllAnimations];
        POPBasicAnimation *backgroundAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        backgroundAnim.fromValue           = self.config.backgroundColor;
        backgroundAnim.toValue             = [UIColor clearColor];
        [self.layer pop_addAnimation:backgroundAnim forKey:nil];
    }
    
    //内容区域缩放
    {
        //缩放动画
        [self.centerAreaView.layer pop_removeAllAnimations];
        POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnim.fromValue             = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
        scaleAnim.toValue           = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
        scaleAnim.springSpeed = 20;
        [scaleAnim setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
            complete();
        }];
        [self.centerAreaView.layer pop_addAnimation:scaleAnim forKey:nil];
        
        //透明度
        POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        opacityAnim.fromValue           = @(1);
        opacityAnim.toValue             = @(0);
        [self.centerAreaView.layer pop_addAnimation:opacityAnim forKey:nil];
    }
}

///返回当前视图
- (UIViewController*)currentVC{
    if (_alertWin) {
        UINavigationController *nav = (UINavigationController*)self.alertWin.rootViewController;
        return nav.topViewController;
    }else{
        return self.ylt_currentVC;
    }
}

#pragma mark - 懒加载

- (HKPromptViewBottomBar *)bottomBar{
    if (!_bottomBar) {
        _bottomBar = [[HKPromptViewBottomBar alloc]init];
        _bottomBar.config = self.config;
        _bottomBar.promptView = self;
        [_bottomBar setupUI];
    }
    return _bottomBar;
}

///中间白色区域
- (UIView *)centerAreaView{
    if (!_centerAreaView) {
        _centerAreaView = [[UIView alloc]init];
        _centerAreaView.backgroundColor = self.config.contentBackgroundColor;
        _centerAreaView.alpha = 0;
        if (self.config.contentCornerRadius > 0) {
            _centerAreaView.layer.cornerRadius = self.config.contentCornerRadius;
            _centerAreaView.layer.masksToBounds = YES;
        }
    }
    return _centerAreaView;
}

///Alert Window
- (UIWindow *)alertWin{
    if (!_alertWin) {
        _alertWin = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        _alertWin.windowLevel = UIWindowLevelAlert;
        
        PromptViewController *rootVC = [[PromptViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootVC];
        _alertWin.rootViewController = nav;
    }
    return _alertWin;
}

#pragma mark - getter

- (CGFloat)clientWidth{
    return HKPromptViewClientWidth;
}

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
                    otherBlock:(void(^)(HKPromptView *sender))otherBlock {
    HKPromptView *promptView = [HKPromptView promptView:^(HKPromptViewConfig *config) {
        config.promptViewType = HKPromptViewType1;//图片标题 + 富文本内容
        config.contentAlignment = NSTextAlignmentCenter;
    }];
    [promptView configFirstButton:cancelTitle clickBlock:^(HKPromptView *sender) {
        [sender hideAnimation:^{
        }];
        if (cancelBlock) {
            cancelBlock(sender);
        }
    }];
    [promptView configSecondButton:otherTitle clickBlock:^(HKPromptView *sender) {
        [sender hideAnimation:^{
        }];
        if (otherBlock) {
            otherBlock(sender);
        }
    }];
    [promptView setTitle:title];
    [promptView setContent:message];
    [promptView showOnAlertWindow];
    return promptView;
}

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
                   cancelBlock:(void(^)(HKPromptView *sender))cancelBlock {
    HKPromptView *promptView = [HKPromptView promptView:^(HKPromptViewConfig *config) {
        config.promptViewType = HKPromptViewType1;//图片标题 + 富文本内容
        config.promptViewButtonType = HKPromptViewButtonTypeSingle;
        config.contentAlignment = NSTextAlignmentCenter;
    }];
    [promptView configFirstButton:cancelTitle clickBlock:^(HKPromptView *sender) {
        [sender hideAnimation:^{
        }];
        if (cancelBlock) {
            cancelBlock(sender);
        }
    }];
    [promptView setTitle:title];
    [promptView setContent:message];
    [promptView showOnAlertWindow];
    return promptView;
}

@end
