//
//  main.m
//  Gojito
//
//  Created by 肖仲文 on 2021/3/12.
//

#import <UIKit/UIKit.h>
#import <GJTApplicationModule/GJTAppLauncherDelegate.h>

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([GJTAppLauncherDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
