//
//  ZZWTool.m
//  botella
//
//  Created by 周泽文 on 2018/9/20.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "ZZWTool.h"
#include <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
@implementation ZZWTool
+(NSInteger)getNumberFromString:(NSString *)str{
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *numStr = [[str componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
    return [numStr integerValue];

}
+(NSAttributedString *)configAttributedStrWithTexts:(NSArray *)textArr attributeArr:(NSArray *)attributeArr{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    for (NSInteger i=0; i < textArr.count; i++) {
        [attStr appendAttributedString: [[NSMutableAttributedString alloc] initWithString:textArr[i] attributes:attributeArr[i]]];
    }
    return attStr;
}
+(void)setView:(UIView *)view CornerWithTopLeftCorner:(CGFloat)topLeft topRightCorner:(CGFloat)topRight bottomLeftCorner:(CGFloat)bottemLeft bottomRightCorner:(CGFloat)bottemRight bounds:(CGRect)bounds{
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    maskPath.lineWidth = 1.0;
    maskPath.lineCapStyle = kCGLineCapRound;
    maskPath.lineJoinStyle = kCGLineJoinRound;
    [maskPath moveToPoint:CGPointMake(bottemRight, height)]; //左下角
    [maskPath addLineToPoint:CGPointMake(width - bottemRight, height)];
    
    [maskPath addQuadCurveToPoint:CGPointMake(width, height- bottemRight) controlPoint:CGPointMake(width, height)]; //右下角的圆弧
    [maskPath addLineToPoint:CGPointMake(width, topRight)]; //右边直线
    
    [maskPath addQuadCurveToPoint:CGPointMake(width - topRight, 0) controlPoint:CGPointMake(width, 0)]; //右上角圆弧
    [maskPath addLineToPoint:CGPointMake(topLeft, 0)]; //顶部直线
    
    [maskPath addQuadCurveToPoint:CGPointMake(0, topLeft) controlPoint:CGPointMake(0, 0)]; //左上角圆弧
    [maskPath addLineToPoint:CGPointMake(0, height - bottemLeft)]; //左边直线
    [maskPath addQuadCurveToPoint:CGPointMake(bottemLeft, height) controlPoint:CGPointMake(0, height)]; //左下角圆弧

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+(void)cutView:(UIView *)view radio:(CGFloat)radio cornors:(UIRectCorner)corners style:(NSInteger)style{
    if (style == 1) {
        view.layer.cornerRadius = radio;
        view.layer.masksToBounds = YES;
    }else if (style == 2) {
        UIBezierPath *maskBezierPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radio, radio)];
        CAShapeLayer *maskShapeLayer = [[CAShapeLayer alloc]init];
        maskShapeLayer.frame = view.bounds;
        maskShapeLayer.path = maskBezierPath.CGPath;
        view.layer.mask = maskShapeLayer;
    }else if (style == 3) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
        [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.frame.size.width] addClip];
        [view drawRect:view.bounds];
//        view.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}
+(NSArray *)getElementsSorteRandomArrWithArr:(NSArray *)arr{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:arr];
    int i = (int)[array count];
    while(--i > 0) {
        int j = rand() % (i+1);
        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
   
    NSLog(@"nutableArray :%@",array);
    return array;
}
//+(void)createImages:(NSArray *)imgUrlArr atView:(UIView *)view width:(CGFloat)width space:(CGFloat)space style:(NSInteger)style direction:(NSInteger)direction{
//    if (imgUrlArr.count == 0) {
//        return;
//    }
//    CGFloat spaceX = 0;
//    CGFloat spaceY = 0;
//    if (direction == 0) {
//        for (int i = 0; i < imgUrlArr.count; i ++) {
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceX + i * space, spaceY, width, width)];
//            imageView.layer.cornerRadius = width/2;
//            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//            imageView.layer.borderWidth = 1;
//            imageView.clipsToBounds = YES;
//            if (style == 2) {
//                imageView.image = [UIImage imageNamed:imgUrlArr[i]];
//            }else{
//                [imageView sd_setImageWithURL: [NSURL URLWithString:imgUrlArr[i]]];
//            }
//
//            [view addSubview:imageView];
//            if (style == 1) {
//                if (i == imgUrlArr.count - 1) {
//
//                    //模糊的效果
//                    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//                    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
//                    visualEffectView.frame = imageView.bounds;
//                    visualEffectView.alpha = 0.7;
//                    [imageView addSubview:visualEffectView];
//                    // 省略号
//                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(spaceX + i * 43, spaceY - 5, width, width)];
//                    label.font = [UIFont systemFontOfSize:26];
//                    label.text = @"...";
//                    label.textAlignment = NSTextAlignmentCenter;
//                    label.textColor = [UIColor whiteColor];
//                    [view addSubview:label];
//                }
//            }
//
//        }
//    }else{
//        for (NSInteger i = imgUrlArr.count -1; i >=  0; i --) {
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceX + i * space, spaceY, width, width)];
//            imageView.layer.cornerRadius = width/2;
//            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//            imageView.layer.borderWidth = 1;
//            imageView.clipsToBounds = YES;
//            if (style == 2) {
//                imageView.image = [UIImage imageNamed:imgUrlArr[i]];
//            }else{
//                [imageView sd_setImageWithURL: [NSURL URLWithString:imgUrlArr[i]]];
//            }
//
//            [view addSubview:imageView];
//            if (style == 1) {
//                if (i == imgUrlArr.count - 1) {
//
//                    //模糊的效果
//                    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//                    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
//                    visualEffectView.frame = imageView.bounds;
//                    visualEffectView.alpha = 0.7;
//                    [imageView addSubview:visualEffectView];
//                    // 省略号
//                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(spaceX + i * 43, spaceY - 5, width, width)];
//                    label.font = [UIFont systemFontOfSize:26];
//                    label.text = @"...";
//                    label.textAlignment = NSTextAlignmentCenter;
//                    label.textColor = [UIColor whiteColor];
//                    [view addSubview:label];
//                }
//            }
//
//        }
//    }
//
//
//}

