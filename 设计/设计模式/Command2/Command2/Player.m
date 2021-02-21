//
//  Player.m
//  Command2
//
//  Created by 肖仲文 on 2018/6/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "Player.h"
#import "MatrixTurnLeftCommand.h"
#import "MatrixTurnRightCommand.h"
#import "MatrixTurnTransformCommand.h"
#import "Matrix.h"

@implementation Player

- (void)startGame  {
    Matrix *matrix = [[Matrix alloc] init];
    MatrixTurnLeftCommand *leftCommand = [[MatrixTurnLeftCommand alloc] initWithMatrix:matrix];
//    [leftCommand execute];
    MatrixTurnRightCommand *rightCommand = [[MatrixTurnRightCommand alloc] initWithMatrix:matrix];
//    [rightCommand execute];
    MatrixTurnTransformCommand *transformCommand = [[MatrixTurnTransformCommand alloc] initWithMatrix:matrix];
    [transformCommand execute];
}

@end
