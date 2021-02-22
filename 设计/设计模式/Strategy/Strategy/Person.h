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