+(CGFloat)getImgHeightWithSize:(CGSize)size width:(CGFloat)width{
    CGFloat height = 0;
    if (size.width > 0 && size.height > 0) {
        height = (width*size.height)/size.width;
    }
    return height;
}
+(NSString *)getBase64StringWithData:(NSData *)data option:(NSDataBase64EncodingOptions)option{
    // 加密成Base64形式的NSString
    NSString *base64String = [data base64EncodedStringWithOptions:option];
    return base64String;
}
+(BOOL)checkStringContainNumberAndLetter:(NSString *)content{
 
    //正则表达式判断字符串是否同时包含数字和字母
//    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";//限制长度6-18
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [pred evaluateWithObject:content];
    return result;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
UIGraphicsBeginImageContext(rect.size);
CGContextRef context = UIGraphicsGetCurrentContext();
CGContextSetFillColorWithColor(context, [color CGColor]);
CGContextFillRect(context, rect);
UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

return theImage;
}
+(NSString *)getJsonStrWithDictionary:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}

+(NSString *)getJsonStrContainSpaceWithDictionary:(NSDictionary *)dict{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
//    NSRange range = {0,jsonString.length};
    
//    //去掉字符串中的空格
//
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//
    NSRange range2 = {0,mutStr.length};
//
//    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
+(NSString *)getUtf8EncodeWithString:(NSString *)string{
    NSString *result = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

//判断手机号码格式是否正确
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNum;
{
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phoneNum.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phoneNum];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phoneNum];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phoneNum];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+(NSArray *)getRandomArrayWithArray:(NSArray *)arr{
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    return arr;
}

+(CGFloat)getFitWithWithContent:(NSString *)string fontSize:(NSInteger)num{
    /**
     后期要增加 是否超过屏幕宽度的判断
     */
    CGFloat width = 0;
    if (num == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        label.text = string;
        label.font = FontSize12;
        [label sizeToFit];
        width = label.frame.size.width;
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        label.text = string;
        label.font = [UIFont systemFontOfSize:num];
        [label sizeToFit];
        width = label.frame.size.width;
    }
    return width;
}

