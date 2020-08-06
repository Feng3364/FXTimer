//
//  FXTimerWrapper.m
//  FXDemo
//
//  Created by Felix on 2020/8/6.
//  Copyright © 2020 Felix. All rights reserved.
//

#import "FXTimerWrapper.h"
#import <objc/message.h>

@interface FXTimerWrapper()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL aSelector;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation FXTimerWrapper

- (instancetype)fxInitWithTimerInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    if (self == [super init]) {
        self.target = aTarget;
        self.aSelector = aSelector;

        if ([self.target respondsToSelector:self.aSelector]) {
            Method method = class_getInstanceMethod([self.target class], aSelector);
            const char *type = method_getTypeEncoding(method);
            class_addMethod([self class], aSelector, (IMP)fireWapper, type);
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:aSelector userInfo:userInfo repeats:yesOrNo];
        }
    }
    return self;
}

void fireWapper(FXTimerWrapper *wrapper) {
    if (wrapper.target) {
        void (*fx_msgSend)(void *,SEL, id) = (void *)objc_msgSend;
        fx_msgSend((__bridge void *)(wrapper.target), wrapper.aSelector, wrapper.timer);
    } else {
        [wrapper.timer invalidate];
        wrapper.timer = nil;
    }
}

- (void)fxInvalidate {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
