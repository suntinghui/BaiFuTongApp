//
//  ParseXMLUtil.m
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "ParseXMLUtil.h"
#import "TBXML.h"
#import "CatalogModel.h"
#import "SystemConfig.h"
#import "BankModel.h"
#import "RechargeModel.h"
#import "FileOperatorUtil.h"
#import "FieldModel.h"

@implementation ParseXMLUtil

+ (NSDictionary *) parseSystemConfigXML
{
    NSError *error = nil;
    TBXML *tbXML = [[TBXML alloc] initWithXMLData:[FileOperatorUtil getDataFromXML:@"systemconfig.xml"] error:&error];
    if (error) {
        NSLog(@"%@->ParseSystemConfigXML:%@", [self class] ,[error localizedDescription]);
        return nil;
    }
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        TBXMLElement *itemElement = [TBXML childElementNamed:@"item" parentElement:rootElement];
        while (itemElement) {
            NSString *key = [TBXML valueOfAttributeNamed:@"key" forElement:itemElement];
            NSString *value = [TBXML valueOfAttributeNamed:@"value" forElement:itemElement];
            [dic setObject:value forKey:key];
            itemElement = [TBXML nextSiblingNamed:@"item" searchFromElement:itemElement];
        }
        return dic;
    }
    return nil;
}

// 因为有的属性可能不存在导致程序崩溃，所以更改了TBXML的源代码：TBXML.m at 316
+ (NSArray *) parseCatalogXML
{
    TBXML *tbXML;
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"catalog.xml"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSString *xmlContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        tbXML = [[TBXML alloc] initWithXMLData:[xmlContent dataUsingEncoding:NSUTF8StringEncoding] error:nil];
        
    } else {
        NSError *error = nil;
        tbXML = [[TBXML alloc] initWithXMLFile:@"catalog.xml" error:&error];
        if (error) {
            NSLog(@"%@->parseCatalogXML:%@", [self class], [error localizedDescription]);
            return nil;
        }
    }
    
    
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        NSMutableArray *array = [NSMutableArray array];
        TBXMLElement *catalogElement = [TBXML childElementNamed:@"catalog" parentElement:rootElement];
        while (catalogElement) {
            CatalogModel *model = [[CatalogModel alloc] init];
            
            [model setCatalogId:[[TBXML textForElement:[TBXML childElementNamed:@"catalogId" parentElement:catalogElement]] integerValue]];
            [model setTitle:[TBXML textForElement:[TBXML childElementNamed:@"title" parentElement:catalogElement]]];
            [model setParentId:[[TBXML textForElement:[TBXML childElementNamed:@"parentId" parentElement:catalogElement]] integerValue]];
            [model setActionId:[TBXML textForElement:[TBXML childElementNamed:@"actionId" parentElement:catalogElement]]];
            [model setAction:[TBXML textForElement:[TBXML childElementNamed:@"action" parentElement:catalogElement]]];
            [model setActionType:[TBXML textForElement:[TBXML childElementNamed:@"actionType" parentElement:catalogElement]]];
            [model setIconId:[[TBXML textForElement:[TBXML childElementNamed:@"iconId" parentElement:catalogElement]] integerValue]];
            
            [array addObject:model];
            
            catalogElement = [TBXML nextSiblingNamed:@"catalog" searchFromElement:catalogElement];
        }
        return array;
    }
    
    return nil;
    
}

+ (NSArray *) parseBankXML
{
    NSError *error = nil;
    TBXML *tbXML = [[TBXML alloc] initWithXMLData:[FileOperatorUtil getDataFromXML:@"bank.xml"] error:&error];
    if (error) {
        NSLog(@"%@->parseBankXML:%@", [self class] ,[error localizedDescription]);
        return nil;
    }
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        NSMutableArray *array = [NSMutableArray array];
        TBXMLElement *bankElement = [TBXML childElementNamed:@"bank" parentElement:rootElement];
        while (bankElement) {
            NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:bankElement];
            NSString *code = [TBXML valueOfAttributeNamed:@"code" forElement:bankElement];
//            BankModel *bank = [[BankModel alloc] init];
//            [bank setName:name];
//            [bank setCode:code];
//            [array addObject:bank];
            
            bankElement = [TBXML nextSiblingNamed:@"bank" searchFromElement:bankElement];
        }
        
        return array;
    }
    
    return nil;
}

