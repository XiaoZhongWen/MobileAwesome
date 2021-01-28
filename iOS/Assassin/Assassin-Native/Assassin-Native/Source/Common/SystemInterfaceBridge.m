//
//  SystemInterfaceBridge.m
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/26.
//  Copyright © 2021 肖仲文. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SystemInterfaceProvider, NSObject)

RCT_EXTERN_METHOD(hideTabBar:(BOOL)isHide)

@end
