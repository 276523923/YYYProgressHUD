//
//  YYYTextHUDView.m
//  TestProject
//
//  Created by yyy on 2018/7/20.
//  Copyright © 2018年 yyy. All rights reserved.
//

#import "YYYTextHUDView.h"

@implementation YYYTextHUDView

@dynamic message;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
        self.backgroundColor = YYYTextHUDView.backgroundColor;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (NSTimeInterval)displayDurationForString:(NSString *)string {
    return MIN((float) string.length * 0.06 + 1, 5.0);
}

#pragma mark - init views and setup layout -
- (void)loadSubviews {
    self.messageLabel = [UILabel new];
    self.messageLabel.font = [UIFont systemFontOfSize:15];
    self.messageLabel.textColor = YYYTextHUDView.textColor;
    self.messageLabel.numberOfLines = 0;
    [self addSubview:self.messageLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.messageLabel.frame = CGRectInset(self.bounds, 10, 10);
    if (CGRectGetWidth(self.bounds) <= 80) {
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(200, 0);
    }
    CGSize messageLabelSize = [self.messageLabel sizeThatFits:size];
    CGFloat offset = 10;
    CGSize newSize = CGSizeMake(messageLabelSize.width + offset *2, messageLabelSize.height + offset*2);
    if (newSize.width < 80) {
        newSize.width = 80;
    }
    return newSize;
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
- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
    [self sizeToFit];
    [self invalidateIntrinsicContentSize];
}

- (NSString *)message {
    return self.messageLabel.text;
}

static UIColor *c_backgroundColor = nil;
static UIColor *c_textColor = nil;

+ (UIColor *)backgroundColor {
    if (!c_backgroundColor) {
        if (@available(iOS 13, *)) {
            c_backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor colorWithRed:33/255.0f green:33/255.0f blue:33/255.0f alpha:1];
                } else {
                    return [UIColor colorWithWhite:0 alpha:0.8];
                }
            }];
        } else {
            c_backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        }
    }
    return c_backgroundColor;
}

+ (void)setBackgroundColor:(UIColor *)backgroundColor {
    c_backgroundColor = backgroundColor;
}

+ (UIColor *)textColor {
    if (!c_textColor) {
        c_textColor = [UIColor whiteColor];
    }
    return c_textColor;
}

+ (void)setTextColor:(UIColor *)textColor {
    c_textColor = textColor;
}

@end
