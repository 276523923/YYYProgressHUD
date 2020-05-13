//
//  YYYTextHUDView.h
//  TestProject
//
//  Created by yyy on 2018/7/20.
//  Copyright © 2018年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYYTextHUDView : UIView

@property (class, nonatomic, strong) UIColor *backgroundColor;
@property (class, nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UILabel *messageLabel;
- (NSTimeInterval)displayDurationForString:(NSString *)string;

@end
NS_ASSUME_NONNULL_END
