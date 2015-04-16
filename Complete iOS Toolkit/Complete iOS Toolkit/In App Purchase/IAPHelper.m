//
//  AppUserDefaults.m
//  ShurikenTap_Template
//
//  Copyright (c) 2014 Company Name. All rights reserved.
//

#import "IAPHelper.h"

#define kIAPProductIdentifier1 @"com.MadCalfApps.CompleteiOSToolkit.inapp.IAP1b"
//#define kIAPProductIdentifier2 @"com.CompanyName.AppName.inapp.iap2"
//#define kIAPProductIdentifier3 @"com.CompanyName.AppName.inapp.iap3"
//#define kIAPProductIdentifier4 @"com.CompanyName.AppName.inapp.iap4"
//#define kIAPProductIdentifier5 @"com.CompanyName.AppName.inapp.iap5"
//#define kIAPProductIdentifier6 @"com.CompanyName.AppName.inapp.iap6"
//#define kIAPProductIdentifier7 @"com.CompanyName.AppName.inapp.iap7"
//#define kIAPProductIdentifier8 @"com.CompanyName.AppName.inapp.iap8"
//#define kIAPProductIdentifier9 @"com.CompanyName.AppName.inapp.iap9"
//#define kIAPProductIdentifier10 @"com.CompanyName.AppName.inapp.iap10"

#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@implementation IAPHelper
static IAPHelper* _sharedIAPHelper;

+ (IAPHelper*) sharedInstance{
    if ( ! _sharedIAPHelper )
        _sharedIAPHelper = [[IAPHelper alloc] init];
    return _sharedIAPHelper;
}
- (id)init{
    self = [super init];
    if (self) {
        _sharedIAPHelper = self;
    }
    
    NSArray *versionArray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    NSLog(@"%d",[[versionArray objectAtIndex:0]intValue]);
    if ([[versionArray objectAtIndex:0] intValue] >= 8) {
        if (IS_IPAD()) {
            connectingView = [[UIImageView alloc]initWithFrame:CGRectMake([UIApplication sharedApplication].delegate.window.rootViewController.view.frame.size.width/2-150, [UIApplication sharedApplication].delegate.window.rootViewController.view.frame.size.height/2-60, 300,120)];
        }else{
            connectingView = [[UIImageView alloc]initWithFrame:CGRectMake([UIApplication sharedApplication].delegate.window.rootViewController.view.frame.size.width/2-75, [UIApplication sharedApplication].delegate.window.rootViewController.view.frame.size.height/2-30, 150,60)];
        }
        NSLog(@"8");
    } else {
        // iOS 7 and below logic
        if (IS_IPAD()) {
            connectingView = [[UIImageView alloc]initWithFrame:CGRectMake([UIApplication sharedApplication].delegate.window.rootViewController.view.frame.size.height/2-150, [UIApplication sharedApplication].delegate.window.rootViewController.view.frame.size.width/2-60, 300,120)];
        }else{
            connectingView = [[UIImageView alloc]initWithFrame:CGRectMake([UIApplication sharedApplication].delegate.window.rootViewController.view.frame.size.height/2-75, [UIApplication sharedApplication].delegate.window.rootViewController.view.frame.size.width/2-30, 150,60)];
        }
        
    }
    
    connectingView.image = [UIImage imageNamed:@"connecting"];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:connectingView];
    connectingView.hidden = YES;
    
    return self;
}

//Set & Get In App Purchase State
-(BOOL)getIAP1{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults boolForKey:@"IAP1"];
}
-(void)setIAP1:(BOOL)IAP1{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:IAP1 forKey:@"IAP1"];
    [userDefaults synchronize];
}
//-(BOOL)getIAP2{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP2"];
//}
//-(void)setIAP2:(BOOL)IAP2{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP2 forKey:@"IAP2"];
//    [userDefaults synchronize];
//}
//-(BOOL)getIAP3{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP3"];
//}
//-(void)setIAP3:(BOOL)IAP3{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP3 forKey:@"IAP3"];
//    [userDefaults synchronize];
//}
//-(BOOL)getIAP4{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP4"];
//}
//-(void)setIAP4:(BOOL)IAP4{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP4 forKey:@"IAP4"];
//    [userDefaults synchronize];
//}
//-(BOOL)getIAP5{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP5"];
//}
//-(void)setIAP5:(BOOL)IAP5{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP5 forKey:@"IAP5"];
//    [userDefaults synchronize];
//}
//-(BOOL)getIAP6{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP6"];
//}
//-(void)setIAP6:(BOOL)IAP6{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP6 forKey:@"IAP6"];
//    [userDefaults synchronize];
//}
//-(BOOL)getIAP7{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP7"];
//}
//-(void)setIAP7:(BOOL)IAP7{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP7 forKey:@"IAP7"];
//    [userDefaults synchronize];
//}
//-(BOOL)getIAP8{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP8"];
//}
//-(void)setIAP8:(BOOL)IAP8{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP8 forKey:@"IAP8"];
//    [userDefaults synchronize];
//}
//-(BOOL)getIAP9{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP9"];
//}
//-(void)setIAP9:(BOOL)IAP9{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP9 forKey:@"IAP9"];
//    [userDefaults synchronize];
//}
//-(BOOL)getIAP10{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return  [userDefaults boolForKey:@"IAP10"];
//}
//-(void)setIAP10:(BOOL)IAP10{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:IAP10 forKey:@"IAP10"];
//    [userDefaults synchronize];
//}

