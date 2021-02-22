//
//  ViewController.m
//  Strategy
//
//  Created by mye on 2019/3/7.
//  Copyright © 2019 mye. All rights reserved.
//

#import "ViewController.h"
#import "TravelStrategy.h"
#import "AirPlanelStrategy.h"
#import "TrainStrategy.h"
#import "BicycleStrategy.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TravelStrategy *travelStrategy = [[AirPlanelStrategy alloc] init];
    Person *p = [[Person alloc] init];
    
    // 1. 坐飞机旅行
    p.travelStrategy = travelStrategy;
    [p.travelStrategy travelAlgorithm];
    
    // 2. 坐火车旅行
    travelStrategy = [[TrainStrategy alloc] init];
    p.travelStrategy = travelStrategy;
    [p.travelStrategy travelAlgorithm];
    
    // 3. 骑自行车旅行
    travelStrategy = [[BicycleStrategy alloc] init];
    p.travelStrategy = travelStrategy;
    [p.travelStrategy travelAlgorithm];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
