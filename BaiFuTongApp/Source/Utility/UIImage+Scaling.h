//
//  UIImage+Scaling.h
//  POS2iPhone
//
//  Created by  STH on 2/2/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Scaling)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
