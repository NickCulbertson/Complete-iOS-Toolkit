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
- (void) alerttest{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"AppName"
                                  message:@"Would you like to receive occasional notifications about new content, reminders & updates?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* Button1 = [UIAlertAction
                         actionWithTitle:@"Not Now"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* Button2 = [UIAlertAction
                          actionWithTitle:@"OK"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          {
                              
                              
                              [alert dismissViewControllerAnimated:YES completion:nil];
                              
                          }];
    
    [alert addAction:Button1];
    [alert addAction:Button2];
    
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

-(void)AllowNotificationsAlert{
    
    NSArray *versionArray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    NSLog(@"%d",[[versionArray objectAtIndex:0]intValue]);
    if ([[versionArray objectAtIndex:0] intValue] >= 8) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Nature Soundscapes: Notifications"
                                      message:@"Would you like to receive occasional notifications about new sounds, reminders & updates?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Not Now"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //   [[UIApplication sharedApplication]  openURL:url2];
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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nature Soundscapes: Notifications"
                                                        message:@"Would you like to receive occasional notifications about new sounds, reminders & updates?"
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

@end
