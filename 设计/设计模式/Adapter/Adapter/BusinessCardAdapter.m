//
//  BusinessCardAdapter.m
//  Adapter
//
//  Created by mye on 2019/3/12.
//  Copyright © 2019 mye. All rights reserved.
//

#import "BusinessCardAdapter.h"
#import <UIKit/UIKit.h>

@implementation BusinessCardAdapter

- (instancetype)initWithData:(id)data {
    
    self = [super init];
    if (self) {
        
        self.data = data;
    }
    
    return self;
}

- (NSString *)name {
    
    return nil;
}

- (UIColor *)lineColor {
    
    return nil;
}

- (NSString *)phoneNumber {
    
    return nil;
}

@end
