# iOS设计模式 - 策略

## 原理图
![](/Users/mye/Downloads/Work/XiaoZhongWen/Design Pattern/Strategy/Strategy.png)

## 说明
* 把解决相同问题的算法抽象成策略(相同问题指的是输入参数相同,但根据算法不同输出参数会有差异).
* 策略被封装在对象之中(是对象内容的一部分),策略改变的是对象的内容.
* 策略模式可以简化复杂的判断逻辑(if - else).

## 代码实现
人的出行旅游方式有很多种, 即拥有不同的出行策略, 通过选择不同的策略来实现不同的出行方式而不用关心具体的策略实现方式

抽象的策略类

```
//
//  TravelStrategy.h
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TravelStrategy : NSObject

/**
 出行方式
 */
- (void)travelAlgorithm;

@end

NS_ASSUME_NONNULL_END

//
//  TravelStrategy.m
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "TravelStrategy.h"

@implementation TravelStrategy

- (void)travelAlgorithm {
    
}

@end


```

具体的策略

```
//
//  AirPlanelStrategy.h
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "TravelStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@interface AirPlanelStrategy : TravelStrategy

@end

NS_ASSUME_NONNULL_END

//
//  AirPlanelStrategy.m
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "AirPlanelStrategy.h"

@implementation AirPlanelStrategy

- (void)travelAlgorithm {
    NSLog(@"travelbyAirPlain");
}

@end

```

```
//
//  TrainStrategy.h
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "TravelStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainStrategy : TravelStrategy

@end

NS_ASSUME_NONNULL_END

//
//  TrainStrategy.m
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "TrainStrategy.h"

@implementation TrainStrategy

- (void)travelAlgorithm {
    NSLog(@"travelbyTrain");
}

@end

```

```
//
//  BicycleStrategy.h
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "TravelStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@interface BicycleStrategy : TravelStrategy

@end

NS_ASSUME_NONNULL_END

//
//  BicycleStrategy.m
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "BicycleStrategy.h"

@implementation BicycleStrategy

- (void)travelAlgorithm {
    NSLog(@"travelbyBicycle");
}

@end

```

人持有策略对象

```
//
//  Person.h
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) TravelStrategy *travelStrategy;

@end

NS_ASSUME_NONNULL_END

```

通过选择不同的策略来实现不同的出行方式而不用关心具体的策略实现方式

```
//
//  ViewController.m
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "ViewController.h"
#import "TravelStrategy.h"
#import "AirPlanelStrategy.h"
#import "TrainStrategy.h"
#import "BicycleStrategy.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TravelStrategy *travelStrategy = [[AirPlanelStrategy alloc] init];
    Person *p = [[Person alloc] init];
    
    // 1. 坐飞机旅行
    p.travelStrategy = travelStrategy;
    [p.travelStrategy travelAlgorithm];
    
    // 2. 坐火车旅行
    travelStrategy = [[TrainStrategy alloc] init];
    p.travelStrategy = travelStrategy;
    [p.travelStrategy travelAlgorithm];
    
    // 3. 骑自行车旅行
    travelStrategy = [[BicycleStrategy alloc] init];
    p.travelStrategy = travelStrategy;
    [p.travelStrategy travelAlgorithm];
}


@end

```