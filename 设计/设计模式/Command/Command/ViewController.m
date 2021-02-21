//
//  ViewController.m
//  Command
//
//  Created by 肖仲文 on 2018/6/23.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import "ViewController.h"
#import "Receiver.h"
#import "DarkerCommander.h"
#import "LighterCommander.h"
#import "Invoker.h"

@interface ViewController ()

@property (nonatomic, strong) Receiver *receiver;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Receiver *receive = [[Receiver alloc] init];
    [receive setClientView:self.view];
    self.receiver = receive;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DarkerCommander *commander = [[DarkerCommander alloc] initWithReceiver:self.receiver parameter:0.1];
    [[Invoker shareInstance] addAndExcute:commander];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
