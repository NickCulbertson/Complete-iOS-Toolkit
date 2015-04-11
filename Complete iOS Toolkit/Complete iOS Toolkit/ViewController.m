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
    //NSData* data = [filePath dataUsingEncoding:NSUTF8StringEncoding];
    
    
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
        if(SettingsArray==NULL){
            
            //Red
            StatusBar.backgroundColor = [UIColor colorWithRed:233.0f/255.0f green:72.0f/255.0f blue:72.0f/255.0f alpha:1.0];
            HeaderContainer.backgroundColor = [UIColor colorWithRed:233.0f/255.0f green:72.0f/255.0f blue:72.0f/255.0f alpha:1.0];
            HeaderShadow.backgroundColor = [UIColor colorWithRed:190.0f/255.0f green:22.0f/255.0f blue:22.0f/255.0f alpha:1.0];
            
            NSLog(@"JSON Object Not There");
            
            
           // [self Here];
        }else{
            
            
            
//            contentArray = [[NSArray alloc] initWithObjects:@"BOLLYWOOD RADIO",stations[1],stations[3],stations[5],stations[7],stations[9],stations[11],stations[13],stations[15],stations[17],stations[19],stations[21],stations[23],stations[25],@"",@"BEYOND BOLLY",stations[27],stations[29],stations[31],stations[33],stations[35],stations[37],stations[39],stations[41],@"",@"STATION LINKS",@"",@"MORE RADIO APPS!!!",@"more stations/no ads",@"",@"",@"",@"",@"",@"",@"",nil];
//            
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setValue:stations forKey:@"fieldKey1"];
//            [defaults synchronize];
//            
//            stations = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"fieldKey1"]];
//            
//            contentArray = [[NSArray alloc] initWithObjects:@"BOLLYWOOD RADIO",stations[1],stations[3],stations[5],stations[7],stations[9],stations[11],stations[13],stations[15],stations[17],stations[19],stations[21],stations[23],stations[25],@"",@"BEYOND BOLLY",stations[27],stations[29],stations[31],stations[33],stations[35],stations[37],stations[39],stations[41],@"",@"STATION LINKS",@"",@"MORE RADIO APPS!!!",@"more stations/no ads",@"",@"",@"",@"",@"",@"",@"",nil];
//            
//            if([[stations objectAtIndex:0] isEqual:textField.text]){
//                
//                NSLog(@"New Station");
//            }else{
//                if(Countday==1){
//                    // [self next];
//                }
//                NSLog(@"Up To Date");
//            }
//            [self.table1 reloadData];
//            
//            NSDateFormatter *format = [[NSDateFormatter alloc] init];
//            format.dateFormat = @"dd-MM-yyyy";
//            
//            NSDate *now = [[NSDate alloc] init];
//            
//            NSString *theDate = [format stringFromDate:now];
//            
//            NSLog(@"%@",theDate);
//            
//            
//            NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
//            [defaults2 setValue:theDate forKey:@"fieldKey2"];
//            [defaults2 synchronize];
        }
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MenuAction {
}

- (IBAction)DetailsAction {
}
@end
