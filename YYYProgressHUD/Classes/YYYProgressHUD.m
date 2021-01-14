//
//  YYYProgressHUD.m
//  TestProject
//
//  Created by yyy on 2018/7/20.
//  Copyright © 2018年 yyy. All rights reserved.
//

#import "YYYProgressHUD.h"
#import "YYYWeakProxy.h"

@interface YYYProgressHUD ()

@property (nonatomic, strong, readwrite) UIView *currentView;
@property (nonatomic, strong, readwrite) YYYLoadingHUDView *loadingView;
@property (nonatomic, strong, readwrite) YYYTextHUDView *textView;
@property (nonatomic, strong, readwrite) YYYRingShapedView *ringShapedView;

@property (nonatomic, copy) YYYProgressHUDBlock dismissBlock;
@property (nonatomic, strong) YYYWeakProxy *weakProxy;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong, readwrite) NSLayoutConstraint *centerXConstraint;
@property (nonatomic, strong, readwrite) NSLayoutConstraint *centerYConstraint;

@end

@implementation YYYProgressHUD

+ (instancetype)showHUDAddedTo:(UIView *)view model:(YYYProgressHUDModel)model {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    YYYProgressHUD *hud = [[YYYProgressHUD alloc] initWithView:view model:model];
    [view addSubview:hud];
    [UIView animateWithDuration:0.3 animations:^{
        hud.alpha = 1;
    }];
    return hud;
}

+ (void)hideHUDForView:(UIView *)view model:(YYYProgressHUDModel)model {
    NSArray *array = [self HUDsForView:view model:model];
    [array makeObjectsPerformSelector:@selector(dismiss)];
}

+ (void)hideHUDForView:(UIView *)view {
    NSArray *array = [self HUDsForView:view];
    [array makeObjectsPerformSelector:@selector(dismiss)];
}

+ (nullable instancetype)HUDForView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            YYYProgressHUD *hud = (YYYProgressHUD *)subview;
            return hud;
        }
    }
    return nil;
}

+ (NSArray *)HUDsForView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    NSMutableArray *array = [NSMutableArray array];
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            YYYProgressHUD *hud = (YYYProgressHUD *)subview;
            [array addObject:hud];
        }
    }
    return array;
}

+ (NSArray *)HUDsForView:(UIView *)view model:(YYYProgressHUDModel)model {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    NSMutableArray *array = [NSMutableArray array];
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            YYYProgressHUD *hud = (YYYProgressHUD *)subview;
            if (hud.model == model) {
                [array addObject:hud];
            }
        }
    }
    return array;
}

+ (instancetype)HUDForView:(UIView *)view model:(YYYProgressHUDModel)model {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            YYYProgressHUD *hud = (YYYProgressHUD *)subview;
            if (hud.model == model) {
                return hud;
            }
        }
    }
    return nil;
}

#pragma mark -  YYYLoadingHUDView
+ (instancetype)showLoadingHUDAddedTo:(UIView * _Nullable)view {
    return [self showHUDAddedTo:view model:YYYProgressHUDModelLoading];
}

+ (instancetype)showLoadingHUD {
    return [self showLoadingHUDAddedTo:nil];
}

+ (void)hideLoadingHUDForView:(UIView * _Nullable)view {
    return [self hideHUDForView:view model:YYYProgressHUDModelLoading];
}

+ (void)hideLoadingHUD {
    return [self hideLoadingHUDForView:nil];
}

#pragma mark -  YYYTextHUDView
+ (instancetype)showTextHUDAddedTo:(UIView * _Nullable)view text:(NSString *)text {
    if (!text || text.length == 0) {
        return nil;
    }
    YYYProgressHUD *hud = [self showHUDAddedTo:view model:YYYProgressHUDModelText];
    hud.textView.message = text;
    return hud;
}

+ (instancetype)showTextHUDAddedTo:(UIView * _Nullable)view text:(NSString *)text didDismissBlock:(void (^)(void))didDismissBlock {
    YYYProgressHUD *hud = [YYYProgressHUD showTextHUDAddedTo:view text:text];
    [hud setDidDismissBlock:didDismissBlock];
    return hud;
}

+ (instancetype)showTextHUD:(NSString *)text {
    return [self showTextHUDAddedTo:nil text:text];
}

+ (instancetype)showTextHUD:(NSString *)text didDismissBlock:(void (^)(void))didDismissBlock {
    return [self showTextHUDAddedTo:nil text:text didDismissBlock:didDismissBlock];
}

+ (void)hideTextHUDForView:(UIView *)view {
    return [self hideHUDForView:view model:YYYProgressHUDModelText];
}

+ (void)hideTextHUD {
    return [self hideTextHUDForView:nil];
}

#pragma mark - YYYRingShapedView