+(UIImage *)createQRCodeImageWithContent:(NSString *)content withWidth:(CGFloat)width{
    //1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    // 3. 将字符串转换成NSData
    NSString *urlStr = content;
    NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    // 6. 将CIImage转换成UIImage，并显示于imageView上 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
    
    UIImage *image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:width];//重绘二维码,使其显示清晰
    return image;
}

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+(BOOL)isAllNumbersWithContent:(NSString *)content{
    //方式一
//    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
//    if(content.length > 0) {
//        return NO;
//    }
//    return YES;
    //方式二 正则
    if (content.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:content]) {
        return YES;
    }
    return NO;

}

+(BOOL)isValidEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL result = [emailTest evaluateWithObject:email];
    return result;
}
+(CGFloat)getSizeWithFilePath:(NSURL *)url{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *dic = [fm attributesOfItemAtPath:url.path error:nil];
    unsigned long long size = [[dic objectForKey:NSFileSize] longLongValue];
    float fileSize = 1.0*size/1024;
    NSLog(@"%fM",fileSize/1024);
    return fileSize/1024;
}

+(NSString *)getBase64StringWithImage:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image,1.0f);
    NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

+(UIImage *)getImageWithBase64String:(NSString *)base64String{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}


+(void)savePicture:(UIImage *)image toDocumentPath:(NSString *)path withName:(NSString *)name{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExsit = [fm  fileExistsAtPath:[documentPath stringByAppendingPathComponent:path] isDirectory:&isDir];
    if (!(isDir && isExsit)) {
        [fm createDirectoryAtPath:[documentPath stringByAppendingPathComponent:path] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [UIImagePNGRepresentation(image) writeToFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",path,name]] atomically:YES];
}

+(void)delePicture:(NSString *)name fromDocumentPath:(NSString *)path{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dirPath = [documentPath stringByAppendingPathComponent:path];
    if (name) {
        NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",path,name]];
        NSFileManager *fm = [NSFileManager defaultManager];
        BOOL isFileExsit = [fm fileExistsAtPath:filePath];
        if (isFileExsit) {
            NSError *err = nil;
            [fm removeItemAtPath:filePath error:&err];
            if (err) {
                NSLog(@"%@",err);
            }
        }else{
            NSLog(@"找不到要删除的文件");
        }
    }else{
        NSFileManager *fm = [NSFileManager defaultManager];
        BOOL isFileExsit = [fm fileExistsAtPath:dirPath];
        if (isFileExsit) {
            [fm removeItemAtPath:dirPath error:nil];
        }else{
            NSLog(@"找不到要删除的文件");
        }
    }
    
}

+(UIImage *)getPicture:(NSString *)name fromDocumentPath:(NSString *)path{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    if (name) {
        NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",path,name]];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
        return image;
    }else{
        //后续可以设置默认图
        return nil;
    }
}
+(NSString *)getDateWithTimeStamp:(NSString *)timeStamp{
    // timeStamp 是服务器返回的13位时间戳

    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStamp doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}

+(NSString *)getChineseTimeWithDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //----------格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:date];
    return currentTimeString;
     
}
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"6", @"0", @"1", @"2", @"3", @"4", @"5", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat )width content:(NSString *)content
{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary * attributes = @{
                                  NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
    CGSize textRect = CGSizeMake(width, MAXFLOAT);
    CGFloat textHeight = [content boundingRectWithSize: textRect
                                               options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                            attributes:attributes
                                               context:nil].size.height;
    return textHeight;
}

-(NSMutableAttributedString*) changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont systemFontOfSize:20];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,4)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4,needText.length-4)];
    return attrString;
}

+ (NSString *)computeHashForFile:(NSURL *)fileURL {
    NSString *fileContentsHash;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
        NSData *fileContents = [NSData dataWithContentsOfURL:fileURL];
        fileContentsHash = [self computeHashForData:fileContents];
    }
    return fileContentsHash;
}