+ (NSArray *) parsePhoneRechargeXML
{
    NSError *error = nil;
    TBXML *tbXML = [[TBXML alloc] initWithXMLData:[FileOperatorUtil getDataFromXML:@"phonerecharge.xml"] error:&error];
    if (error) {
        NSLog(@"%@->parsePhoneRechargeXML:%@", [self class] ,[error localizedDescription]);
        return nil;
    }
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        NSMutableArray *array = [NSMutableArray array];
        TBXMLElement *rechargeElement = [TBXML childElementNamed:@"item" parentElement:rootElement];
        while (rechargeElement) {
            NSString *key = [TBXML valueOfAttributeNamed:@"key" forElement:rechargeElement];
            NSString *value = [TBXML valueOfAttributeNamed:@"value" forElement:rechargeElement];
            RechargeModel *model = [[RechargeModel alloc] init];
            [model setFaceValue:key];
            [model setSellingPrice:value];
            [array addObject:model];
            
            rechargeElement = [TBXML nextSiblingNamed:@"item" searchFromElement:rechargeElement];
        }
        
        return array;
    }
    
    return nil;
}

+ (NSDictionary *) parseHistoryTypeXML
{
    NSError *error = nil;
    TBXML *tbXML = [[TBXML alloc] initWithXMLData:[FileOperatorUtil getDataFromXML:@"queryhistorymap.xml"] error:&error];
    if (error) {
        NSLog(@"%@->parseHistoryTypeXML:%@", [self class] ,[error localizedDescription]);
        return nil;
    }
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        TBXMLElement *typeElement = [TBXML childElementNamed:@"item" parentElement:rootElement];
        while (typeElement) {
            NSString *key = [TBXML valueOfAttributeNamed:@"key" forElement:typeElement];
            NSString *value = [TBXML valueOfAttributeNamed:@"value" forElement:typeElement];
            [dic setObject:value forKey:key];
            
            typeElement = [TBXML nextSiblingNamed:@"item" searchFromElement:typeElement];
        }
        
        return dic;
    }
    
    return nil;
}

+ (NSDictionary *) parseReversalMapXML
{
    NSError *error = nil;
    TBXML *tbXML = [[TBXML alloc] initWithXMLData:[FileOperatorUtil getDataFromXML:@"reversalmap.xml"] error:&error];
    if (error) {
        NSLog(@"%@->parseReversalMapXML:%@", [self class] ,[error localizedDescription]);
        return nil;
    }
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        TBXMLElement *typeElement = [TBXML childElementNamed:@"item" parentElement:rootElement];
        while (typeElement) {
            NSString *key = [TBXML valueOfAttributeNamed:@"key" forElement:typeElement];
            NSString *value = [TBXML valueOfAttributeNamed:@"value" forElement:typeElement];
            [dic setObject:value forKey:key];
            
            typeElement = [TBXML nextSiblingNamed:@"item" searchFromElement:typeElement];
        }
        
        return dic;
    }
    
    return nil;
}

+ (NSDictionary *) parseTransferMapXML
{
    NSError *error = nil;
    TBXML *tbXML = [[TBXML alloc] initWithXMLData:[FileOperatorUtil getDataFromXML:@"transfername.xml"] error:&error];
    if (error) {
        NSLog(@"%@->parseTransferMapXML:%@", [self class] ,[error localizedDescription]);
        return nil;
    }
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        TBXMLElement *typeElement = [TBXML childElementNamed:@"item" parentElement:rootElement];
        while (typeElement) {
            NSString *code = [TBXML valueOfAttributeNamed:@"code" forElement:typeElement];
            NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:typeElement];
            [dic setObject:name forKey:code];
            
            typeElement = [TBXML nextSiblingNamed:@"item" searchFromElement:typeElement];
        }
        
        return dic;
    }
    
    return nil;
}

+ (NSArray *) parseConfigXML:(NSString *) transferCode
{
    NSMutableArray *fieldArray = [[NSMutableArray alloc] init];
    
    NSError *error = nil;
    TBXML *tbXML = [[TBXML alloc] initWithXMLData:[FileOperatorUtil getDataFromXML:[NSString stringWithFormat:@"con_req_%@.xml", transferCode]] error:&error];
    if (error) {
        NSLog(@"%@->parseConfigXML:%@", [self class] ,[error localizedDescription]);
        return nil;
    }
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        TBXMLElement *fieldElement = [TBXML childElementNamed:@"field" parentElement:rootElement];
        while (fieldElement) {
            FieldModel *model = [[FieldModel alloc] init];
            
            [model setKey:[TBXML valueOfAttributeNamed:@"key" forElement:fieldElement]];
            [model setValue:[TBXML valueOfAttributeNamed:@"value" forElement:fieldElement]];
            [model setMac:[TBXML valueOfAttributeNamed:@"macField" forElement:fieldElement]];
            
            [fieldArray addObject:model];
            
            fieldElement = [TBXML nextSiblingNamed:@"field" searchFromElement:fieldElement];
        }
        
        return fieldArray;
    }
    
    return nil;
}

@end
