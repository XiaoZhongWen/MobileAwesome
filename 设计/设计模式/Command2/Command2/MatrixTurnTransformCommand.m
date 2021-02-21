//
//  MatrixTurnTransformCommand.m
//  Command2
//
//  Created by 肖仲文 on 2018/6/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "MatrixTurnTransformCommand.h"

@interface MatrixTurnTransformCommand()

@property (nonatomic, strong) Matrix *matrix;

@end

@implementation MatrixTurnTransformCommand

- (instancetype)initWithMatrix:(Matrix *)matrix {
    self = [super init];
    if (self) {
        _matrix = matrix;
    }
    return self;
}

- (void)execute {
    [self.matrix turnTransform];
}

- (void)rollback {
    // to do
}

@end
