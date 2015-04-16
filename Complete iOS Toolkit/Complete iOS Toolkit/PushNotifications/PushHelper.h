//
//  ViewController.h
//  Complete iOS Toolkit
//
//  Created by Nick Culbertson on 4/10/15.
//  Copyright (c) 2015 Nick Culbertson. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PushHelper : NSObject
+ (PushHelper*) sharedInstance;

-(void)CreatePush;
-(void)AllowNotificationsAlert;
-(void)AllowNotifications;
-(void)RemovePush;
-(BOOL)getEnabled;
-(void)setEnabled:(BOOL)PushEnabled;

@end

