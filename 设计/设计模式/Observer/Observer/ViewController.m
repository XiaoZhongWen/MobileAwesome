//
//  ViewController.m
//  Observer
//
//  Created by mye on 2019/3/4.
//  Copyright © 2019 mye. All rights reserved.
//

#import "ViewController.h"
#import "SubscriptionProtocol.h"
#import "SubscriptionServerCenter.h"

@interface ViewController () <SubscriptionProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SubscriptionServerCenter *center = [[SubscriptionServerCenter alloc] init];
    [center createSubscriptionNumber:@"COMPUTER"];
    [center addCustomer:self withSubscriptionNumber:@"COMPUTER"];
    [center sendMessage:@"apple" toSubscriptionNumber:@"COMPUTER"];
}

- (void)subscriptionMessage:(id)message subscriptionNumber:(NSString *)subscriptionNumber {
    NSLog(@"message: %@, subscriptionNumber: %@", message, subscriptionNumber);
}

@end
