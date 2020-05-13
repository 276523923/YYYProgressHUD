//
//  YYYWeakProxy.h
//  YYYWeakProxy
//
//  Created by yyy on 2018/6/7.
//  Copyright © 2018年 yyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYYWeakProxy : NSProxy

@property (nullable, nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end
