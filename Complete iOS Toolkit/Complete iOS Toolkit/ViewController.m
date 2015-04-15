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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

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
    
    NSArray *versionArray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    NSLog(@"%d",[[versionArray objectAtIndex:0]intValue]);
    if ([[versionArray objectAtIndex:0] intValue] >= 8) {
        PreiOS8=false;
    }else{
        PreiOS8=true;
    }
    
    
    AdsEnabled=true;
    
    if ([[IAPHelper sharedInstance]getIAP1]||!AdsEnabled) {
        //No Ads
    }else{
        //Ads
        [self CreateAd];
    
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"local" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    
    
    NSLog(@"%@",filePath);
    
    [self performSelectorOnMainThread:@selector(fetchedDataLocal:) withObject:data waitUntilDone:YES];
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)orientationChanged:(NSNotification *)notification
{
    NSLog(@"change orientation");
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
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
        
    }
    
    
}

-(void)ShowPortrait{
    
        NSLog(@"Portrait Ad YES");
    
    if(AdsEnabled){
    WebView.frame = CGRectMake(0, 0, [WebViewContainer bounds].size.width, [WebViewContainer bounds].size.height-[WebViewControls bounds].size.height-CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height);
    
        bannerView_.frame = CGRectMake(0,[WebViewContainer bounds].size.height-[WebViewControls bounds].size.height-CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height,
                                       CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).width,
                                       CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height);
    }else{
        WebView.frame = CGRectMake(0, 0, [WebViewContainer bounds].size.width, [WebViewContainer bounds].size.height-[WebViewControls bounds].size.height);
        
    }
    
    
}
-(void)ShowLandscape{
  
     NSLog(@"Landscape Ad YES");
    
    if(AdsEnabled){
    WebView.frame = CGRectMake(0, 0, [WebViewContainer bounds].size.width, [WebViewContainer bounds].size.height-[WebViewControls bounds].size.height-CGSizeFromGADAdSize(kGADAdSizeSmartBannerLandscape).height);
    
    
        bannerView_.frame = CGRectMake(0,[WebViewContainer bounds].size.height-[WebViewControls bounds].size.height-CGSizeFromGADAdSize(kGADAdSizeSmartBannerLandscape).height,
                                       CGSizeFromGADAdSize(kGADAdSizeSmartBannerLandscape).width,
                                       CGSizeFromGADAdSize(kGADAdSizeSmartBannerLandscape).height);
    }else{
        WebView.frame = CGRectMake(0, 0, [WebViewContainer bounds].size.width, [WebViewContainer bounds].size.height-[WebViewControls bounds].size.height);
        
        
    }
    
}

-(void)CreateAd{
    CGPoint origin = CGPointMake(0.0,
                                 [WebViewContainer bounds].size.height -
                                 [WebViewControls bounds].size.height -
                                 CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height);
    
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:origin];
    
    // Specify the ad unit ID.
    bannerView_.adUnitID = @"ca-app-pub-0325717490228488/1458343033";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [WebViewContainer addSubview:bannerView_];
    [bannerView_ setDelegate:self];
    
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
}


- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notification{
    
    
}
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
        
        
        AppNameString = [SettingsArray[0] objectForKey:@"AppName"];
        NSString* HeaderColorString = [SettingsArray[0] objectForKey:@"HeaderColor"];
        NSString* HeaderLabelString = [SettingsArray[0] objectForKey:@"HeaderLabel"];
        NSString* TagLineString = [SettingsArray[0] objectForKey:@"TagLine"];
        NSString* MenuItemsInt = [SettingsArray[0] objectForKey:@"MenuItems"];
        AlertMessageString = [SettingsArray[2] objectForKey:@"AlertMessage"];
        NSString* MenuItemsString;
        
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
        }
    }
}

#pragma mark TableView methods
-(void)AllowAlert{
    
    if (!PreiOS8) {
        
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
        
        
        [self presentViewController:alert animated:YES completion:nil];
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
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:@"4" forKey:@"Launchtime4"];
//    [[NSUserDefaults standardUserDefaults] synchronize];

    
    if (!PreiOS8) {
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

-(void)ShowAlert{
if (!PreiOS8) {
    // iOS 8 logic
    
//    NSURL *url2 = [NSURL URLWithString:@"http://itunes.apple.com/app/id961640913?at=10lun6"];//?mt=8
//    NSURL *url3 = [NSURL URLWithString:@"https://itunes.apple.com/artist/id409029298?at=10lun6"];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:AppNameString
                                  message:AlertMessageString
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Enable Notifications"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [[PushController sharedInstance] AllowNotificationsAlert];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* ok2 = [UIAlertAction
                          actionWithTitle:@"Rate App"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          {
                              [[iRate sharedInstance] openRatingsPageInAppStore];
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
                                                    message:@"I'm an Indie Dev.\nI'm just one guy, not a company.\nIf you are enjoying the app, please leave a good review. I rely on your reviews to do what I do!"
                                                   delegate:self
                                          cancelButtonTitle:@"Thanks! Maybe Later"
                                          otherButtonTitles:@"Review Tiny Drums", @"More Apps",nil];
    
    [alert show];
}
}

-(void)ShowIAPAlert{
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //iOS 7 Only
    NSURL *url2 = [NSURL URLWithString:@"http://itunes.apple.com/app/id961640913?at=10lun6"];//?mt=8
    NSURL *url3 = [NSURL URLWithString:@"http://madcalfapps.blogspot.com/2013/02/top-40-radio.html"];
    
    if (buttonIndex == 2){
        [[UIApplication sharedApplication]  openURL:url3];
        NSLog(@"Remove button clicked");
    }
    if (buttonIndex == 1){
        [[UIApplication sharedApplication]  openURL:url2];
        NSLog(@"Remove button clicked");
    }
    
    if (buttonIndex == 0){
        
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
                
            }else if([MenuItemString isEqualToString:@"alert"]){
                [self ShowAlert];
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
    
    //[[PushController sharedInstance] AllowNotificationsAlert];

    //[[iRate sharedInstance] promptForRating];
    
    [self ShowAlert];
   
}

- (void) PurchasedIAP1{
    //Enter methods for IAP1 purchase
    
    AdsEnabled=false;
    [bannerView_ removeFromSuperview];
    
    if(AdState==1){
        [self ShowPortrait];
    }else{
        [self ShowLandscape];
    }
    
}
//Add These for additional IAPs
//- (void) PurchasedIAP2{}
//- (void) PurchasedIAP3{}
//- (void) PurchasedIAP4{}
//- (void) PurchasedIAP5{}
//- (void) PurchasedIAP6{}
//- (void) PurchasedIAP7{}
//- (void) PurchasedIAP8{}
//- (void) PurchasedIAP9{}
//- (void) PurchasedIAP10{}

@end
