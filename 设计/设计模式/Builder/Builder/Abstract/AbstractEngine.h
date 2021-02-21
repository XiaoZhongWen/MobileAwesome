//
//  AbstractEngine.h
//  Builder
//
//  Created by 肖仲文 on 2018/6/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AbstractEngine <NSObject>

@required
- (void)engineWithScale:(CGFloat)scale;
- (void)engineWithWight:(CGFloat)kg;
- (NSString *)engineInfomation;

@end
