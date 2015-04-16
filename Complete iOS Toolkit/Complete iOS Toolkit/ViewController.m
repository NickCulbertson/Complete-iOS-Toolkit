//
//  ViewController.m
//  Complete iOS Toolkit
//
//  Created by Nick Culbertson on 4/10/15.
//  Copyright (c) 2015 Nick Culbertson. All rights reserved.
//

#import "ViewController.h"
#import "iRate.h"
#import "PushController.h"
#import "IAPHelper.h"
#import "AppUserDefaults.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {

    // Setting Up The App UI
    HomeShow=true;
    LogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    AppQuote.contentMode = UIViewContentModeScaleAspectFit;
    WebViewImageView.alpha=0;
    DarkImageView.alpha=0;
    MenuItems=0;
    ContentArray = [[NSMutableArray alloc] initWithObjects:nil];
    WebView.delegate = self;
    [WebView addSubview:ActivityIndicator];
    WebView.scalesPageToFit = YES;
    
    
    // Checking the device iOS version running
    NSArray *versionArray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    NSLog(@"%d",[[versionArray objectAtIndex:0]intValue]);
    if ([[versionArray objectAtIndex:0] intValue] >= 8) {
        PreiOS8=false;
    }else{
        PreiOS8=true;
    }
    
    
    // Getting "local.json" settings
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"local" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSLog(@"%@",filePath);
    [self performSelectorOnMainThread:@selector(fetchedDataLocal:) withObject:data waitUntilDone:YES];
    
    
    // Tracking Orientation Changes
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark UI Button methods

- (IBAction)MenuAction {
    if (!MenuShow) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationDelay:0];
        [UIView setAnimationRepeatCount:0];
        WebViewImageView.alpha=.7;

        WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width,WebViewContainer.center.y);
        
        MenuTable.center=CGPointMake([MenuTable bounds].size.width/2,MenuTable.center.y);
        DarkImageView.alpha=.5;
        [UIView commitAnimations];
        MenuShow=true;
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationDelay:0];
        [UIView setAnimationRepeatCount:0];
        WebViewImageView.alpha=0;
        if(!HomeShow){

            WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
        }else{
            
            WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width+[[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
        }
        MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
        DarkImageView.alpha=0;
        [UIView commitAnimations];
        MenuShow=false;
    }
}

- (IBAction)DetailsAction {
    
    [self ShowAlert];
    
}

#pragma mark Device Orientation methods


-(BOOL)shouldAutorotate{
    if(!PreiOS8){
        return YES;
    }else{
       return NO;
    }
}


- (void)orientationChanged:(NSNotification *)notification
{
    // Tracking Orientation Changes
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    NSLog(@"change orientation");
    if (UIDeviceOrientationIsLandscape(deviceOrientation)){
        if(AdState!=2){
            NSLog(@"Landscape Ad");
            AdState=2;
            [self ShowLandscape];
        }
        
    }else if (UIDeviceOrientationIsPortrait(deviceOrientation)){
        if(AdState!=1){
            NSLog(@"Portrait Ad");
            AdState=1;
            [self ShowPortrait];
        }
    }else{
        // Device is facing up or facing down
    }
    
    
}

-(void)ShowPortrait{
    
    if(AdsEnabled&&![[IAPHelper sharedInstance]getIAP1]){
        WebView.frame = CGRectMake(0, 0, [WebViewContainer bounds].size.width, [WebViewContainer bounds].size.height-[WebViewControls bounds].size.height-CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height);
    
        bannerView_.frame = CGRectMake(0,[WebViewContainer bounds].size.height-[WebViewControls bounds].size.height-CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height,
                                       CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).width,
                                       CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height);
    }else{
        WebView.frame = CGRectMake(0, 0, [WebViewContainer bounds].size.width, [WebViewContainer bounds].size.height-[WebViewControls bounds].size.height);
    }
}

