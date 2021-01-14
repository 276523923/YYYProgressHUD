//
//   YYYShapeView.m
//   YYYProgressHUD
//   
//   Created by yyy on 2021/1/14
//

#import "YYYRingShapedView.h"

@implementation YYYRingShapedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius  = 13;
        self.layer.masksToBounds = NO;
        self.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset  = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius  = 4;
        if (@available(iOS 13.0, *)) {
            self.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor colorWithRed:33/255.0f green:33/255.0f blue:33/255.0f alpha:1];
                } else {
                    return [UIColor colorWithWhite:0 alpha:0.8];
                }
            }];
        } else {
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
                // Fallback on earlier versions
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat offset = 5;
    
    CGFloat width = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) - offset * 2;
    self.progressLayer.frame = self.backgroundLayer.frame =  CGRectMake(offset, offset, width, width);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.progressLayer.bounds, 7, 7) cornerRadius:(width / 2 - 7)];
    self.progressLayer.path = self.backgroundLayer.path = path.CGPath;
}


- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(88, 88);
}

- (void)sizeToFit {
    CGSize size = [self sizeThatFits:CGSizeZero];
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)intrinsicContentSize {
    return [self sizeThatFits:CGSizeZero];
}

#pragma mark - get,set

- (CGFloat)progress {
    return self.progressLayer.strokeEnd;
}

- (void)setProgress:(CGFloat)progress {
    self.progressLayer.strokeEnd = progress;
}

- (UIColor *)progressTintColor {
    return [UIColor colorWithCGColor:self.progressLayer.strokeColor];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    self.progressLayer.strokeColor = progressTintColor.CGColor;
}

- (UIColor *)trackTintColor {
    return [UIColor colorWithCGColor:self.backgroundLayer.strokeColor];
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
    self.backgroundLayer.strokeColor = trackTintColor.CGColor;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.backgroundColor = [UIColor clearColor].CGColor;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = [UIColor redColor].CGColor;
        _progressLayer.lineWidth = 2;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 0;
        [self.layer addSublayer:_progressLayer];
    }
    return _progressLayer;
}

- (CAShapeLayer *)backgroundLayer {
    if (!_backgroundLayer) {
        CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
        backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
        backgroundLayer.fillColor = [UIColor clearColor].CGColor;
        backgroundLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        backgroundLayer.lineWidth = 2;
        backgroundLayer.lineCap = kCALineCapRound;
        backgroundLayer.strokeStart = 0;
        backgroundLayer.strokeEnd = 1;
        _backgroundLayer = backgroundLayer;
        [self.layer insertSublayer:_backgroundLayer below:self.progressLayer];
    }
    return _backgroundLayer;
}

@end
