//
//  BusinessCardAdapterProtocol.h
//  Adapter
//
//  Created by mye on 2019/3/12.
//  Copyright © 2019 mye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BusinessCardAdapterProtocol <NSObject>

- (NSString *)name;

- (UIColor *)lineColor;

- (NSString *)phoneNumber;

@end
