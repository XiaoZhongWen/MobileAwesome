//
//  Invoker.m
//  Command
//
//  Created by 肖仲文 on 2018/6/23.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "Invoker.h"
#import <UIKit/UIKit.h>

@interface Invoker()

@property (nonatomic, strong) NSMutableArray *queue;

@end


@implementation Invoker

+ (instancetype)shareInstance {
    static Invoker *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[Invoker alloc] init];
    });
    return shareInstance;
}

- (void)rollback {
    [self.queue removeLastObject];
    if (self.queue.lastObject) {
        id <CommandProtocol> command = self.queue.lastObject;
        [command excute];
    }
}

- (void)addAndExcute:(id <CommandProtocol>)command {
    NSParameterAssert(command);
    
    [self.queue addObject:command];
    [command excute];
}

- (NSMutableArray *)queue {
    if (!_queue) {
        _queue = [NSMutableArray array];
    }
    return _queue;
}

@end
