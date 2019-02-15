//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by 颜木林 on 2019/1/28.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRReminderViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Time";
        UIImage *tabBarIcon = [UIImage imageNamed:@"Time@2x"];
        self.tabBarItem.image = tabBarIcon;
    }
    return self;
}

-(void)viewDidLoad
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!error) {
                                  NSLog(@"request authorization succeeded!");
//                                  [self showAlert];
                              }
                          }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

-(IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"selected date: %@", date);
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"HypnoNerd";
    content.body = @"Hypnosize me";
//    content.badge = [NSNumber numberWithInteger:([UIApplication sharedApplication].applicationIconBadgeNumber + 1)];
    
    NSCalendar *defaultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *dateComponents = [defaultCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay| NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
//    dateComponents.second = 0;
    
//    NSLog(@"date components: %@", dateComponents);
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:NO];
    
    NSUUID *uuid = [UIDevice currentDevice].identifierForVendor;
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:uuid.UUIDString content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"add NotificationRequest succeeded!");
        }
    }];
}
@end
