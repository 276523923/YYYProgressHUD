//
//   YYYShapeView.h
//   YYYProgressHUD
//   
//   Created by yyy on 2021/1/14
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYYRingShapedView : UIView

@property(nonatomic, strong) UIColor* progressTintColor;
@property(nonatomic, strong) UIColor* trackTintColor;

@property(nonatomic) CGFloat progress;                        // 0.0 .. 1.0, default is 0.0. values outside are pinned.

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

@end

NS_ASSUME_NONNULL_END
