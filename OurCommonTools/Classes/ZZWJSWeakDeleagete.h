//
//  ZZWJSWeakDeleagete.h
//  botella
//
//  Created by 周泽文 on 2018/10/8.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>



@interface ZZWJSWeakDeleagete : NSObject<WKScriptMessageHandler>
@property(nonatomic,assign)id<WKScriptMessageHandler>jsDelegate;
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)jsDelegate;

@end
