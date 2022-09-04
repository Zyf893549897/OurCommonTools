//
//  UIImage+Circle.h
//  botella
//
//  Created by coding on 2022/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Circle)

///将UIImage图像切成圆形的图像, 指定宽度(边长)
- (UIImage *)circleImageWithWidth:(double)width;
 
///切成圆形的图片
- (UIImage *)cuttingCicleImageWithSize:(CGSize)size;
 
///缩放图片尺寸
- (UIImage *)zoomImageToSize:(CGSize)size;
 
///按照比例缩放图片, 原始图片为1, 参数(0~1)
- (UIImage *)zoomImageWithScale:(float)scale;

@end

NS_ASSUME_NONNULL_END
