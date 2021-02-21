//
//  Matrix.h
//  Command2
//
//  Created by 肖仲文 on 2018/6/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Matrix : NSObject

// 命令响应者的具体行为

/**
 向左转
 */
- (void)turnLeft;

/**
 向右转
 */
- (void)turnRight;

/**
 变形
 */
- (void)turnTransform;

@end
