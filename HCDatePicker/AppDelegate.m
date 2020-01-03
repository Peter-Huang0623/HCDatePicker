//
//  AppDelegate.m
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
