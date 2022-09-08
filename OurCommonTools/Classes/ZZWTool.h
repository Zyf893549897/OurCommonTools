//
//  ZZWTool.h
//  botella
//
//  Created by 周泽文 on 2018/9/20.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZWTool : NSObject

/// 获取 字符串中的数字
+(NSInteger)getNumberFromString:(NSString *)str;
/// 拿到label内容不同颜色等配置的string
/// @param textArr 文本数组
/// @param attributeArr 配置数据
+(NSAttributedString *)configAttributedStrWithTexts:(NSArray *)textArr attributeArr:(NSArray *)attributeArr;

/// 切定高变长的圆角
/// @param view 切圆角的view
/// @param topLeft 左上
/// @param topRight 右上
/// @param bottemLeft 左下
/// @param bottemRight 右下
/// @param bounds 圆角
+(void)setView:(UIView *)view CornerWithTopLeftCorner:(CGFloat)topLeft topRightCorner:(CGFloat)topRight bottomLeftCorner:(CGFloat)bottemLeft bottomRightCorner:(CGFloat)bottemRight bounds:(CGRect)bounds;

/// 切圆角
/// @param view 切圆角的view
/// @param radio 圆角大小
/// @param corners 哪几个角要切
/// @param style 切的方式 (1 2 3)
+(void)cutView:(UIView *)view radio:(CGFloat)radio cornors:(UIRectCorner)corners style:(NSInteger)style;
//把一个数组元素随机打乱
+(NSArray *)getElementsSorteRandomArrWithArr:(NSArray *)arr;


/// <#Description#>
/// @param imgUrlArr <#imgUrlArr description#>
/// @param view <#view description#>
/// @param width <#width description#>
/// @param space <#space description#>
/// @param style <#style description#>
/// @param direction 0 从左往右  1 从右往左
//+(void)createImages:(NSArray *)imgUrlArr atView:(UIView *)view width:(CGFloat)width space:(CGFloat)space style:(NSInteger)style direction:(NSInteger)direction;

// 根据宽度和图片宽高，计算出合适的高度
+(CGFloat)getImgHeightWithSize:(CGSize)size width:(CGFloat)width;

+(NSString *)getBase64StringWithData:(NSData *)data option:(NSDataBase64EncodingOptions)option;
/// 判断字符串 是否同时包含数字和字母
/// @param content 字符串内容
+(BOOL)checkStringContainNumberAndLetter:(NSString *)content;

+ (UIImage *)createImageWithColor:(UIColor *)color;


/**
 字典转json

 @param dict 字典
 @return json字符串
 */
+(NSString *)getJsonStrWithDictionary:(NSDictionary *)dict;


/**
 字典转json 包含空格

 @param dict 字典
 @return json字符串
 */
+(NSString *)getJsonStrContainSpaceWithDictionary:(NSDictionary *)dict;


/**
 对字符串进行UTF-8编码：输出str字符串的UTF-8格式

 @param string 需要编码的字符串
 @return utf8编码后的字符串
 */
+(NSString *)getUtf8EncodeWithString:(NSString *)string;



/**
 判断手机号码格式是否正确

 @param phoneNum 手机号
 @return 是否有效的结果
 */
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNum;

/**
 将一个数组的元素随机重新排序

 @param arr 目标数组
 @return 目的数组
 */
+(NSArray *)getRandomArrayWithArray:(NSArray *)arr;

/**
 根据内容和字体大小，计算出宽度

 @param string 内容字符串
 @param num 字体大小，传0表示使用默认大小14
 @return 计算得到的宽度
 */
+(CGFloat)getFitWithWithContent:(NSString *)string fontSize:(NSInteger)num;


/**
 根据给定的内容生成二维码

 @param content 字符串内容
 @param width 宽度
 @return 二维码对象
 */
+(UIImage *)createQRCodeImageWithContent:(NSString *)content withWidth:(CGFloat)width;


/**
 判断字符串中的内容是否全部都是数字

 @param content 字符串
 @return 结果
 */
+(BOOL)isAllNumbersWithContent:(NSString *)content;


/**
 判断是否是合法的邮箱格式

 @param email 邮箱字符串
 @return 结果
 */
+(BOOL)isValidEmail:(NSString *)email;


/**
 获取 相册 或者 沙盒中文件的大小(M)
 
 @param url url路径
 @return 文件大小，单位M
 */
+(CGFloat)getSizeWithFilePath:(NSURL *)url;


/**
 根据图片对象 获取其Base64字符串

 @param image 图片对象
 @return base64字符串内容
 */
+(NSString *)getBase64StringWithImage:(UIImage *)image;

/**
 根据Base64字符串 获取其 图片对象

 @param base64String base64字符串内容
 @return 图片对象
 */
+(UIImage *)getImageWithBase64String:(NSString *)base64String;

/**
 保存图片到沙盒Document目录下 指定文件夹
 
 @param image 图片
 @param path 文件夹名字
 @param name 图片名
 */
+(void)savePicture:(UIImage *)image toDocumentPath:(NSString *)path withName:(NSString *)name;

/**
 从Document目录 指定文件夹 删除图片
 
 @param name 图片名
 @param path 文件夹名
 */
+(void)delePicture:(NSString *)name fromDocumentPath:(NSString *)path;

/**
 从Document目录 获取图片对象
 
 @param name 图片名
 @param path 文件夹名
 */
+(UIImage *)getPicture:(NSString *)name fromDocumentPath:(NSString *)path;

/**
 时间戳转成年月日

 @param timeStamp 时间戳字符串
 @return 年月日字符串
 */
+(NSString *)getDateWithTimeStamp:(NSString *)timeStamp;

/**
 根据日期得到星期

 @param inputDate 日期
 @return 星期
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;


/**
 拿到中国区时间

 @param date 日期
 @return 中国区时间  年月日 时分秒
 */
+(NSString *)getChineseTimeWithDate:(NSDate *)date;
/**
 根据内容、字体、固定宽度 计算高度

 @param font 字体
 @param width 宽度
 @param content 内容
 @return 高度
 */
+(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat )width content:(NSString *)content;


/// 根据某个时间的计算前/后 几年几个月几日的时间
/// @param date 一个时间点 可以是当前日期
/// @param year 正数就是未来的年份，负数就是过去的事件
/// @param month 月份
/// @param day 日期
+(NSDate *)getLaterDateFromDate:(NSDate *)date withYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSString *)computeHashForFile:(NSURL *)fileURL;
+ (NSString *)computeHashForData:(NSData *)inputData;

+(void)checkAllFont;

/// 获取设备信息
+ (NSDictionary *)getDeviceInfo;
@end

NS_ASSUME_NONNULL_END
