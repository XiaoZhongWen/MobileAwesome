//
//  DarkerCommander.m
//  Command
//
//  Created by 肖仲文 on 2018/6/23.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "DarkerCommander.h"

@interface DarkerCommander()

@property (nonatomic, weak) Receiver *receiver;
@property (nonatomic, assign) float param;

@end

@implementation DarkerCommander

- (instancetype)initWithReceiver:(Receiver *)receiver parameter:(float)param {
    self = [super init];
    if (self) {
        self.receiver = receiver;
        self.param = param;
    }
    return self;
}

- (void)excute {
    [self.receiver addDarkness:self.param];
}

@end
