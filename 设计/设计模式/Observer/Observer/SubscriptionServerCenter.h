//
//  SubscriptionServerCenter.h
//  Observer
//
//  Created by mye on 2019/3/4.
//  Copyright © 2019 mye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubscriptionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubscriptionServerCenter : NSObject

/**
 *  创建订阅号
 *
 *  @param subscriptionNumber 订阅号码
 */
- (void)createSubscriptionNumber:(NSString *)subscriptionNumber;

/**
 *  移除订阅号(参与到该订阅号码的所有客户不会再收到订阅信息)
 *
 *  @param subscriptionNumber 订阅号码
 */
- (void)removeSubscriptionNumber:(NSString *)subscriptionNumber;

/**
 *  客户订阅指定的订阅号
 *
 *  @param customer           客户对象
 *  @param subscriptionNumber 订阅号码
 */
- (void)addCustomer:(id<SubscriptionProtocol>)customer
withSubscriptionNumber:(NSString *)subscriptionNumber;

/**
 *  将指定客户从指定订阅号上移除掉
 *
 *  @param customer           客户对象
 *  @param subscriptionNumber 订阅号码
 */
- (void)removeCustomer:(id<SubscriptionProtocol>)customer
fromSubscriptionNumber:(NSString *)subscriptionNumber;

/**
 *  通知签订了订阅号码的对象
 *
 *  @param message            信息对象
 *  @param subscriptionNumber 订阅号码
 */
- (void)sendMessage:(id)message
toSubscriptionNumber:(NSString *)subscriptionNumber;

@end

NS_ASSUME_NONNULL_END