-(void)ShowLandscape{
    
    if(AdsEnabled&&![[IAPHelper sharedInstance]getIAP1]){
        WebView.frame = CGRectMake(0, 0, [WebViewContainer bounds].size.width, [WebViewContainer bounds].size.height-[WebViewControls bounds].size.height-CGSizeFromGADAdSize(kGADAdSizeSmartBannerLandscape).height);
    
        if(!PreiOS8){
        bannerView_.frame = CGRectMake(0,[WebViewContainer bounds].size.height-[WebViewControls bounds].size.height-CGSizeFromGADAdSize(kGADAdSizeSmartBannerLandscape).height,
                                       CGSizeFromGADAdSize(kGADAdSizeSmartBannerLandscape).width,
                                       CGSizeFromGADAdSize(kGADAdSizeSmartBannerLandscape).height);
        }
    }else{
        WebView.frame = CGRectMake(0, 0, [WebViewContainer bounds].size.width, [WebViewContainer bounds].size.height-[WebViewControls bounds].size.height);
    }
}

#pragma mark Admob methods

-(void)CreateAd{
        
    CGPoint origin = CGPointMake(0.0,
                                 [WebViewContainer bounds].size.height -
                                 [WebViewControls bounds].size.height -
                                 CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height);
    
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:origin];
    
    // Specify the ad unit ID.
    bannerView_.adUnitID = [SettingsArray[0] objectForKey:@"AdmobAdID"];
    
    //DECLARE VALUE LOCALLY (WITHOUT JSON) LIKE THIS:
    //bannerView_.adUnitID = @"YOUR_AD_ID";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [WebViewContainer addSubview:bannerView_];
    
    //APPLY AD TO THE MAIN VIEW WITH:
    //[self addSubview:bannerView_];
    
    [bannerView_ setDelegate:self];
    
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
}


#pragma mark Local JSON methods


