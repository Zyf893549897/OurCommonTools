//
//  ZZWEncryption.h
//  botella
//
//  Created by 周泽文 on 2018/9/24.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZWEncryption : NSObject
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;
@end
