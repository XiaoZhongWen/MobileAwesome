//
//  Receiver.h
//  Command
//
//  Created by 肖仲文 on 2018/6/23.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Receiver : NSObject

@property (nonatomic, weak) UIView *clientView;

- (void)addDarkness:(float)num;

- (void)addLightness:(float)num;

@end
