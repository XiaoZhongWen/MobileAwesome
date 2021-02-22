# iOS 设计模式 - 观察者

## 原理图
![](/Users/mye/Downloads/Work/XiaoZhongWen/Design Pattern/Observer/Observer.png)

## 说明
* 在定义的一对多的对象间, 使对象间的关系为松耦合
* 当被观察者对象的状态改变时, 所有依赖的观察者对象的update行为会被自动调用
* 被观察者对象能够向所有观察者发送通知

## 代码实现
订阅者对象都遵守的协议

```
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

```

订阅服务中心

```
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

```

```
//
//  SubscriptionServerCenter.m
//  Observer
//
//  Created by mye on 2019/3/4.
//  Copyright © 2019 mye. All rights reserved.
//

#import "SubscriptionServerCenter.h"

static NSMutableDictionary *_subscriptionNumberDictionary = nil;

@implementation SubscriptionServerCenter

+ (void)initialize {
    _subscriptionNumberDictionary = [NSMutableDictionary dictionary];
}

/**
 *  创建订阅号
 *
 *  @param subscriptionNumber 订阅号码
 */
- (void)createSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    NSHashTable *hashTable = _subscriptionNumberDictionary[subscriptionNumber];
    if (hashTable == nil) {
        hashTable = [NSHashTable weakObjectsHashTable];
        [_subscriptionNumberDictionary setObject:hashTable forKey:subscriptionNumber];
    }
}

/**
 *  移除订阅号(参与到该订阅号码的所有客户不会再收到订阅信息)
 *
 *  @param subscriptionNumber 订阅号码
 */
- (void)removeSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    NSHashTable *hashTable = _subscriptionNumberDictionary[subscriptionNumber];
    if (hashTable) {
        [_subscriptionNumberDictionary removeObjectForKey:subscriptionNumber];
    }
}

/**
 *  客户订阅指定的订阅号
 *
 *  @param customer           客户对象
 *  @param subscriptionNumber 订阅号码
 */
- (void)addCustomer:(id<SubscriptionProtocol>)customer
withSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    NSHashTable *hashTable = _subscriptionNumberDictionary[subscriptionNumber];
    if (hashTable && customer) {
        [hashTable addObject:customer];
    }
}

/**
 *  将指定客户从指定订阅号上移除掉
 *
 *  @param customer           客户对象
 *  @param subscriptionNumber 订阅号码
 */
- (void)removeCustomer:(id<SubscriptionProtocol>)customer
fromSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    NSHashTable *hashTable = _subscriptionNumberDictionary[subscriptionNumber];
    if (hashTable && customer) {
        [hashTable removeObject:customer];
    }
}

/**
 *  通知签订了订阅号码的对象
 *
 *  @param message            信息对象
 *  @param subscriptionNumber 订阅号码
 */
- (void)sendMessage:(id)message
toSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    NSHashTable *hashTable = _subscriptionNumberDictionary[subscriptionNumber];
    for (id<SubscriptionProtocol> customer in hashTable) {
        if ([customer respondsToSelector:@selector(subscriptionMessage:subscriptionNumber:)]) {
            [customer subscriptionMessage:message subscriptionNumber:subscriptionNumber];
        }
    }
}

@end

```

* 订阅服务中心添加订阅号

```
SubscriptionServerCenter *center = [[SubscriptionServerCenter alloc] init];
[center createSubscriptionNumber:@"COMPUTER"];
```

* 添加遵守SubscriptionProtocol协议的对象到订阅号对应的订阅者集合

```
[center addCustomer:self withSubscriptionNumber:@"COMPUTER"];
```

* 当订阅服务中心的订阅号收到消息时, 该订阅号对应的所有订阅者的协议方法会被自动调用

```
[center sendMessage:@"apple" toSubscriptionNumber:@"COMPUTER"];
```