- (void)fetchedDataLocal:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    
    if(responseData==nil){
        
        NSLog(@"JSON Can't Find Data");
        
        //[self Here];
        
    }else{
        NSLog(@"JSON Get");
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                             options:kNilOptions
                                                               error:&error];
        
        
        SettingsArray = [json objectForKey:@"AppSettings"]; //2
        MenuArray = [json objectForKey:@"MenuItems"];
        AlertArray = [json objectForKey:@"AlertItems"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:SettingsArray forKey:@"SettingsArray"];
        [defaults setValue:MenuArray forKey:@"MenuArray"];
        [defaults setValue:AlertArray forKey:@"AlertArray"];
        [defaults synchronize];
        
        [defaults setValue:[SettingsArray[3] objectForKey:@"PushMessage"] forKey:@"PushMessage"];
        [defaults setValue:[SettingsArray[3] objectForKey:@"DaysUntilPush"] forKey:@"DaysUntilPush"];
        [defaults synchronize];

        
        SettingsArray = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"SettingsArray"]];
        MenuArray = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"MenuArray"]];
        AlertArray = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"AlertArray"]];
        
        
        AppNameString = [SettingsArray[0] objectForKey:@"AppName"];
        NSString* HeaderColorString = [SettingsArray[0] objectForKey:@"HeaderColor"];
        NSString* HeaderLabelString = [SettingsArray[0] objectForKey:@"HeaderLabel"];
        NSString* TagLineString = [SettingsArray[0] objectForKey:@"TagLine"];
        NSString* MenuItemsInt = [SettingsArray[0] objectForKey:@"MenuItems"];
        NSString* AdEnabledString = [SettingsArray[0] objectForKey:@"AdmobAdEnabled"];;
        AlertMessageString = [SettingsArray[2] objectForKey:@"AlertMessage"];
        NSString* MenuItemsString;
        
        // Check for Ad
        if ([AdEnabledString isEqualToString:@"true"]&&![[IAPHelper sharedInstance]getIAP1]){
            AdsEnabled=true;
        }else{
            AdsEnabled=false;
        }
        
        if ([[IAPHelper sharedInstance]getIAP1]||!AdsEnabled) {
            //No Ads
        }else{
            //Ads
            [self CreateAd];
            
        }
        
        if(AdState==1){
            [self ShowPortrait];
        }else{
            [self ShowLandscape];
        }
        
        MenuItems = [MenuItemsInt intValue];
        
        AppQuote.text = TagLineString;
        
        for (int i=0; i < MenuItems; i++) {
            MenuItemsString = [MenuArray[i] objectForKey:@"MenuTitle"];
            [ContentArray addObject:MenuItemsString];
        }

        [MenuTable reloadData];
        
        if(SettingsArray==NULL){
            
            
            
            NSLog(@"JSON Object Not There");
            
            
           // [self Here];
        }else{
            MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
            
            HeaderLabel.text=HeaderLabelString;
            
            
            if([HeaderColorString isEqualToString:@"1"]){
                //Red
                r=26;
                g=188;
                b=156;
                rShadow=22;
                gShadow=160;
                bShadow=133;
            }else if([HeaderColorString isEqualToString:@"2"]){
                //Light Blue
                r=46;
                g=204;
                b=113;
                rShadow=39;
                gShadow=174;
                bShadow=96;
            }else if([HeaderColorString isEqualToString:@"3"]){
                //Light Blue
                r=52;
                g=152;
                b=219;
                rShadow=41;
                gShadow=128;
                bShadow=185;
            }else if([HeaderColorString isEqualToString:@"4"]){
                //Light Blue
                r=155;
                g=89;
                b=182;
                rShadow=142;
                gShadow=68;
                bShadow=173;
            }else if([HeaderColorString isEqualToString:@"5"]){
                //Light Blue
                r=52;
                g=73;
                b=94;
                rShadow=44;
                gShadow=62;
                bShadow=80;
            }else if([HeaderColorString isEqualToString:@"6"]){
                //Light Blue
                r=241;
                g=196;
                b=15;
                rShadow=243;
                gShadow=156;
                bShadow=18;
            }else if([HeaderColorString isEqualToString:@"7"]){
                //Light Blue
                r=230;
                g=126;
                b=34;
                rShadow=211;
                gShadow=84;
                bShadow=0;
            }else if([HeaderColorString isEqualToString:@"8"]){
                //Light Blue
                r=231;
                g=76;
                b=60;
                rShadow=192;
                gShadow=57;
                bShadow=43;
            }else if([HeaderColorString isEqualToString:@"9"]){
                //Light Blue
                r=149;
                g=165;
                b=166;
                rShadow=127;
                gShadow=140;
                bShadow=141;
            }else if([HeaderColorString isEqualToString:@"10"]){
                NSString* CustomColorRString = [SettingsArray[1] objectForKey:@"CustomColorR"];
                NSString* CustomColorGString = [SettingsArray[1] objectForKey:@"CustomColorG"];

                NSString* CustomColorBString = [SettingsArray[1] objectForKey:@"CustomColorB"];

                NSString* CustomColorRShadowString = [SettingsArray[1] objectForKey:@"CustomColorRShadow"];

                NSString* CustomColorGShadowString = [SettingsArray[1] objectForKey:@"CustomColorGShadow"];

                NSString* CustomColorBShadowString = [SettingsArray[1] objectForKey:@"CustomColorBShadow"];

                r=[CustomColorRString intValue];
                g=[CustomColorGString intValue];
                b=[CustomColorBString intValue];
                rShadow=[CustomColorRShadowString intValue];
                gShadow=[CustomColorGShadowString intValue];
                bShadow=[CustomColorBShadowString intValue];
            }
            StatusBar.backgroundColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
            HeaderContainer.backgroundColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
            HeaderShadow.backgroundColor = [UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0];
            WebViewImageView.backgroundColor = [UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0];
            [WebView setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:243/255.0f alpha:1.0]];
            WebViewControls.translucent=NO;
            WebViewControls.barTintColor=[UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0];
            
            
            //TEST REMOTE JSON
            //[self GetRemoteJSON];
        }
    }
}


