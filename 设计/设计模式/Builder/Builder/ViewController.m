//
//  ViewController.m
//  Builder
//
//  Created by 肖仲文 on 2018/6/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "ViewController.h"
#import "Builder.h"
#import "Engine.h"
#import "Wheel.h"
#import "Door.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Builder *builder = [[Builder alloc] init];
    builder.engine = [[Engine alloc] init];
    builder.wheel  = [[Wheel alloc] init];
    builder.door   = [[Door alloc] init];
    
    [builder buildAllParts];
    NSLog(@"%@", builder.productInfo);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
