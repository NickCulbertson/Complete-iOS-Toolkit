//
//  ViewController.h
//  Complete iOS Toolkit
//
//  Created by Nick Culbertson on 4/10/15.
//  Copyright (c) 2015 Nick Culbertson. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

@interface ViewController : UIViewController<GADBannerViewDelegate,UITableViewDelegate, UIWebViewDelegate>{
    
    GADBannerView *bannerView_;
    
    IBOutlet UILabel *AppQuote;
    IBOutlet UIImageView *StatusBar;
    IBOutlet UIImageView *HeaderShadow;
    IBOutlet UIScrollView *HeaderContainer;
    IBOutlet UILabel *HeaderLabel;
    IBOutlet UITableView *MenuTable;
    IBOutlet UIScrollView *WebViewContainer;
    IBOutlet UIImageView *WebViewImageView;
    IBOutlet UIButton *MenuButton;
    IBOutlet UIButton *DetailsButton;
    
    IBOutlet UIWebView *WebView;
    IBOutlet UIToolbar *WebViewControls;
    IBOutlet UIActivityIndicatorView *ActivityIndicator;
    
    IBOutlet UIImageView *LogoImageView;
    IBOutlet UIImageView *BackgroundImageView;
    IBOutlet UIImageView *DarkImageView;
    BOOL MenuShow;
    NSArray *SettingsArray;
    NSArray *MenuArray;
    NSArray *AlertArray;

    NSMutableArray *ContentArray;
    NSString *AppNameString;
    NSString *AlertMessageString;

    int AlertSelected;
    int AdState;
    int MenuItems;
    BOOL PreiOS8;
    BOOL HomeShow;
    BOOL AdsEnabled;
    float r;
    float g;
    float b;
    float rShadow;
    float gShadow;
    float bShadow;
}

- (IBAction) MenuAction;
- (IBAction) DetailsAction;
- (void) PurchasedIAP1;
//- (void) PurchasedIAP2;

- (void) RefreshView;

@end

