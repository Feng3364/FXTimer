//
//  FXProxy.m
//  FXDemo
//
//  Created by Felix on 2020/8/6.
//  Copyright © 2020 Felix. All rights reserved.
//

#import "FXProxy.h"

@interface FXProxy()
@property (nonatomic, weak) id object;
@end

@implementation FXProxy

+ (instancetype)proxyWithTransformObject:(id)object {
    FXProxy *proxy = [FXProxy alloc];
    proxy.object = object;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.object;
}

@end
