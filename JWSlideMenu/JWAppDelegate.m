//
//  JWAppDelegate.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/14/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import "JWAppDelegate.h"
#import "JWSlideMenuController.h"
#import "JWNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation JWAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    JWSlideMenuViewController *f = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil];
    JWSlideMenuViewController *s = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    JWSlideMenuViewController *t = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil];
        
    JWSlideMenuController *slideMenu = [[[JWSlideMenuController alloc] init] autorelease];
    
    UIImage *starMenuImage = [UIImage imageNamed:@"star 20x20"];
    
    [slideMenu addViewController:f withTitle:@"First" andImage:starMenuImage];
    [slideMenu addViewController:s withTitle:@"Second" andImage:starMenuImage];
    [slideMenu addViewController:t withTitle:@"Second" andImage:starMenuImage];
    
    self.window.rootViewController = slideMenu;
    
    [f release];
    [s release];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
