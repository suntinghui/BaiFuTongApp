//
//  FileOperatorUtil.h
//  POS2iPhone
//
//  Created by  STH on 11/30/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperatorUtil : NSObject

// 将指定的文件名转化成NSData
+ (NSData *) getDataFromXML:(NSString *) xmlFildName;
// 将资源文件XML下的所有XML文件拷贝到Documents下
+ (void) copyXML2Document;

//+ (void) downloadFile:(NSString *) fileName;

+ (BOOL) updateFiles:(NSInteger) currentVersion newVersion:(NSInteger) newVersion fileNames:(NSString *) fileNames;

@end
