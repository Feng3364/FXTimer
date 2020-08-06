//
//  TimerViewController.m
//  FXDemo
//
//  Created by Felix on 2020/8/6.
//  Copyright © 2020 Felix. All rights reserved.
//

#import "TimerViewController.h"
#import "PushViewController.h"
#import <objc/runtime.h>
#import "FXTimerWrapper.h"
#import "FXProxy.h"

static int num = 0;

@interface TimerViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) id target;
@property (nonatomic, strong) FXTimerWrapper *timerWrapper;
@property (nonatomic, strong) FXProxy *proxy;

@property (nonatomic, copy) NSString *gcdIdentity;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TimerViewController";
    
//    [self useTimer];
//    [self intermediary];
//    [self wrapper];
//    [self useProxy];
}

- (void)timerFire {
    num++;
    NSLog(@"current - %d",num);
}

#pragma mark - timer
//- (void)useTimer {
//    __weak typeof(self) weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(timerFire) userInfo:nil repeats:YES];
//}

#pragma mark - 方案一
//- (void)didMoveToParentViewController:(UIViewController *)parent {
//    if (parent == nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}

#pragma mark - 方案二
- (void)intermediary {
    self.target = [[NSObject alloc] init];
    class_addMethod([NSObject class], @selector(timerFire), (IMP)fireFunc, "v@:");
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.target selector:@selector(timerFire) userInfo:nil repeats:YES];
}

void fireFunc() {
    num++;
    NSLog(@"current - %d",num);
}

#pragma mark - 方案三
- (void)wrapper {
    self.timerWrapper = [[FXTimerWrapper alloc] fxInitWithTimerInterval:1 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
}

#pragma mark - 方案四
- (void)useProxy {
    self.proxy = [FXProxy proxyWithTransformObject:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(timerFire) userInfo:nil repeats:YES];
}

#pragma mark - dealloc
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - push
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[PushViewController new] animated:YES];
}

@end
