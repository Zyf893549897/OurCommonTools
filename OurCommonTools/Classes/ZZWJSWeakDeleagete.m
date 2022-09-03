//
//  ZZWJSWeakDeleagete.m
//  botella
//
//  Created by 周泽文 on 2018/10/8.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "ZZWJSWeakDeleagete.h"

@implementation ZZWJSWeakDeleagete
-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>)jsDelegate{
    self = [super init];
    if (self) {
        _jsDelegate = jsDelegate;
    }
    return self;
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if (_jsDelegate) {
        [_jsDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}
@end
