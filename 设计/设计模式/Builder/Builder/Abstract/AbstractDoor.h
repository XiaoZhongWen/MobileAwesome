//
//  AbstractDoor.h
//  Builder
//
//  Created by 肖仲文 on 2018/6/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AbstractDoor <NSObject>

@required
- (void)doorColor:(UIColor *)color;
- (NSString *)doorInfomation;

@end
