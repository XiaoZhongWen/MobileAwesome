//
//  MatrixTurnLeftCommand.m
//  Command2
//
//  Created by 肖仲文 on 2018/6/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "MatrixTurnLeftCommand.h"

@interface MatrixTurnLeftCommand()

@property (nonatomic, strong) Matrix *matrix;

@end

@implementation MatrixTurnLeftCommand

- (instancetype)initWithMatrix:(Matrix *)matrix {
    self = [super init];
    if (self) {
        _matrix = matrix;
    }
    return self;
}

- (void)execute {
    [self.matrix turnLeft];
}

- (void)rollback {
    // to do
}

@end
