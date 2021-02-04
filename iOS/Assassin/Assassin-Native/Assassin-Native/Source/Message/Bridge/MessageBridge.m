//
//  MessageBridge.m
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/2/4.
//  Copyright © 2021 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(MessageDataProvider, NSObject)

RCT_EXTERN_METHOD(fetchMessageList:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
