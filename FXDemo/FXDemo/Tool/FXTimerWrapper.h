//
//  FXTimerWrapper.h
//  FXDemo
//
//  Created by Felix on 2020/8/6.
//  Copyright © 2020 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXTimerWrapper : NSObject

- (instancetype)fxInitWithTimerInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

/// 手动关闭计时器
- (void)fxInvalidate;

@end

NS_ASSUME_NONNULL_END
