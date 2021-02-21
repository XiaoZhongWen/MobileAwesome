//
//  main.m
//  Command2
//
//  Created by 肖仲文 on 2018/6/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Player *player = [[Player alloc] init];
        [player startGame];
    }
    return 0;
}
