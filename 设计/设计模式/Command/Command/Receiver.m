//
//  Receiver.m
//  Command
//
//  Created by 肖仲文 on 2018/6/23.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "Receiver.h"

@interface Receiver()
{
    CGFloat hue_;
    CGFloat saturation_;
    CGFloat brightness_;
    CGFloat alpha_;
}
@end

@implementation Receiver

- (void)setClientView:(UIView *)clientView {
    _clientView = clientView;
    UIColor *backgroundColor = clientView.backgroundColor;
    [backgroundColor getHue:&hue_
                 saturation:&saturation_
                 brightness:&brightness_
                      alpha:&alpha_];
}

- (void)addDarkness:(float)num {
    brightness_ -= num;
    UIColor *backgroundColor = [UIColor colorWithHue:hue_
                                          saturation:saturation_
                                          brightness:brightness_
                                               alpha:alpha_];
    [self.clientView setBackgroundColor:backgroundColor];
}

- (void)addLightness:(float)num {
    brightness_ += num;
    UIColor *backgroundColor = [UIColor colorWithHue:hue_
                                          saturation:saturation_
                                          brightness:brightness_
                                               alpha:alpha_];
    [self.clientView setBackgroundColor:backgroundColor];
}

@end
