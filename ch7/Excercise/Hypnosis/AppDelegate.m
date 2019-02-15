//
//  AppDelegate.m
//  Hypnosis
//
//  Created by 阿文 on 2019/1/24.
//  Copyright © 2019 awen. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRHypnosisView.h"

@interface AppDelegate ()

@property (nonatomic, weak) BNRHypnosisView *hypnosisView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    [self.window makeKeyAndVisible];


    
//    BNRHypnosisView *secondView = [[BNRHypnosisView alloc] initWithFrame:CGRectMake(20, 40, 30, 30)];
//    secondView.backgroundColor = [UIColor blueColor];
//    [self.window addSubview:firstView];
    
//    CGRect bigRect = bounds;
//    bigRect.size.width *= 2;
//    bigRect.size.height *= 2;
//
//    BNRHypnosisView *firstView = [[BNRHypnosisView alloc] initWithFrame:bigRect];
//    //    [self.window addSubview:firstView];
//
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:bigRect];
//    [scrollView addSubview:firstView];
//    scrollView.contentSize = bigRect.size;
//
//    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [[UIViewController alloc] init];
//
//    self.window.rootViewController.view = scrollView;
    
    CGRect screenRect = bounds;
    CGRect bigRect = bounds;
    bigRect.size.width *= 2;
    bigRect.size.height *= 2;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    BNRHypnosisView *firstView = [[BNRHypnosisView alloc] initWithFrame:bigRect];
//    screenRect.origin.x += screenRect.size.width;
//    BNRHypnosisView *secondView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:firstView];
//    [scrollView addSubview:secondView];
    scrollView.contentSize = bigRect.size;
//    scrollView.pagingEnabled = YES;
//    scrollView.pagingEnabled = NO;
    scrollView.bouncesZoom = YES;
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 10.0;
    scrollView.zoomScale = 1.0;
    scrollView.delegate = self;
    firstView.center = scrollView.center;
    
    
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.rootViewController.view = scrollView;
    
    self.hypnosisView = firstView;
    
    NSLog(@"Did finish Launching.");
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    NSLog(@"Will begin zooming.");
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"Did zoom.");
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"Did end zooming.");
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    NSLog(@"view for zooming");
    return self.hypnosisView;
}


@end
