//
//  Door.h
//  Builder
//
//  Created by 肖仲文 on 2018/6/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractDoor.h"
#import "BuilderProtocol.h"

@interface Door : NSObject <AbstractDoor, BuilderProtocol>

@end
