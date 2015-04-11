//
//  ViewController.h
//  Complete iOS Toolkit
//
//  Created by Nick Culbertson on 4/10/15.
//  Copyright (c) 2015 Nick Culbertson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UIWebViewDelegate>{
    
    IBOutlet UIImageView *StatusBar;
    IBOutlet UIImageView *HeaderShadow;
    IBOutlet UIScrollView *HeaderContainer;
    IBOutlet UILabel *HeaderLabel;
    IBOutlet UITableView *MenuTable;
    IBOutlet UIScrollView *WebViewContainer;
    
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
    NSMutableArray *ContentArray;
    
    int MenuItems;
}
- (IBAction)MenuAction;
- (IBAction)DetailsAction;

@end

