//
//  ContactsBridge.m
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/27.
//  Copyright © 2021 肖仲文. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ContactsDataProvider, NSObject)

RCT_EXTERN_METHOD(fetchContactsList:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(fetchUserInfo:(NSString *)userId resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end
