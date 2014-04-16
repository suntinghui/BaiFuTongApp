//
//  FileOperatorUtil.m
//  POS2iPhone
//
//  Created by  STH on 11/30/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "FileOperatorUtil.h"
#import "MKNetworkKit.h"

@interface FileOperatorUtil ()

+ (NSString *) getXMLDirectory;

@end

@implementation FileOperatorUtil

#pragma mark - 复制更新配置文件
+ (NSString *) getXMLDirectory
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *xmlDirectory = [documentsDirectory stringByAppendingPathComponent:@"xml"];
    
    return xmlDirectory;
}

+ (NSData *) getDataFromXML:(NSString *) xmlFileName
{
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.xml", [self getXMLDirectory], [xmlFileName stringByDeletingPathExtension]];
    
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error: &error];
    if (error){
        NSLog(@"%@", [error localizedDescription]);
    }
    return data;
}

+ (void) copyXML2Document
{
    NSArray *dicArray = [NSArray arrayWithObjects:@"Config", @"Data", @"Template", @"View", nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *xmlDirectory = [self getXMLDirectory];
    BOOL isDirectory = NO;
    if (![fileManager fileExistsAtPath:xmlDirectory isDirectory:&isDirectory]) {
        BOOL ok = [fileManager createDirectoryAtPath:xmlDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        if (!ok) {
            [NSException raise:@"创建XML目录失败" format:@"Failed to create a directory %@", xmlDirectory];
        }
        NSLog(@"成功创建Documents -> xml 目录");
    }
    
    for (NSString *dic in dicArray) {
        NSArray *fileArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"xml" inDirectory:[NSString stringWithFormat:@"XML/%@", dic]];
        for (NSString *srcFilePath in fileArray) {
            NSString *fileName = [[srcFilePath componentsSeparatedByString:@"/"] lastObject];
            NSString *dstPath = [NSString stringWithFormat:@"%@/%@",xmlDirectory,fileName];
            
            NSError *error = nil;
            BOOL flag = [fileManager copyItemAtPath:srcFilePath toPath:dstPath error:&error];
            if (!flag) {
                if ([fileManager fileExistsAtPath:dstPath]) {
                    NSLog(@"文件已经存在:%@", fileName);
                } else {
                    NSLog(@"copy file error:%@", error);
                    [NSException raise:@"复制文件失败" format:@"Failed to copy file %@", srcFilePath];
                }
            } else {
                NSLog(@"成功复制文件:%@", fileName);
            }
        }
    }
}

+ (BOOL) updateFiles:(NSInteger) currentVersion newVersion:(NSInteger) newVersion fileNames:(NSString *) fileNames
{
    __block BOOL downloadFlag = YES;
    
    @try {
        if (currentVersion < newVersion) { // 版本号不匹配，进行更新文件
            NSString *versionPreferenceKey = [NSString stringWithFormat:@"Version%dTo%d", currentVersion, newVersion];
            NSString *surplusFiles = @"";
            // 上次有未更新完成的文件
            if ([UserDefaults objectForKey:versionPreferenceKey]) {
                surplusFiles = [UserDefaults objectForKey:versionPreferenceKey];
            } else {
                surplusFiles = fileNames;
            }
            
            // 存储还未完成的文件名
            __block NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            @try {
                if (surplusFiles) {
                    NSArray *fileArray = [[surplusFiles stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@"|"];
                    NSMutableArray *array = [NSMutableArray array];
                    for (NSString *str in fileArray) {
                        [array addObject:str];
                        [tempArray addObject:str];
                    }
                    
                    for (NSString *tempFileName in array) {
                        // 下载并保存文件
                        NSString *fileName = [NSString stringWithFormat:@"%@.xml", [tempFileName stringByDeletingPathExtension]];
                        NSString *path = [[self getXMLDirectory] stringByAppendingPathComponent:fileName];
                        NSString *downloadPath = [NSString stringWithFormat:@"%@%@", FILEURL, fileName];
                        
                        MKNetworkOperation *downloadOperation=[FileOperatorUtil downloadFatAssFileFrom:downloadPath
                                                                                           toFile:path];
                        
                        [downloadOperation addCompletionHandler:^(MKNetworkOperation* completedRequest) {
                            // 一个文件更新成功，则更新UserDefault
                            [tempArray removeObject:tempFileName];
                            
                            downloadFlag = (downloadFlag && YES);
                            
                        }  errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
                            downloadFlag = (downloadFlag && NO);
                        }];
                        
                    }
                    return downloadFlag;
                }
            }
            @catch (NSException *exception) {
                NSLog(@"%@", [exception callStackSymbols]);
                return NO;
            }
            @finally {
                if ([tempArray count] == 0) {
                    if ([UserDefaults objectForKey:versionPreferenceKey]) {
                        [UserDefaults removeObjectForKey:versionPreferenceKey];
                    }
                    
                } else {
                    NSMutableString *mutableString = [[NSMutableString alloc] init];
                    for (NSString *name in tempArray) {
                        [mutableString appendFormat:@"%@|",name];
                    }
                    
                    // 删除最后的|
                    [mutableString deleteCharactersInRange:NSMakeRange([mutableString length]-1, 1)];
                    
                    [UserDefaults setObject:mutableString forKey:versionPreferenceKey];
                }
                
                [UserDefaults synchronize];
            }
            
        } else {
            // 不需要更新文件
            return YES;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", [exception callStackSymbols]);
    }
}

+(MKNetworkOperation*) downloadFatAssFileFrom:(NSString*) remoteURL toFile:(NSString*) filePath {
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithURLString:remoteURL
                                                     params:nil
                                                 httpMethod:@"GET"];
    
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath
                                                            append:NO]];
    [engine enqueueOperation:op];
    return op;
}



