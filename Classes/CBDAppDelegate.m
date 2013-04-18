//
//  CBDAppDelegate.m
//  CBD_book
//
//  Created by Federico Frappi on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CBDAppDelegate.h"
#import "registerViewController.h"
#import "CBDViewController.h"


@implementation CBDAppDelegate

@synthesize window, detailViewController,regViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after app launch.
//    detailViewController = [[CBDViewController alloc]initWithNibName:@"CBDViewController" bundle:nil];
//    self.window.rootViewController = self.detailViewController;
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        NSLog(@"第一次启动");
        registerViewController *regViewController = [[registerViewController alloc] init];
        self.window.rootViewController = regViewController;
    }
    else{
        NSLog(@"已经不是第一次启动了");
        detailViewController = [[CBDViewController alloc]initWithNibName:@"CBDViewController" bundle:nil];
        self.window.rootViewController = self.detailViewController;

    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end

