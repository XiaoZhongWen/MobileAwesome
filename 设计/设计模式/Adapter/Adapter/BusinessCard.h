//
//  BusinessCard.h
//  Adapter
//
//  Created by mye on 2019/3/12.
//  Copyright © 2019 mye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessCardAdapterProtocol.h"

@interface BusinessCard : UIView

- (void)loadData:(id<BusinessCardAdapterProtocol>)data;

@end