#pragma mark Alert methods
-(void)ShowAlert{
    AlertSelected=1;
if (!PreiOS8) {
    // iOS 8 & newer logic
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:[SettingsArray[2] objectForKey:@"AlertTitle"]
                                  message:[SettingsArray[2] objectForKey:@"AlertMessage"]
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i=0; i < [[SettingsArray[2] objectForKey:@"AlertItems"] intValue]; i++) {
        NSString * ButtonName = [AlertArray[i] objectForKey:@"AlertButton"];
        NSString * ButtonURL = [AlertArray[i] objectForKey:@"AlertURL"];
        UIAlertAction* i = [UIAlertAction
                             actionWithTitle:ButtonName
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 if([ButtonURL isEqualToString:@"home"]){
                                     HomeShow=true;
                                     [WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
                                     
                                     HeaderLabel.text=AppNameString;
                                     
                                     //WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width,WebViewContainer.center.y);
                                     
                                     [UIView beginAnimations:nil context:NULL];
                                     [UIView setAnimationDuration:.5];
                                     [UIView setAnimationDelay:0];
                                     [UIView setAnimationRepeatCount:0];
                                     WebViewImageView.alpha=0;
                                     WebView.alpha=0;
                                     MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
                                     WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width+[[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
                                     DarkImageView.alpha=0;
                                     [UIView commitAnimations];
                                     MenuShow=false;
                                     
                                 }else if([ButtonURL isEqualToString:@"iap"]){
                                     [self ShowIAPAlert];
                                 }else if([ButtonURL isEqualToString:@"notification"]){
                                     [[PushController sharedInstance] AllowNotificationsAlert];
                                 }else if([ButtonURL isEqualToString:@"rate"]){
                                     [[iRate sharedInstance] openRatingsPageInAppStore];
                                 }else if([ButtonURL isEqualToString:@"cancel"]){

                                 }else{
                                     HomeShow=false;
                                     WebView.alpha=0;
                                     
                                     [WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ButtonURL]]];
                                     HeaderLabel.text=ButtonName;
                                     
                                     //WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width,WebViewContainer.center.y);
                                     
                                     [UIView beginAnimations:nil context:NULL];
                                     [UIView setAnimationDuration:.5];
                                     [UIView setAnimationDelay:0];
                                     [UIView setAnimationRepeatCount:0];
                                     WebViewImageView.alpha=0;
                                     WebView.alpha=1;
                                     MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
                                     WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
                                     DarkImageView.alpha=0;
                                     [UIView commitAnimations];
                                     MenuShow=false;
                                     
                                 }
                                 [alert dismissViewControllerAnimated:YES completion:nil];

                                 
                                 
                             }];
        [alert addAction:i];

    }
    [self presentViewController:alert animated:YES completion:nil];
   
} else {
    // iOS 7 logic
    
    NSMutableArray *ButtonArray = [[NSMutableArray alloc] init];
    int ButtonCount = [[SettingsArray[2] objectForKey:@"AlertItems"] intValue];
    for (int i=0; i < ButtonCount; i++) {
        NSString * ButtonName = [AlertArray[i] objectForKey:@"AlertButton"];
       // NSString * ButtonURL = [AlertArray[i] objectForKey:@"AlertURL"];
        [ButtonArray addObject:ButtonName];
        //ButtonURL = [ButtonArray objectAtIndex:0];
     
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[SettingsArray[2] objectForKey:@"AlertTitle"]
                                                    message:[SettingsArray[2] objectForKey:@"AlertMessage"]
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    
    
    for (int i=0; i < ButtonCount; i++) {

    [alert addButtonWithTitle: ButtonArray[i]];
        
    }
    
    
    //[alert setCancelButtonIndex: [buttonTitles count] - 1];
    

        [alert show];

    
}
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //iOS 7
    if(AlertSelected==1){
    for (int i=0; i < [[SettingsArray[2] objectForKey:@"AlertItems"] intValue]; i++) {
        if (buttonIndex == i){
            NSString * ButtonURL = [AlertArray[i] objectForKey:@"AlertURL"];
            NSString * ButtonName = [AlertArray[i] objectForKey:@"AlertButton"];
            if([ButtonURL isEqualToString:@"home"]){
                HomeShow=true;
                [WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
                
                HeaderLabel.text=AppNameString;
                
                //WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width,WebViewContainer.center.y);
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:.5];
                [UIView setAnimationDelay:0];
                [UIView setAnimationRepeatCount:0];
                WebViewImageView.alpha=0;
                WebView.alpha=0;
                MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
                WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width+[[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
                DarkImageView.alpha=0;
                [UIView commitAnimations];
                MenuShow=false;
                
            }else if([ButtonURL isEqualToString:@"alert"]){
                [self ShowAlert];
            }else if([ButtonURL isEqualToString:@"iap"]){
                [self ShowIAPAlert];
            }else if([ButtonURL isEqualToString:@"notification"]){
                [[PushController sharedInstance] AllowNotificationsAlert];
            }else if([ButtonURL isEqualToString:@"rate"]){
                [[iRate sharedInstance] openRatingsPageInAppStore];
            }else if([ButtonURL isEqualToString:@"cancel"]){
                
            }else{
                HomeShow=false;
                WebView.alpha=0;
                
                [WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ButtonURL]]];
                HeaderLabel.text=ButtonName;
                
                //WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width,WebViewContainer.center.y);
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:.5];
                [UIView setAnimationDelay:0];
                [UIView setAnimationRepeatCount:0];
                WebViewImageView.alpha=0;
                WebView.alpha=1;
                MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
                WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
                DarkImageView.alpha=0;
                [UIView commitAnimations];
                MenuShow=false;
                
            }
        }
        
    }
    }else if(AlertSelected==2){
        if (buttonIndex == 0){
            [[IAPHelper sharedInstance] purchaseIAP1];
        }else if(buttonIndex == 1){
            [[IAPHelper sharedInstance] restore];
        }else if(buttonIndex == 3){
            
        }
        
    }
    
}


