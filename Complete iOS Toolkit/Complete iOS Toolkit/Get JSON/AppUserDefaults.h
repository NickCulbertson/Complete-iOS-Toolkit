//
//  AppUserDefaults.h
//  ShurikenTap_Template
//
//  Copyright (c) 2014 Company Name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUserDefaults : NSObject
+ (AppUserDefaults*) sharedAppUserDefaults;

//No Ads?
-(BOOL)getNoAds;
-(void)setNoAds:(BOOL)noAds;
-(BOOL)getDrums;
-(void)setDrums:(BOOL)Drums;
-(BOOL)getAlliap;
-(void)setAlliap:(BOOL)Alliap;


@end