+ (instancetype)showRingShapedHUDAddedTo:(UIView * _Nullable)view {
    return [self showHUDAddedTo:view model:YYYProgressHUDModelRingShaped];
}

+ (instancetype)showRingShapedHUD {
    return [self showRingShapedHUDAddedTo:nil];
}

+ (void)hideRingShapedHUDForView:(UIView * _Nullable)view {
    return [self hideHUDForView:view model:YYYProgressHUDModelRingShaped];
}

+ (void)hideRingShapedHUD {
    return [self hideRingShapedHUDForView:nil];
}

#pragma mark - custom view
+ (instancetype)showCustomHUDAddedTo:(UIView *)view customView:(UIView *)customView {
    if (!customView) {
        return nil;
    }
    YYYProgressHUD *hud = [self showHUDAddedTo:view model:YYYProgressHUDModelCustom];
    hud.customView = customView;
    return hud;
}

+ (instancetype)showCustomHUD:(UIView *)customView {
    return [self showCustomHUDAddedTo:nil customView:customView];
}

+ (void)hideCustomHUDForView:(UIView *)view {
    return [self hideHUDForView:view model:YYYProgressHUDModelCustom];
}

+ (void)hideCustomHUD {
    return [self hideCustomHUDForView:nil];
}

#pragma mark - fast init
- (instancetype)initWithView:(UIView *)view model:(YYYProgressHUDModel)model {
    self = [self initWithFrame:view.bounds];
    if (self) {
        self.model = model;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.0f;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.layer.allowsGroupOpacity = NO;
        self.userInteractionEnabled = YES;
        self.model = YYYProgressHUDModelLoading;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)dealloc {
    if (_textView) {
        [_textView removeObserver:self forKeyPath:@"message"];
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - public code
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.dismissBlock) {
            self.dismissBlock();
        }
        self.dismissBlock = nil;
    }];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)setDidDismissBlock:(YYYProgressHUDBlock)didDismissBlock {
    self.dismissBlock = didDismissBlock;
}

#pragma mark - private code

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self updateCurrentViewIfNeed];
    }
}

- (void)updateCurrentViewIfNeed {
    UIView *view = [self customViewWithModel];
    if (self.currentView != view) {
        if (self.centerXConstraint) {
            [self removeConstraint:self.centerXConstraint];
        }
        if (self.centerYConstraint) {
            [self removeConstraint:self.centerYConstraint];
        }
        [self.currentView removeFromSuperview];
        self.currentView = nil;
        if (view) {
            self.currentView = view;
            [self addSubview:self.currentView];
            self.currentView.translatesAutoresizingMaskIntoConstraints = NO;
            self.centerXConstraint = [NSLayoutConstraint constraintWithItem:self.currentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            self.centerYConstraint = [NSLayoutConstraint constraintWithItem:self.currentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            [self addConstraint:self.centerXConstraint];
            [self addConstraint:self.centerYConstraint];
            [UIView performWithoutAnimation:^{
                [self.currentView sizeToFit];
                [self.currentView layoutIfNeeded];
            }];
        }
    }
    [self layoutIfNeeded];
}

- (UIView *)customViewWithModel {
    switch (self.model) {
        case YYYProgressHUDModelLoading:
            return self.loadingView;
        case YYYProgressHUDModelText:
            return self.textView;
        case YYYProgressHUDModelRingShaped:
            return self.ringShapedView;
        case YYYProgressHUDModelCustom:
            return self.customView;
        default:
            return nil;
            break;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == _textView && [keyPath isEqualToString:@"message"]) {
        if (self.timer) {
            [self.timer invalidate];
        }
        CGFloat duration = [self.textView displayDurationForString:self.textView.message];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:duration target:[YYYWeakProxy proxyWithTarget:self] selector:@selector(dismiss) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - get,set
- (void)setModel:(YYYProgressHUDModel)model {
    if (_model == model) {
        return;
    }
    _model = model;
    if (self.superview) {
        [self updateCurrentViewIfNeed];
    }
}

- (YYYLoadingHUDView *)loadingView {
    if (!_loadingView) {
        _loadingView = [YYYLoadingHUDView new];
        [_loadingView sizeToFit];
    }
    return _loadingView;
}   

- (YYYTextHUDView *)textView {
    if (!_textView) {
        _textView = [YYYTextHUDView new];
        [_textView sizeToFit];
        [_textView addObserver:self forKeyPath:@"message" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _textView;
}

- (YYYRingShapedView *)ringShapedView {
    if (!_ringShapedView) {
        _ringShapedView = [YYYRingShapedView new];
        [_ringShapedView sizeToFit];
    }
    return _ringShapedView;
}

- (void)setCustomView:(UIView *)customView {
    if (_customView == customView) {
        return;
    }
    _customView = customView;
    if (self.superview) {
        [self updateCurrentViewIfNeed];
    }
}

@end
