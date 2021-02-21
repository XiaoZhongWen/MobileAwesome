//
//  DarkerCommander.h
//  Command
//
//  Created by 肖仲文 on 2018/6/23.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Receiver.h"
#import "CommandProtocol.h"

@interface DarkerCommander : NSObject <CommandProtocol>

- (instancetype)initWithReceiver:(Receiver *)receiver parameter:(float)param;

@end