/****
 
+ (BOOL) updateFiles:(NSInteger) currentVersion newVersion:(NSInteger) newVersion fileNames:(NSString *) fileNames
{
    __block BOOL downloadFlag = YES;
    
    @try {
        if (currentVersion < newVersion) { // 版本号不匹配，进行更新文件
            NSString *versionPreferenceKey = [NSString stringWithFormat:@"Version%dTo%d", currentVersion, newVersion];
            NSString *surplusFiles = @"";
            // 上次有未更新完成的文件
            if ([UserDefaults objectForKey:versionPreferenceKey]) {
                surplusFiles = [UserDefaults objectForKey:versionPreferenceKey];
            } else {
                surplusFiles = fileNames;
            }
            
            // 存储还未完成的文件名
            __block NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            @try {
                if (surplusFiles) {
                    NSArray *fileArray = [[surplusFiles stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@"|"];
                    NSMutableArray *array = [NSMutableArray array];
                    for (NSString *str in fileArray) {
                        [array addObject:str];
                        [tempArray addObject:str];
                    }
                    
                    for (NSString *tempFileName in array) {
                        // 下载并保存文件
                        NSString *fileName = [NSString stringWithFormat:@"%@.xml", [tempFileName stringByDeletingPathExtension]];
                        
                        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[FILEURL stringByAppendingPathComponent:fileName]]];
                        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                        
                        NSString *path = [[self getXMLDirectory] stringByAppendingPathComponent:fileName];
                        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
                        
                        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                            // 一个文件更新成功，则更新UserDefault
                            [tempArray removeObject:tempFileName];
                            
                            downloadFlag = (downloadFlag && YES);
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            downloadFlag = (downloadFlag && NO);
                        }];
                        
                        
                        [operation start];
                        [operation waitUntilFinished];
                    }
                    return downloadFlag;
                }
            }
            @catch (NSException *exception) {
                NSLog(@"%@", [exception callStackSymbols]);
                return NO;
            }
            @finally {
                if ([tempArray count] == 0) {
                    if ([UserDefaults objectForKey:versionPreferenceKey]) {
                        [UserDefaults removeObjectForKey:versionPreferenceKey];
                    }
                    
                } else {
                    NSMutableString *mutableString = [[NSMutableString alloc] init];
                    for (NSString *name in tempArray) {
                        [mutableString appendFormat:@"%@|",name];
                    }
                    
                    // 删除最后的|
                    [mutableString deleteCharactersInRange:NSMakeRange([mutableString length]-1, 1)];
                    
                    [UserDefaults setObject:mutableString forKey:versionPreferenceKey];
                }
                
                [UserDefaults synchronize];
            }
            
        } else {
            // 不需要更新文件
            return YES;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", [exception callStackSymbols]);
    }
}


+ (void) downloadFile:(NSString *) fileName
{
    fileName = [NSString stringWithFormat:@"%@.xml", [fileName stringByDeletingPathExtension]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[FILEURL stringByAppendingPathComponent:fileName]]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    NSString *path = [[self getXMLDirectory] stringByAppendingPathComponent:fileName];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@", path);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
}

 
 ****/


@end
