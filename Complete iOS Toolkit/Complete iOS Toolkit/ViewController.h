//
//  ViewController.h
//  Complete iOS Toolkit
//
//  Created by Nick Culbertson on 4/10/15.
//  Copyright (c) 2015 Nick Culbertson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    IBOutlet UIImageView *StatusBar;
    IBOutlet UIImageView *HeaderShadow;
    IBOutlet UIScrollView *HeaderContainer;
    IBOutlet UILabel *HeaderLabel;
    
    IBOutlet UIButton *MenuButton;
    IBOutlet UIButton *DetailsButton;
    
    IBOutlet UIImageView *LogoImageView;
    IBOutlet UIImageView *BackgroundImageView;
    
    NSArray *SettingsArray;
}
- (IBAction)MenuAction;
- (IBAction)DetailsAction;

@end

