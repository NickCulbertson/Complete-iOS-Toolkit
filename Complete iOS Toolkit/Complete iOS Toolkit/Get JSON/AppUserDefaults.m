//
//  AppUserDefaults.m
//  ShurikenTap_Template
//
//  Copyright (c) 2014 Company Name. All rights reserved.
//

#import "AppUserDefaults.h"


@implementation AppUserDefaults
static AppUserDefaults* _sharedInstance;

+ (AppUserDefaults*) sharedInstance{
    if ( ! _sharedInstance )
        _sharedInstance = [[AppUserDefaults alloc] init];
    return _sharedInstance;
}
- (id)init{
    self = [super init];
    if (self) {
        _sharedInstance = self;
    }
    return self;
}

//#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//#define kjsonURL [NSURL URLWithString: @"http://madcalfapps.blob.core.windows.net/freevideogame/remote.json"]
//
//-(void)GetRemoteJSON{
//    //Once Per Day
////    NSDateFormatter *format = [[NSDateFormatter alloc] init];
////    format.dateFormat = @"dd-MM-yyyy";
////    NSDate *myDate = [NSDate date];
////    NSString *theDate = [format stringFromDate:myDate];
////    NSLog(@"%@",theDate);
////    
////    [[NSUserDefaults standardUserDefaults] setValue:theDate forKey:@"fieldKey3"];
////    [[NSUserDefaults standardUserDefaults] synchronize];
////    NSString *theDate2 = [[NSUserDefaults standardUserDefaults]
////                          stringForKey:@"fieldKey2"];
////    
////    
////    
////    if([theDate isEqualToString:theDate2]){
////        NSLog(@"No Need For JSON");
////    }else{
//        NSLog(@"I Need JSON");
//        dispatch_async(kBgQueue, ^{
//            NSData* data = [NSData dataWithContentsOfURL: kjsonURL];
//            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
//        });
////    }
//    
//}
//
//- (void)fetchedData:(NSData *)responseData {
//    //parse out the json data
//    NSError* error;
//    
//    
//    
//    if(responseData==nil){
//        
//        NSLog(@"JSON Can't Find Data");
//        
//     //   [self Here];
//        
//    }else{
//        NSLog(@"JSON Get");
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData //1
//                                                             options:kNilOptions
//                                                               error:&error];
//        
//        
//        NSArray * SettingsArray2 = [json objectForKey:@"AppSettings"]; //2
//        NSArray * MenuArray2 = [json objectForKey:@"MenuItems"];
//        NSArray * AlertArray2 = [json objectForKey:@"AlertItems"];
//        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setValue:SettingsArray2 forKey:@"SettingsArray"];
//        [defaults setValue:MenuArray2 forKey:@"MenuArray"];
//        [defaults setValue:AlertArray2 forKey:@"AlertArray"];
//        [defaults synchronize];
//        
//        [defaults setValue:[SettingsArray2[3] objectForKey:@"PushMessage"] forKey:@"PushMessage"];
//        [defaults setValue:[SettingsArray2[3] objectForKey:@"DaysUntilPush"] forKey:@"DaysUntilPush"];
//        [defaults synchronize];
//        
//        if(SettingsArray2==NULL){
//            
//            NSLog(@"JSON Object Not There");
//            
//        }else{
//            NSLog(@"JSON Refresh View");
//            
//            //Call Refresh on Main View
//                
//        }
//    }
//}

@end
