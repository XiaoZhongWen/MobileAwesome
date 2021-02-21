//
//  Invoker.h
//  Command
//
//  Created by 肖仲文 on 2018/6/23.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandProtocol.h"

@interface Invoker : NSObject

+ (instancetype)shareInstance;

- (void)addAndExcute:(id <CommandProtocol>)command;

@end
