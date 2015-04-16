//
//  AppUserDefaults.h
//  ShurikenTap_Template
//
//  Copyright (c) 2014 Company Name. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface IAPHelper : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>{
    int CountBuy;
    UIImageView *connectingView;
}
+ (IAPHelper*) sharedInstance;

//In App Purchases
-(BOOL)getIAP1;
-(void)setIAP1:(BOOL)IAP1;
//-(BOOL)getIAP2;
//-(void)setIAP2:(BOOL)IAP2;

-(void)restore;

-(void)purchaseIAP1;
//-(void)purchaseIAP2;



@end