#pragma mark TableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return MenuItems;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    // Set up the cell...
    
    cell.textLabel.text = [ContentArray objectAtIndex:indexPath.row];

    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
        
    cell.textLabel.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    cell.textLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    cell.textLabel.layer.shadowRadius = 3.0;
    cell.textLabel.layer.shadowOpacity = 0.5;

    [tableView setSeparatorColor:[UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0]];
    
    
    cell.backgroundColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
    
    
    //cell.textLabel.backgroundColor = [UIColor clearColor];
    //cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    
    return cell;
    
    
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if(section == 0){
//        return @"MENU";
//    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* MenuItemString;
    NSString* HeaderLabelString;
    
    for (int i=0; i < MenuItems; i++) {
        
        if(indexPath.row == i){
            MenuItemString = [MenuArray[i] objectForKey:@"MenuURL"];
            HeaderLabelString = [MenuArray[i] objectForKey:@"MenuLabel"];
            
            if([MenuItemString isEqualToString:@"home"]){
                HomeShow=true;
                [WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
                
                HeaderLabel.text=HeaderLabelString;
                
                WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width,WebViewContainer.center.y);
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:.5];
                [UIView setAnimationDelay:0];
                [UIView setAnimationRepeatCount:0];
                WebViewImageView.alpha=0;
                WebView.alpha=0;
                MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
                WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width+[[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
                DarkImageView.alpha=0;
                [UIView commitAnimations];
                MenuShow=false;
                
            }else if([MenuItemString isEqualToString:@"iap"]){
                [self ShowIAPAlert];
            }else if([MenuItemString isEqualToString:@"notification"]){
                [[PushController sharedInstance] AllowNotificationsAlert];
            }else if([MenuItemString isEqualToString:@"rate"]){
                [[iRate sharedInstance] openRatingsPageInAppStore];
            }else{
            HomeShow=false;
            WebView.alpha=0;
            
            [WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:MenuItemString]]];
            HeaderLabel.text=HeaderLabelString;
            
            WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width,WebViewContainer.center.y);
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.5];
            [UIView setAnimationDelay:0];
            [UIView setAnimationRepeatCount:0];
            WebViewImageView.alpha=0;
            WebView.alpha=1;
            MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
            WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
            DarkImageView.alpha=0;
            [UIView commitAnimations];
            MenuShow=false;
            
            }
        }
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark In App Purchase methods

-(void)ShowIAPAlert{
    AlertSelected=2;
    if (!PreiOS8) {
        // iOS 8 logic
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:AppNameString
                                      message:@"Remove Ads"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Purchase 'Remove Ads'"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [[IAPHelper sharedInstance] purchaseIAP1];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        UIAlertAction* ok2 = [UIAlertAction
                              actionWithTitle:@"Restore"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [[IAPHelper sharedInstance] restore];
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        UIAlertAction* cancel2 = [UIAlertAction
                                  actionWithTitle:@"Thanks! Maybe Later"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }];
        
        [alert addAction:ok];
        [alert addAction:ok2];
        [alert addAction:cancel2];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        // iOS 7 logic
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AppNameString
                                                        message:@"Remove Ads"
                                                       delegate:self
                                              cancelButtonTitle:@"Thanks! Maybe Later"
                                              otherButtonTitles:@"Purchase 'Remove Ads'", @"Restore",nil];
        
        [alert show];
    }
}

