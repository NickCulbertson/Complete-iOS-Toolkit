//
//  ViewController.h
//  Complete iOS Toolkit
//
//  Created by Nick Culbertson on 4/10/15.
//  Copyright (c) 2015 Nick Culbertson. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PushController : NSObject
+ (PushController*) sharedInstance;

-(void)AllowNotificationsAlert;
-(void)AllowNotifications;

@end

