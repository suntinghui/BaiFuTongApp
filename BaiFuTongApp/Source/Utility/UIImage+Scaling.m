//
//  UIImage+Scaling.m
//  POS2iPhone
//
//  Created by  STH on 2/2/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "UIImage+Scaling.h"

@implementation UIImage (Scaling)

/***
 
 1、创建UIImage的类别，添加图像压缩指定大小方法 imageByScalingAndCroppingForSize:(CGSize)targetSize; 此方法传入一个压缩图像大小以后的高度和宽度。（第一部分代码）
 2、实现UIImageExt类别，初始化图像缩放默认值。（9-19）
 3、然后检查是否需要进行图像缩放。（21）
 4、如果需要缩放，则计算先分别计算高度、宽度的因子。（23-24）
 5、选择因子系数最大的一边作为图像的缩放因子。（26-29）
 6、根据前面得到的图像缩放因子得到缩放图像的等比例高度和宽度值。（30-31）
 7、由于是按照最大系数一边进行缩放，造成其中另外一边会出现空白，所以需要计算出另外一边居中显示的坐标值。（34-42）
 8、最后根据最新合成的Origin和Size在画布完成内容绘制。（45-52）
 9、保存为UIImage对象。（54-56）
 10、关闭画图，返回UIImage对象。（59-60）
 
 ****/

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
