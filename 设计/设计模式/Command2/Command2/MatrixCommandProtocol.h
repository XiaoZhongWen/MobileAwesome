//
//  MatrixCommandProtocol.h
//  Command2
//
//  Created by 肖仲文 on 2018/6/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MatrixCommandProtocol <NSObject>

@required

/**
 执行命令
 */
- (void)execute;

/**
 命令撤回
 */
- (void)rollback;

@end
