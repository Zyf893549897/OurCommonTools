//
//  PurchaseInAppManager.h
//  MLIAPurchaseManager
//
//  Created by coding on 2022/4/9.
//  Copyright © 2022 mali. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PurchaseInAppManagerDelegate <NSObject>
@optional
-(void)payFailedWithError:(NSString *)errorStr;

-(void)transaction:(NSString *)transactionId paySuccessFunctionWithResult:(NSString *)result;

@end

@interface PurchaseInAppManager : NSObject
+ (instancetype)sharedManager;

@property(nonatomic ,weak) id<PurchaseInAppManagerDelegate> delegate;

-(void)buyProductWithID:(NSString *)productId;
-(void)completePurchase;
@end

NS_ASSUME_NONNULL_END
