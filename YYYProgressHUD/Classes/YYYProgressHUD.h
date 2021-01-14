//
//  YYYProgressHUD.h
//  TestProject
//
//  Created by yyy on 2018/7/20.
//  Copyright © 2018年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYYLoadingHUDView.h"
#import "YYYTextHUDView.h"
#import "YYYRingShapedView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YYYProgressHUDModel) {
    YYYProgressHUDModelLoading,
    YYYProgressHUDModelText,
    YYYProgressHUDModelRingShaped,
    YYYProgressHUDModelCustom,
};

typedef void(^YYYProgressHUDBlock)(void);

@interface YYYProgressHUD : UIView

@property (nonatomic, strong, readonly) UIView *currentView;

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong, readonly) YYYLoadingHUDView *loadingView;
@property (nonatomic, strong, readonly) YYYTextHUDView *textView;
@property (nonatomic, strong, readonly) YYYRingShapedView *ringShapedView;

@property (nonatomic) YYYProgressHUDModel model;
@property (nonatomic, strong, readonly) NSLayoutConstraint *centerXConstraint;
@property (nonatomic, strong, readonly) NSLayoutConstraint *centerYConstraint;


+ (instancetype)showHUDAddedTo:(UIView *_Nullable)view model:(YYYProgressHUDModel)model;
+ (void)hideHUDForView:(UIView *_Nullable)view model:(YYYProgressHUDModel)model;
+ (void)hideHUDForView:(UIView *_Nullable)view;

+ (nullable instancetype)HUDForView:(UIView *_Nullable)view;
+ (nullable instancetype)HUDForView:(UIView *_Nullable)view model:(YYYProgressHUDModel)model;

+ (nullable NSArray *)HUDsForView:(UIView *_Nullable)view;
+ (nullable  NSArray *)HUDsForView:(UIView *_Nullable)view model:(YYYProgressHUDModel)model;

#pragma mark -  YYYLoadingHUDView
+ (instancetype)showLoadingHUDAddedTo:(UIView * _Nullable )view;
+ (instancetype)showLoadingHUD;
+ (void)hideLoadingHUDForView:(UIView *_Nullable)view;
+ (void)hideLoadingHUD;

#pragma mark -  YYYTextHUDView
+ (instancetype)showTextHUDAddedTo:(UIView * _Nullable)view text:(NSString *)text;
+ (instancetype)showTextHUDAddedTo:(UIView * _Nullable)view text:(NSString *)text didDismissBlock:(void (^)(void))didDismissBlock;

+ (instancetype)showTextHUD:(NSString *)text;
+ (instancetype)showTextHUD:(NSString *)text didDismissBlock:(void (^)(void))didDismissBlock;
+ (void)hideTextHUDForView:(UIView * _Nullable)view;
+ (void)hideTextHUD;

#pragma mark - YYYRingShapedView
+ (instancetype)showRingShapedHUDAddedTo:(UIView * _Nullable )view;
+ (instancetype)showRingShapedHUD;
+ (void)hideRingShapedHUDForView:(UIView *_Nullable)view;
+ (void)hideRingShapedHUD;

#pragma mark -  custom view
+ (instancetype)showCustomHUDAddedTo:(UIView * _Nullable)view customView:(UIView *)customView;
+ (instancetype)showCustomHUD:(UIView * _Nullable)customView;
+ (void)hideCustomHUDForView:(UIView * _Nullable)view;
+ (void)hideCustomHUD;

- (void)setDidDismissBlock:(YYYProgressHUDBlock)didDismissBlock;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
