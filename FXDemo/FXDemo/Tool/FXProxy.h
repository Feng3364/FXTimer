//
//  FXProxy.h
//  FXDemo
//
//  Created by Felix on 2020/8/6.
//  Copyright © 2020 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXProxy : NSProxy

+ (instancetype)proxyWithTransformObject:(id)object;

@end

NS_ASSUME_NONNULL_END
