//
//  ViewController.m
//  Complete iOS Toolkit
//
//  Created by Nick Culbertson on 4/10/15.
//  Copyright (c) 2015 Nick Culbertson. All rights reserved.
//

#import "PushController.h"


@implementation PushController
PushController* _sharedAppPush;

+ (PushController*) sharedInstance{
    if ( ! _sharedAppPush )
        _sharedAppPush = [[PushController alloc] init];
    return _sharedAppPush;
}
- (id)init{
    self = [super init];
    if (self) {
        _sharedAppPush = self;
    }
    return self;
}

-(void)CreatePush{

    NSString *PushMessage;
    int Days;

    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"PushMessage"]==NULL){
        PushMessage = @"The app has just been updated. Come check out what all is new.";
        
    }else{
        PushMessage = [[NSUserDefaults standardUserDefaults] objectForKey:@"PushMessage"];
    }
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"DaysUntilPush"]==NULL){
        Days = 10;
        
    }else{
        Days = [[[NSUserDefaults standardUserDefaults] objectForKey:@"DaysUntilPush"] intValue];
    }
    
    // Create new UILocalNotification object.
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // Set the date and time of the notification.
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * Days];
    
    // Set the message body of the notification.
    localNotification.alertBody = PushMessage;
    
    
    // Set the time zone of the notification.
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    // Perform the notification.
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)AllowNotificationsAlert{
    
    NSArray *versionArray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    NSLog(@"%d",[[versionArray objectAtIndex:0]intValue]);
    if ([[versionArray objectAtIndex:0] intValue] >= 8) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Notifications"
                                      message:@"Would you like to receive occasional notifications about new content, reminders & updates?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Not Now"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        UIAlertAction* ok2 = [UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [self AllowNotifications];
                                  
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        
        [alert addAction:ok];
        [alert addAction:ok2];
        
        
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
        NSLog(@"8");
    } else {
        // iOS 7 and below logic
        NSLog(@"7");
        // alarmcount=3;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notifications"
                                                        message:@"Would you like to receive occasional notifications about new content, reminders & updates?"
                                                       delegate:self
                                              cancelButtonTitle:@"Not Now"
                                              otherButtonTitles:@"OK",nil];
        
        [alert show];
    }
}

-(void)AllowNotifications{
    
    NSArray *versionArray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    NSLog(@"%d",[[versionArray objectAtIndex:0]intValue]);
    if ([[versionArray objectAtIndex:0] intValue] >= 8) {
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert |
         UIUserNotificationTypeBadge |
         UIUserNotificationTypeSound
                                          categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeSound];
    }
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notification{
    
    
}

- (void)RemovePush{
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in notificationArray){
        
        // Delete all notifications
        [[UIApplication sharedApplication] cancelLocalNotification:notification] ;
        
        // Delete a specific notification
//        NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
//        for(UILocalNotification *notification in notificationArray){
//            if ([notification.alertBody isEqualToString:@"YourMessageText"]) {
//                // delete this notification
//                [[UIApplication sharedApplication] cancelLocalNotification:notification] ;
//            }
//        }
        
    }
}

-(BOOL)getEnabled{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults boolForKey:@"PushEnabled"];
}
-(void)setEnabled:(BOOL)PushEnabled{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:PushEnabled forKey:@"PushEnabled"];
    [userDefaults synchronize];
}

@end
