//
//  SubscriptionProtocol.h
//  Observer
//
//  Created by mye on 2019/3/4.
//  Copyright © 2019 mye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SubscriptionProtocol <NSObject>
@optional
/**
 *  接收到的订阅信息
 *
 *  @param message            订阅信息
 *  @param subscriptionNumber 订阅编号
 */
- (void)subscriptionMessage:(id)message subscriptionNumber:(NSString *)subscriptionNumber;

@end

NS_ASSUME_NONNULL_END
