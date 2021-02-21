//
//  Builder.m
//  Builder
//
//  Created by 肖仲文 on 2018/6/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "Builder.h"

@implementation Builder

- (void)buildAllParts {
    
    [self.engine build];
    [self.wheel build];
    [self.door build];
    
    NSString *engineInfo = [self.engine engineInfomation];
    NSString *wheelInfo  = [self.wheel wheelInfomation];
    NSString *doorInfo   = [self.door doorInfomation];
    
    NSDictionary *dataInfo = @{
                               @"engine" : engineInfo,
                               @"wheel"  : wheelInfo,
                               @"door"   : doorInfo
                               };
    self.productInfo = dataInfo;
}

@end
