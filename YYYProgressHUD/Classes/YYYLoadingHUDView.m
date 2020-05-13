//
//  YYYHUDView.m
//  BaoZhangWang
//
//  Created by yyy on 2017/4/28.
//  Copyright © 2017年 yyy. All rights reserved.
//

#import "YYYLoadingHUDView.h"
#import "YYYIndefiniteAnimatedView.h"
@interface YYYLoadingHUDView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) YYYIndefiniteAnimatedView *indefiniteAnimatedView;

@end

@implementation YYYLoadingHUDView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

#pragma mark - init views and setup layout -

- (void)loadSubviews {
    [self addSubview:self.contentView];
    [self addSubview:self.indefiniteAnimatedView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    self.indefiniteAnimatedView.center = self.contentView.center;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
        _contentView.backgroundColor = YYYLoadingHUDView.backgroundColor;
        
        _contentView.layer.cornerRadius  = 13;
        _contentView.layer.masksToBounds = NO;
        _contentView.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
        _contentView.layer.shadowOffset  = CGSizeMake(0, 0);
        _contentView.layer.shadowOpacity = 0.5;
        _contentView.layer.shadowRadius  = 4;
    }
    return _contentView;;
}

- (YYYIndefiniteAnimatedView *)indefiniteAnimatedView {
    if (_indefiniteAnimatedView == nil) {
        _indefiniteAnimatedView = [[YYYIndefiniteAnimatedView alloc] initWithFrame:CGRectZero];
        _indefiniteAnimatedView.strokeThickness = 2;
        _indefiniteAnimatedView.strokeColor = [UIColor colorWithRed:1 green:52/255.F blue:49/255.f alpha:1];
        _indefiniteAnimatedView.radius = 25;
        [_indefiniteAnimatedView sizeToFit];
        CGSize size = [_indefiniteAnimatedView sizeThatFits:CGSizeZero];
        _indefiniteAnimatedView.frame = CGRectMake(0, 0, size.width, size.height);
    }
    return _indefiniteAnimatedView;
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

static UIColor *c_backgroundColor = nil;
+ (UIColor *)backgroundColor {
    if (!c_backgroundColor) {
        if (@available(iOS 13, *)) {
            c_backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor colorWithRed:33/255.0f green:33/255.0f blue:33/255.0f alpha:1];
                } else {
                    return [UIColor whiteColor];
                }
            }];
        } else {
            c_backgroundColor = [UIColor whiteColor];
        }
    }
    return c_backgroundColor;
}

+ (void)setBackgroundColor:(UIColor *)backgroundColor {
    c_backgroundColor = backgroundColor;
}

@end