+ (NSString *)computeHashForData:(NSData *)inputData {
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(inputData.bytes, (CC_LONG)inputData.length, digest);
    NSMutableString *inputHash = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [inputHash appendFormat:@"%02x", digest[i]];
    }
    return inputHash;
}

+(NSDate *)getLaterDateFromDate:(NSDate *)date withYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    return newdate;
}

+ (NSString *)computeHashForString:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

+(void)checkAllFont{
    for (NSString *fontFamilyName in [UIFont familyNames])
    {
        NSLog(@"fontFamilyName:'%@'", fontFamilyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
}

+ (NSDictionary *)getDeviceInfo {
    NSBundle *currentBundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [currentBundle infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *model = [self getDeviceIdentifier];
    
    return @{
        @"osVersion": [[UIDevice currentDevice] systemVersion],
        @"os": @"iOS",
        @"sourceFrom": @"appstore",
        @"model" : model,
        @"uniqueID" : idfv,
        @"appVersion" : appVersion,
        @"brand" : @"iPhone"
    };
}

// 需要#import "sys/utsname.h"
+ (NSString *)getDeviceIdentifier {
    struct utsname systemInfo;
    uname(&systemInfo);
    // 获取设备标识Identifier
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS MAX";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE (2nd generation)";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"]) return @"iPhone 13 mini";
    if ([platform isEqualToString:@"iPhone14,5"]) return @"iPhone 13";
    if ([platform isEqualToString:@"iPhone14,2"]) return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"]) return @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone14,6"]) return @"iPhone SE 3";
    
    // iPod
    if ([platform isEqualToString:@"iPod1,1"])  return @"iPod Touch 1";
    if ([platform isEqualToString:@"iPod2,1"])  return @"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"])  return @"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"])  return @"iPod Touch 4";
    if ([platform isEqualToString:@"iPod5,1"])  return @"iPod Touch 5";
    if ([platform isEqualToString:@"iPod7,1"])  return @"iPod Touch 6";
    if ([platform isEqualToString:@"iPod9,1"])  return @"iPod Touch 7";
    
    // iPad
    if ([platform isEqualToString:@"iPad1,1"])  return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])  return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])  return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])  return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])  return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,6"])  return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,7"])  return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad3,1"])  return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])  return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])  return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])  return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])  return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])  return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"])  return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])  return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])  return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])  return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,5"])  return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,6"])  return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"])  return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])  return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])  return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])  return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])  return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,3"])  return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])  return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])  return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"])  return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,7"])  return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"])  return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,11"])  return @"iPad 5";
    if ([platform isEqualToString:@"iPad6,12"])  return @"iPad 5";
    if ([platform isEqualToString:@"iPad7,1"])  return @"iPad Pro 2(12.9-inch)";
    if ([platform isEqualToString:@"iPad7,2"])  return @"iPad Pro 2(12.9-inch)";
    if ([platform isEqualToString:@"iPad7,3"])  return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"])  return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,5"])  return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,6"])  return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,11"])  return @"iPad 7";
    if ([platform isEqualToString:@"iPad7,12"])  return @"iPad 7";
    if ([platform isEqualToString:@"iPad8,1"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,2"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,3"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,4"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,5"])  return @"iPad Pro 3 (12.9-inch) ";
    if ([platform isEqualToString:@"iPad8,6"])  return @"iPad Pro 3 (12.9-inch) ";
    if ([platform isEqualToString:@"iPad8,7"])  return @"iPad Pro 3 (12.9-inch) ";
    if ([platform isEqualToString:@"iPad8,8"])  return @"iPad Pro 3 (12.9-inch) ";
    if ([platform isEqualToString:@"iPad11,1"])  return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad11,2"])  return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad11,3"])  return @"iPad Air 3";
    if ([platform isEqualToString:@"iPad11,4"])  return @"iPad Air 3";
    
    // 其他
    if ([platform isEqualToString:@"i386"])   return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator";
    
    return platform;
}


@end
