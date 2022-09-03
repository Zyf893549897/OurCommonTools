//
//  PurchaseInAppManager.m
//  MLIAPurchaseManager
//
//  Created by coding on 2022/4/9.
//  Copyright © 2022 mali. All rights reserved.
//

#import "PurchaseInAppManager.h"
// 1.首先导入支付包
#import <StoreKit/StoreKit.h>

@interface PurchaseInAppManager ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>{
    NSString           *_currentPurchasedID;
}
@end
@implementation PurchaseInAppManager

static PurchaseInAppManager *purchaseInAppManager = nil;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        purchaseInAppManager = [[PurchaseInAppManager alloc] init];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:purchaseInAppManager];
    });
    return purchaseInAppManager;
}

-(instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)buyProductWithID:(NSString *)productId{
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"开始准备购买");
        _currentPurchasedID = productId;
        SKProductsRequest *productRequest = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:productId]];
        productRequest.delegate = self;
        [productRequest start];
    }
    else {
        if (_delegate && [_delegate respondsToSelector:@selector(payFailedWithError:)]) {
            [_delegate payFailedWithError:@"不支持支付"];
        }
    }
}


-(void)completePurchase{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

#pragma mark - ================ SKRequestDelegate =================

- (void)requestDidFinish:(SKRequest *)request {
    if ([request isKindOfClass:[SKReceiptRefreshRequest class]]) {
//        NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
//        NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
//        [_delegate successedWithReceipt:receiptData];
    }
}


#pragma mark - ================ SKProductsRequest Delegate =================

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSArray *productArr = response.products;
    if (productArr.count > 0) {
        
        SKProduct *p = nil;
            for(SKProduct *pro in productArr){
                if([pro.productIdentifier isEqualToString:_currentPurchasedID]){
                    p = pro;
                    break;
                }
            }
        
        #if DEBUG
            NSLog(@"productID:%@", response.invalidProductIdentifiers);
            NSLog(@"产品付费数量:%lu",(unsigned long)[productArr count]);
            NSLog(@"产品描述:%@",[p description]);
            NSLog(@"产品标题%@",[p localizedTitle]);
            NSLog(@"产品本地化描述%@",[p localizedDescription]);
            NSLog(@"产品价格：%@",[p price]);
            NSLog(@"产品productIdentifier：%@",[p productIdentifier]);
        #endif
        
        
        
        // 12.发送购买请求
        SKPayment *payment = [SKPayment paymentWithProduct:productArr.firstObject];
        [[SKPaymentQueue defaultQueue] addPayment:payment];

    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(payFailedWithError:)]) {
            [_delegate payFailedWithError:@"无法获取产品信息，购买失败"];
        }
    }
}

#pragma mark - ================ SKPaymentTransactionObserver Delegate =================

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing: //商品添加进列表
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStatePurchased://交易成功
                [self completeTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已购买过该商品
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateDeferred://交易延迟
                break;
            default:
                break;
        }
    }
}

#pragma mark - ================ Private Methods =================

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"支付成功");
    

    //目前苹果公司提倡的获取购买凭证的方法
   NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
   NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
   //base64位的产品验证码单，base64是服务端和苹果进行校验所必须的，苹果的文档要求凭证经过Base64加密
   NSString * transactionReceiptString = [receiptData base64EncodedStringWithOptions:0];
    
   //将加密后的transactionReceiptString发送给后台服务端进行校验，在此之前，记得先保存购买凭证
    
    //发送凭证后端服务器验证
    if (_delegate && [_delegate respondsToSelector:@selector(transaction:paySuccessFunctionWithResult:)]) {
        [_delegate transaction:transaction.transactionIdentifier paySuccessFunctionWithResult:transactionReceiptString];
    }
    
    //发送凭证苹果服务器验证
//    [self verifyPurchaseWithPaymentTrasactionWithSandBox:YES];
    
   //完整结束此次在App Store的交易，没有这句代码的调用，下次购买会提示已经购买该商品
   [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
    
}


- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"failedTransaction");
    if (transaction.error.code == SKErrorPaymentCancelled) {
        NSLog(@"用户取消交易。");
        if (_delegate && [_delegate respondsToSelector:@selector(payFailedWithError:)]) {
            [_delegate payFailedWithError:@"用户取消交易"];
        }
    }else if(transaction.error.code == SKErrorUnknown){
        if (_delegate && [_delegate respondsToSelector:@selector(payFailedWithError:)]) {
            [_delegate payFailedWithError:@"未知错误"];
        }
        NSLog(@"%@",transaction.error.localizedDescription);
    }

    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];

}

    
/*
 * 发送到苹果服务器验证凭证
 */

// 二次验证（沙盒还是正式环境）
- (void)verifyPurchaseWithPaymentTrasactionWithSandBox:(BOOL)sandBox{
    
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    if (!receiptData) {
        NSLog(@"没有数据");
    }
    // 发送网络POST请求，对购买凭据进行验证
    //测试验证地址:https://sandbox.itunes.apple.com/verifyReceipt
    //正式验证地址:https://buy.itunes.apple.com/verifyReceipt
    
    NSString *url;
    if (sandBox == YES) {
        url = @"https://sandbox.itunes.apple.com/verifyReceipt";
    } else {
        url = @"https://buy.itunes.apple.com/verifyReceipt";
    }
    
    // 根据苹果官方文档来操作 https://developer.apple.com/library/content/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html

    NSDictionary *requestContents = @{@"receipt-data":[receiptData base64EncodedStringWithOptions:0]};
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = requestData;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
//                [APP_WIN makeToast:error.domain duration:2 position:CSToastPositionCenter];
            } else {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dict);
                if ([dict[@"status"] isEqual:@0]) {// 正确
                    // 发数据给自己公司后台
//                    [self checkPayment];

                } else if([dict[@"status"] isEqual:@21007]){
                    // 此收据来自测试环境，但已发送至生产环境进行验证。切换环境
                    [self verifyPurchaseWithPaymentTrasactionWithSandBox:YES];
                }
            }
        });

    }];
    
    [dataTask resume];
    
}

@end
