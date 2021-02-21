//
//  Wheel.h
//  Builder
//
//  Created by 肖仲文 on 2018/6/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractWheel.h"
#import "BuilderProtocol.h"

@interface Wheel : NSObject <AbstractWheel, BuilderProtocol>

@end
