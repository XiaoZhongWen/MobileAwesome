//
//  Builder.h
//  Builder
//
//  Created by 肖仲文 on 2018/6/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractEngine.h"
#import "AbstractWheel.h"
#import "AbstractDoor.h"
#import "BuilderProtocol.h"

// 各个部件都遵守各自的协议并且都遵守BuilderProtocol协议

// 装配者
@interface Builder : NSObject
// 引擎部件
@property (nonatomic, strong) id<AbstractEngine, BuilderProtocol> engine;
// 车门部件
@property (nonatomic, strong) id<AbstractDoor, BuilderProtocol> door;
// 轮胎部件
@property (nonatomic, strong) id<AbstractWheel, BuilderProtocol> wheel;

// 产品
@property (nonatomic, strong) NSDictionary *productInfo;

// 组装产品
- (void)buildAllParts;

@end