- (void) PurchasedIAP1{
    //Enter methods for IAP1 purchase
    
    [[IAPHelper sharedInstance]setIAP1:YES];
    AdsEnabled=false;
    
    [bannerView_ removeFromSuperview];
    
    if(AdState==1){
        [self ShowPortrait];
    }else{
        [self ShowLandscape];
    }
    
}
//Add These for additional IAP
//- (void) PurchasedIAP2{}



#pragma mark Remote JSON methods

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kjsonURL [NSURL URLWithString: @"http://madcalfapps.blob.core.windows.net/freevideogame/remote.json"]

-(void)GetRemoteJSON{
    //Once Per Day
    //    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //    format.dateFormat = @"dd-MM-yyyy";
    //    NSDate *myDate = [NSDate date];
    //    NSString *theDate = [format stringFromDate:myDate];
    //    NSLog(@"%@",theDate);
    //
    //    [[NSUserDefaults standardUserDefaults] setValue:theDate forKey:@"fieldKey3"];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    //    NSString *theDate2 = [[NSUserDefaults standardUserDefaults]
    //                          stringForKey:@"fieldKey2"];
    //
    //
    //
    //    if([theDate isEqualToString:theDate2]){
    //        NSLog(@"No Need For JSON");
    //    }else{
    NSLog(@"I Need JSON");
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: kjsonURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    //    }
    
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    
    
    
    if(responseData==nil){
        
        NSLog(@"JSON Can't Find Data");
        
        //   [self Here];
        
    }else{
        NSLog(@"JSON Get");
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                             options:kNilOptions
                                                               error:&error];
        
        
        SettingsArray = [json objectForKey:@"AppSettings"]; //2
        MenuArray = [json objectForKey:@"MenuItems"];
        AlertArray = [json objectForKey:@"AlertItems"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:SettingsArray forKey:@"SettingsArray"];
        [defaults setValue:MenuArray forKey:@"MenuArray"];
        [defaults setValue:AlertArray forKey:@"AlertArray"];
        [defaults synchronize];
        
        [defaults setValue:[SettingsArray[3] objectForKey:@"PushMessage"] forKey:@"PushMessage"];
        [defaults setValue:[SettingsArray[3] objectForKey:@"DaysUntilPush"] forKey:@"DaysUntilPush"];
        [defaults synchronize];
        
        if(SettingsArray==NULL){
            
            NSLog(@"JSON Object Not There");
            
        }else{
            NSLog(@"JSON Refresh View");
            
            [self RefreshView];
            
        }
    }
}

