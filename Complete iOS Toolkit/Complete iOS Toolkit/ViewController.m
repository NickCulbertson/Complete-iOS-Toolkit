//
//  ViewController.m
//  Complete iOS Toolkit
//
//  Created by Nick Culbertson on 4/10/15.
//  Copyright (c) 2015 Nick Culbertson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    DarkImageView.alpha=0;
    MenuItems=0;
    ContentArray = [[NSMutableArray alloc] initWithObjects:nil];
    WebView.delegate = self;
    [WebView addSubview:ActivityIndicator];
    WebView.scalesPageToFit = YES;
    
    
//    //Blue
//    StatusBar.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:180.0f/255.0f blue:240.0f/255.0f alpha:1];
//    HeaderContainer.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:180.0f/255.0f blue:240.0f/255.0f alpha:1];
//    HeaderShadow.backgroundColor = [UIColor colorWithRed:20.0f/255.0f green:135.0f/255.0f blue:190.0f/255.0f alpha:1];
//
//    //Red
//    StatusBar.backgroundColor = [UIColor colorWithRed:233.0f/255.0f green:72.0f/255.0f blue:72.0f/255.0f alpha:1.0];
//    HeaderContainer.backgroundColor = [UIColor colorWithRed:233.0f/255.0f green:72.0f/255.0f blue:72.0f/255.0f alpha:1.0];
//    HeaderShadow.backgroundColor = [UIColor colorWithRed:190.0f/255.0f green:22.0f/255.0f blue:22.0f/255.0f alpha:1.0];
//    
//    //Light Blue
//    StatusBar.backgroundColor = [UIColor colorWithRed:112.0f/255.0f green:215.0f/255.0f blue:224.0f/255.0f alpha:1.0];
//    HeaderContainer.backgroundColor = [UIColor colorWithRed:112.0f/255.0f green:215.0f/255.0f blue:224.0f/255.0f alpha:1.0];
//    HeaderShadow.backgroundColor = [UIColor colorWithRed:100.0f/255.0f green:185.0f/255.0f blue:210.0f/255.0f alpha:1.0];
//    
//    //Light Gray
//    StatusBar.backgroundColor = [UIColor colorWithRed:233.0f/255.0f green:233.0f/255.0f blue:233.0f/255.0f alpha:1.0];
//    HeaderContainer.backgroundColor = [UIColor colorWithRed:233.0f/255.0f green:233.0f/255.0f blue:233.0f/255.0f alpha:1.0];
//    HeaderShadow.backgroundColor = [UIColor colorWithRed:190.0f/255.0f green:190.0f/255.0f blue:190.0f/255.0f alpha:1.0];
//    
//    //Gray
//    StatusBar.backgroundColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0];
//    HeaderContainer.backgroundColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0];
//    HeaderShadow.backgroundColor = [UIColor colorWithRed:70.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1.0];
    
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"local" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    
    
    NSLog(@"%@",filePath);
    
    [self performSelectorOnMainThread:@selector(fetchedDataLocal:) withObject:data waitUntilDone:YES];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
        
        MenuItems = 4;
        
        NSString* HeaderColorString = [SettingsArray[0] objectForKey:@"HeaderColor"];
        NSString* HeaderLabelString = [SettingsArray[1] objectForKey:@"HeaderLabel"];
        
        NSString* MenuItemsString;
        for (int i=0; i <= MenuItems; i++) {
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
            
            float r;
            float g;
            float b;
            float rShadow;
            float gShadow;
            float bShadow;
            
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
                r=231;
                g=76;
                b=60;
                rShadow=192;
                gShadow=57;
                bShadow=43;
            }else if([HeaderColorString isEqualToString:@"8"]){
                //Light Blue
                r=236;
                g=240;
                b=241;
                rShadow=189;
                gShadow=195;
                bShadow=199;
            }else if([HeaderColorString isEqualToString:@"9"]){
                //Light Blue
                r=149;
                g=165;
                b=166;
                rShadow=127;
                gShadow=140;
                bShadow=141;
            }
            StatusBar.backgroundColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
            HeaderContainer.backgroundColor = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
            HeaderShadow.backgroundColor = [UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0];
            WebViewControls.translucent=NO;
            WebViewControls.barTintColor=[UIColor colorWithRed:rShadow/255.0f green:gShadow/255.0f blue:bShadow/255.0f alpha:1.0];
        }
    }
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return [contentArray count];
    return MenuItems;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
    
    cell.textLabel.text = [ContentArray objectAtIndex:indexPath.row];
    return cell;
    
    
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        
        return @"MENU";
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* MenuItemString;
    NSString* HeaderLabelString;
    
    for (int i=0; i <= MenuItems; i++) {
        if(indexPath.row == i){
            MenuItemString = [MenuArray[i] objectForKey:@"MenuURL"];
            HeaderLabelString = [MenuArray[i] objectForKey:@"MenuLabel"];
        }
    }
//    if(indexPath.row == 0){
//        
//
//    }else if(indexPath.row == 1){
//        MenuItemString = [SettingsArray[12] objectForKey:@"MenuURL2"];
//        HeaderLabelString = [SettingsArray[9] objectForKey:@"MenuLabel2"];
//
//    }else if(indexPath.row == 2){
//        MenuItemString = [SettingsArray[13] objectForKey:@"MenuURL3"];
//        HeaderLabelString = [SettingsArray[10] objectForKey:@"MenuLabel3"];
//        
//    }else if(indexPath.row == 3){
//        MenuItemString = [SettingsArray[14] objectForKey:@"MenuURL3"];
//        HeaderLabelString = [SettingsArray[10] objectForKey:@"MenuLabel3"];
//        
//    }else if(indexPath.row == 4){
//        MenuItemString = [SettingsArray[15] objectForKey:@"MenuURL3"];
//        HeaderLabelString = [SettingsArray[10] objectForKey:@"MenuLabel3"];
//       
//    }else if(indexPath.row == 5){
//        
//    }else if(indexPath.row == 6){
//       
//    }else if(indexPath.row == 7){
//        
//    }else if(indexPath.row == 8){
//       
//    }else if(indexPath.row == 9){
//        
//    }else if(indexPath.row == 10){
//        
//    }
    WebView.alpha=0;
    [WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];

    [WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:MenuItemString]]];
    HeaderLabel.text=HeaderLabelString;

    WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width,WebViewContainer.center.y);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelay:0];
    [UIView setAnimationRepeatCount:0];
    WebView.alpha=1;
    MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
    WebViewContainer.center=CGPointMake([[UIScreen mainScreen] bounds].size.width/2,WebViewContainer.center.y);
    DarkImageView.alpha=0;
    [UIView commitAnimations];
    MenuShow=false;
    
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
    
        MenuTable.center=CGPointMake([MenuTable bounds].size.width/2,MenuTable.center.y);
        DarkImageView.alpha=.5;
        [UIView commitAnimations];
        MenuShow=true;
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationDelay:0];
        [UIView setAnimationRepeatCount:0];
        
        MenuTable.center=CGPointMake(-[MenuTable bounds].size.width/2,MenuTable.center.y);
        DarkImageView.alpha=0;
        [UIView commitAnimations];
        MenuShow=false;
    }
    
}

- (IBAction)DetailsAction {
    
}
@end
