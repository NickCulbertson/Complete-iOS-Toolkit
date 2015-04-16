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
//-(BOOL)getIAP3;
//-(void)setIAP3:(BOOL)IAP3;
//-(BOOL)getIAP4;
//-(void)setIAP4:(BOOL)IAP4;
//-(BOOL)getIAP5;
//-(void)setIAP5:(BOOL)IAP5;
//-(BOOL)getIAP6;
//-(void)setIAP6:(BOOL)IAP6;
//-(BOOL)getIAP7;
//-(void)setIAP7:(BOOL)IAP7;
//-(BOOL)getIAP8;
//-(void)setIAP8:(BOOL)IAP8;
//-(BOOL)getIAP9;
//-(void)setIAP9:(BOOL)IAP9;
//-(BOOL)getIAP10;
//-(void)setIAP10:(BOOL)IAP10;

-(void)restore;

-(void)purchaseIAP1;
//-(void)purchaseIAP2;
//-(void)purchaseIAP3;
//-(void)purchaseIAP4;
//-(void)purchaseIAP5;
//-(void)purchaseIAP6;
//-(void)purchaseIAP7;
//-(void)purchaseIAP8;
//-(void)purchaseIAP9;
//-(void)purchaseIAP10;



@end
