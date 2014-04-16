//
//  UploadSignImageDBHelper.h
//  POS2iPhone
//
//  Created by  STH on 1/10/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDBHelper.h"
#import "FMDatabase.h"

@interface UploadSignImageDBHelper : BaseDBHelper

+ (BOOL) createTable:(FMDatabase *) db;

// 在交易成功后添加一个成功的交易，这时是没有签名图片和手机号的。在签完字后Update。
- (BOOL) insertATransfer:(NSString *) traceNum receMobile:(NSString *) receMobile content:(NSDictionary *) contentDic;

- (NSString *) queryReceMobile:(NSString *)traceNum;
// 查询出所有没有成功上传签名图片的交易
// 有可能因为程序被强制关闭或掉电等情况他造成该交易没有签名图片
- (NSArray *) queryNeedUploadSignImageTransfer;

- (NSDictionary *) queryAUploadSignImageTransfer;

- (BOOL) updateUploadFlagSuccess:(NSString *) traceNum;


@end
