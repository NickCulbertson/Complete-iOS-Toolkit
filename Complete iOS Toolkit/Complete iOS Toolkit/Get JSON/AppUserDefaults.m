//
//  AppUserDefaults.m
//  ShurikenTap_Template
//
//  Copyright (c) 2014 Company Name. All rights reserved.
//

#import "AppUserDefaults.h"

@implementation AppUserDefaults
static AppUserDefaults* _sharedAppUserDefaults;

+ (AppUserDefaults*) sharedAppUserDefaults{
    if ( ! _sharedAppUserDefaults )
        _sharedAppUserDefaults = [[AppUserDefaults alloc] init];
    return _sharedAppUserDefaults;
}
- (id)init{
    self = [super init];
    if (self) {
        _sharedAppUserDefaults = self;
    }
    return self;
}


//No Ads
-(BOOL)getNoAds{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults boolForKey:@"NoAds"];
}
-(void)setNoAds:(BOOL)noAds{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:noAds forKey:@"NoAds"];
    [userDefaults synchronize];
}

-(BOOL)getDrums{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults boolForKey:@"Drums"];
}
-(void)setDrums:(BOOL)Drums{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:Drums forKey:@"Drums"];
    [userDefaults synchronize];
}
-(BOOL)getAlliap{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults boolForKey:@"Alliap"];
}
-(void)setAlliap:(BOOL)Alliap{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:Alliap forKey:@"Alliap"];
    [userDefaults synchronize];
}

@end