- (void) RefreshView{
    //Enter methods for IAP1 purchase
    
    NSLog(@"JSON Refresh View 2");
    
    SettingsArray = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"SettingsArray"]];
    MenuArray = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"MenuArray"]];
    AlertArray = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"AlertArray"]];
    
    
    AppNameString = [SettingsArray[0] objectForKey:@"AppName"];
    NSString* HeaderColorString = [SettingsArray[0] objectForKey:@"HeaderColor"];
    NSString* HeaderLabelString = [SettingsArray[0] objectForKey:@"HeaderLabel"];
    NSString* TagLineString = [SettingsArray[0] objectForKey:@"TagLine"];
    NSString* MenuItemsInt = [SettingsArray[0] objectForKey:@"MenuItems"];
    NSString* AdEnabledString = [SettingsArray[0] objectForKey:@"AdmobAdEnabled"];;
    AlertMessageString = [SettingsArray[2] objectForKey:@"AlertMessage"];
    NSString* MenuItemsString;
    
    // Check for Ad
    if ([AdEnabledString isEqualToString:@"true"]&&![[IAPHelper sharedInstance]getIAP1]){
        AdsEnabled=true;
    }else{
        AdsEnabled=false;
    }
    
    if ([[IAPHelper sharedInstance]getIAP1]||!AdsEnabled) {
        //No Ads
    }else{
        //Ads
      //  [self CreateAd];
        
    }
    
    if(AdState==1){
        [self ShowPortrait];
    }else{
        [self ShowLandscape];
    }
    
    MenuItems = [MenuItemsInt intValue];
    
    AppQuote.text = TagLineString;
    
    for (int i=0; i < MenuItems; i++) {
        MenuItemsString = [MenuArray[i] objectForKey:@"MenuTitle"];
        [ContentArray addObject:MenuItemsString];
    }
    
    [MenuTable reloadData];
    
    if(SettingsArray==NULL){
        
        
        
        NSLog(@"JSON Object Not There");
        
        
        // [self Here];
    }else{
        
        NSLog(@"JSON Object There");
        
        MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
        
        HeaderLabel.text=HeaderLabelString;
        
        
        if([HeaderColorString isEqualToString:@"1"]){
            //Red
            r=26;
            g=188;
            b=156;
            rShadow=22;
            gShadow=160;
            bShadow=133;
        }else if([HeaderColorString isEqualToString:@"2"]){
            //Light Blue
            r=46;
            g=204;
            b=113;
            rShadow=39;
            gShadow=174;
            bShadow=96;
        }else if([HeaderColorString isEqualToString:@"3"]){
            //Light Blue
            r=52;
            g=152;
            b=219;
            rShadow=41;
            gShadow=128;
            bShadow=185;
        }else if([HeaderColorString isEqualToString:@"4"]){
            //Light Blue
            r=155;
            g=89;
            b=182;
            rShadow=142;
            gShadow=68;
            bShadow=173;
        }else if([HeaderColorString isEqualToString:@"5"]){
            //Light Blue
            r=52;
            g=73;
            b=94;
            rShadow=44;
            gShadow=62;
            bShadow=80;
        }else if([HeaderColorString isEqualToString:@"6"]){
            //Light Blue
            r=241;
            g=196;
            b=15;
            rShadow=243;
            gShadow=156;
            bShadow=18;
        }else if([HeaderColorString isEqualToString:@"7"]){
            //Light Blue
            r=230;
            g=126;
            b=34;
            rShadow=211;
            gShadow=84;
            bShadow=0;
        }else if([HeaderColorString isEqualToString:@"8"]){
            //Light Blue
            r=231;
            g=76;
            b=60;
            rShadow=192;
            gShadow=57;
            bShadow=43;
        }else if([HeaderColorString isEqualToString:@"9"]){
            //Light Blue
            r=149;
            g=165;
            b=166;
            rShadow=127;
            gShadow=140;
            bShadow=141;
        }else if([HeaderColorString isEqualToString:@"10"]){
            NSString* CustomColorRString = [SettingsArray[1] objectForKey:@"CustomColorR"];
            NSString* CustomColorGString = [SettingsArray[1] objectForKey:@"CustomColorG"];
            
            NSString* CustomColorBString = [SettingsArray[1] objectForKey:@"CustomColorB"];
            
            NSString* CustomColorRShadowString = [SettingsArray[1] objectForKey:@"CustomColorRShadow"];
            
            NSString* CustomColorGShadowString = [SettingsArray[1] objectForKey:@"CustomColorGShadow"];
            
            NSString* CustomColorBShadowString = [SettingsArray[1] objectForKey:@"CustomColorBShadow"];
            
            r=[CustomColorRString intValue];
            g=[CustomColorGString intValue];
            b=[CustomColorBString intValue];
            rShadow=[CustomColorRShadowString intValue];
            gShadow=[CustomColorGShadowString intValue];
            bShadow=[CustomColorBShadowString intValue];
        }
        StatusBar.backgroundColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
        HeaderContainer.backgroundColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
        HeaderShadow.backgroundColor = [UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0];
        WebViewImageView.backgroundColor = [UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0];
        [WebView setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:243/255.0f alpha:1.0]];
        WebViewControls.translucent=NO;
        WebViewControls.barTintColor=[UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0];
    }
    
    
}


@end
