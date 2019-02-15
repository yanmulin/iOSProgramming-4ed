//
//  AppDelegate.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRTableViewController.h"
#import "BNRItemStore.h"

NSString * const BNRNextItemValuePrefsKey = @"NextItemValue";
NSString * const BNRNextItemNamePrefsKey = @"NextItemName";

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenRect];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Override point for customization after application launch.
    
    if (!self.window.rootViewController) {
        BNRTableViewController *tvc = [[BNRTableViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tvc];
        navController.restorationIdentifier = NSStringFromClass([UINavigationController class]);
        
        self.window.rootViewController = navController;
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [[BNRItemStore sharedObject] saveChanges];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

-(BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}

-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}

-(UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    UINavigationController *nc = [[UINavigationController alloc] init];
    
    nc.restorationIdentifier = [identifierComponents lastObject];
    if ([identifierComponents count] == 1)
        self.window.rootViewController = nc;
    
    return nc;
}

+(void)initialize {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *factorySettings = @{
                                      BNRNextItemValuePrefsKey:@75,
                                      BNRNextItemNamePrefsKey:@"Coffee Cup",
                                      };
    [defaults registerDefaults:factorySettings];
}

@end
