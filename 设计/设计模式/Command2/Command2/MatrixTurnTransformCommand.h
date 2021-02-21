//
//  MatrixTurnTransformCommand.h
//  Command2
//
//  Created by 肖仲文 on 2018/6/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatrixCommandProtocol.h"
#import "Matrix.h"

@interface MatrixTurnTransformCommand : NSObject <MatrixCommandProtocol>

- (instancetype)initWithMatrix:(Matrix *)matrix;

@end
