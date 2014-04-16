//
//  ParseXMLUtil.h
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseXMLUtil : NSObject

+ (NSDictionary *) parseSystemConfigXML;
+ (NSArray *) parseCatalogXML;
+ (NSArray *) parseBankXML;
+ (NSArray *) parsePhoneRechargeXML;
+ (NSDictionary *) parseHistoryTypeXML;
+ (NSDictionary *) parseReversalMapXML;
+ (NSDictionary *) parseTransferMapXML;
+ (NSArray *) parseConfigXML:(NSString *) transferCode;

@end