#pragma mark - inApp PURCHASE
-(void)purchaseIAP1{
       
    if([SKPaymentQueue canMakePayments]){
        CountBuy=1;
        NSLog(@"User can make payments");
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier1]];
        productsRequest.delegate = self;
        [productsRequest start];
        connectingView.hidden = NO;
    }else{
        [self FailedAlert];
    }
}
//-(void)purchaseIAP2{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier2]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}
//-(void)purchaseIAP3{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier3]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}
//-(void)purchaseIAP4{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier4]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}
//-(void)purchaseIAP5{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier5]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}
//-(void)purchaseIAP6{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier6]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}
//-(void)purchaseIAP7{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier7]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}
//-(void)purchaseIAP8{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier8]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}
//-(void)purchaseIAP9{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier9]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}
//-(void)purchaseIAP10{
//    if([SKPaymentQueue canMakePayments]){
//        CountBuy=1;
//        NSLog(@"User can make payments");
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kIAPProductIdentifier10]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        connectingView.hidden = NO;
//    }else{
//        [self FailedAlert];
//    }
//}

-(void)FailedAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops."
                                                    message:@"I don't think you are allowed to make in-app purchases."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    //this is called the user cannot make payments, most likely due to parental controls
}


-(void)restore{
    //this is called when the user restores purchases, you should hook this up to a button
    connectingView.hidden = NO;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    
    //NSSet *productIdentifiers = [NSSet setWithObjects:kRemoveAdsProductIdentifier1,kRemoveAdsProductIdentifier2, kRemoveAdsProductIdentifier3, nil];
    
    int count = (int)[response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        NSLog(@"No products available");
        connectingView.hidden = YES;
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (void)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %i",(int) queue.transactions.count);
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        if(SKPaymentTransactionStateRestored){
            NSLog(@"Transaction state -> Restored");
            //called when the user successfully restores a purchase
            
            [self UnlockIAP:transaction];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
            break;
        }
        
    }
    connectingView.hidden = YES;
    
}
-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"%@",error);
    connectingView.hidden = YES;
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStateDeferred: NSLog(@"Transaction state -> Deferred");
                //[self doRemoveAds3];
                //called when the user is in the process of purchasing, do not add any of your own code here.
                connectingView.hidden = YES;
                
                // Allow the user to continue to use the app connectingView.hidden = YES; break;
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                NSLog(@"%@",transaction);//transactions
                [self UnlockIAP:transaction];
                connectingView.hidden = YES;
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                
                // [[AppUserDefaults sharedAppUserDefaults]setNoAds:YES];
                //[[AppUserDefaults sharedAppUserDefaults]setDrums:YES];
                NSLog(@"%@",transaction);//transactions
                [self UnlockIAP:transaction];
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                
                connectingView.hidden = YES;
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finnish
                if(transaction.error.code != SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                connectingView.hidden = YES;
                break;
        }
    }
    
}
- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    if (transaction.error.code != SKErrorPaymentCancelled){
        // Display an error here.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Unsuccessful"
                                                        message:@"Your purchase failed. Please try again."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    connectingView.hidden = YES;
    // Finally, remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
-(void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
    connectingView.hidden = YES;
    
}

#pragma mark - Store Methods

- (void)UnlockIAP:(SKPaymentTransaction *)transaction {
    
    // test which product needs to be unlocked
    
    NSLog(@"ProductID: %@",transaction.payment.productIdentifier);
    
    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier1]) {
        [self purchasedCompleteIAP1];
    }
    
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier2]) {
//        [self purchasedCompleteIAP2];
//    }
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier3]) {
//        [self purchasedCompleteIAP3];
//    }
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier4]) {
//        [self purchasedCompleteIAP4];
//    }
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier5]) {
//        [self purchasedCompleteIAP5];
//    }
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier6]) {
//        [self purchasedCompleteIAP6];
//    }
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier7]) {
//        [self purchasedCompleteIAP7];
//    }
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier8]) {
//        [self purchasedCompleteIAP8];
//    }
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier9]) {
//        [self purchasedCompleteIAP9];
//    }
//    if ([transaction.payment.productIdentifier isEqualToString:kIAPProductIdentifier10]) {
//        [self purchasedCompleteIAP10];
//    }
}

-(void)purchasedCompleteIAP1{
    [self setIAP1:YES];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
//-(void)purchasedCompleteIAP2{
//    [self setIAP2:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//-(void)purchasedCompleteIAP3{
//    [self setIAP3:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//-(void)purchasedCompleteIAP4{
//    [self setIAP4:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//-(void)purchasedCompleteIAP5{
//    [self setIAP5:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//-(void)purchasedCompleteIAP6{
//    [self setIAP6:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//-(void)purchasedCompleteIAP7{
//    [self setIAP7:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//-(void)purchasedCompleteIAP8{
//    [self setIAP8:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//-(void)purchasedCompleteIAP9{
//    [self setIAP9:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//-(void)purchasedCompleteIAP10{
//    [self setIAP10:YES];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
//                                                    message:@"Thanks for your support. Now, go play some more Tiny Drums Ad-Free!"
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}




//if ([[IAPHelper sharedAppUserDefaults]getIAD1]) {}


@end
